#include "node.h"

class NodeData : public QSharedData
{
public:

};

NodeBackend::NodeBackend(QQuickItem *parent) :QQuickItem(parent),
    data(new NodeData), m_color(Qt::red), m_needUpdate(true)
{
    QQuickItem::setFlag(QQuickItem::ItemHasContents);
}

NodeBackend::NodeBackend(const NodeBackend &rhs) :QQuickItem(Q_NULLPTR), data(rhs.data)
{

}

NodeBackend &NodeBackend::operator=(const NodeBackend &rhs)
{
    if (this != &rhs)
        data.operator=(rhs.data);
    return *this;
}

NodeBackend::~NodeBackend()
{
    
}

QSGNode *NodeBackend::updatePaintNode(QSGNode *oldNode, QQuickItem::UpdatePaintNodeData *updatePaintNodeData)
{
    Q_UNUSED(updatePaintNodeData)
    QSGSimpleRectNode *root = static_cast<QSGSimpleRectNode *>(oldNode);

    if(!root){
        root = new QSGSimpleRectNode();
        root->setColor(Qt::black);
    }
    root->setRect(boundingRect());

    return root;
}

QColor NodeBackend::color() const
{
    return m_color;
}

void NodeBackend::setColor(const QColor &color)
{
    if(m_color != color) {
        m_color = color;
        m_needUpdate = true;
        update();
        colorChanged();
    }
}

quint8 NodeBackend::type() const
{
    return m_type;
}

void NodeBackend::setType(const quint8 &type)
{
    if(m_type != type){
        m_type = type;
        typeChanged();
    }
}

QObject* NodeBackend::loadComponent(const QString file)
{
    QQmlEngine m_engine;
    QQmlComponent component(&m_engine,
            QUrl::fromLocalFile(file));
    return component.create();
}
