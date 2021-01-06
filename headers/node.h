#ifndef NODE_H
#define NODE_H

#include <QQmlComponent>
#include <QQuickItem>
#include <QInputEvent>
#include <QSGSimpleRectNode>
#include <QSGFlatColorMaterial>
#include <QQmlEngine>
#include <QSharedDataPointer>

#include "iolist.h"

//namespace NodeType {
//}

class NodeData;

class NodeBackend : public QQuickItem
{
    enum Input {
        SWITCH = 0
    };

    enum Gate{
        AND = 10,
        OR,
        NAND,
        NOR,
        XAND,
        XOR
    };
    enum Output {
        LAMP = 20
    };

    Q_OBJECT
        Q_ENUM(NodeBackend::Input)
        Q_ENUM(NodeBackend::Gate)
        Q_ENUM(NodeBackend::Output)

        Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged)
        Q_PROPERTY(quint8 type READ type WRITE setType NOTIFY typeChanged)
    QML_ELEMENT
public:
    NodeBackend(QQuickItem *parent = Q_NULLPTR);
    NodeBackend(const NodeBackend &);
    NodeBackend &operator=(const NodeBackend &);
    ~NodeBackend();


    //InputList m_inputs{this};
    //QQmlListProperty <QObject> inputs() const;
signals:

    void colorChanged();
    void typeChanged();

protected:

    QSGNode *updatePaintNode(QSGNode *oldNode, UpdatePaintNodeData *updatePaintNodeData);
    
    QColor color() const;
    void setColor(const QColor &color);

    quint8 type() const;
    void setType(const quint8 &type);


private:

    QObject* loadComponent(const QString file);


    //OutputList m_outputs{this};

    QSharedDataPointer<NodeData> data;
    QColor m_color;
    //QList<QObject> m_inputs;
    quint8 m_type;
    bool m_needUpdate;
};

#endif // NODE_H
