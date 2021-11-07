#include "nodebackend.h"

void NodeBackend::update()
{
    //Returning, if no target is set
    if ( !m_target )
        return;

    //setting slotModel (6th child of basicGate)
    if ( !m_slotModel) {
        m_slotModel = qobject_cast<QObject*>(parent()->children().at(9));
    }

    //Calling the node processing algorithm
    updatederived();
}

QObject *NodeBackend::createNode( QObject* parent, NodeType::All type, int x = 0, int y = 0)
{
    QQmlEngine *engine = qmlEngine(parent->parent()->parent());
    QQmlComponent comp( engine );
    QObject* obj;
    switch ( type ) {
    case NodeType::All::BASIC:
        comp.loadUrl(QUrl(QStringLiteral("qrc:/src/qml/nodes/BasicNode.qml")), QQmlComponent::PreferSynchronous );
        break;
    case NodeType::All::AND:
        comp.loadUrl(QUrl(QStringLiteral("qrc:/src/qml/nodes/intermediary/AndGate.qml")), QQmlComponent::PreferSynchronous );
        break;
    case NodeType::All::SWITCH:
        comp.loadUrl(QUrl(QStringLiteral("qrc:/src/qml/nodes/input/SwitchInput.qml")), QQmlComponent::PreferSynchronous );
        break;
    case NodeType::All::LAMP:
        comp.loadUrl(QUrl(QStringLiteral("qrc:/src/qml/nodes/output/BasicOutput.qml")),  QQmlComponent::PreferSynchronous );
        break;
    default:
        return nullptr;
        break;
    }
    if( comp.isReady() ) {
        obj = comp.create(qmlContext(parent));
        obj->setParent(parent);
        obj->setProperty("state", "disabled");
        obj->setProperty("x", x);
        obj->setProperty("y", y);
        return obj;
    } else {
        qDebug() << comp.errorString();
    }
    return nullptr;
}



void NodeBackend::updatederived()
{
    //Setting target connectionState to undefined if Basic Nodebackend is used.
    qDebug() << "basic nodebackend";
    m_target->setProperty("connectionState", QVariant::fromValue(SlotState::State::UNDEFINED));
}

QString NodeBackend::name() const
{
    return m_name;
}

void NodeBackend::setName(const QString &name)
{
    m_name = name;
}

QObject *NodeBackend::slotModel() const
{
    return m_slotModel;
}

void NodeBackend::setSlotModel(QObject *slotModel)
{
    m_slotModel = slotModel;
}

NodeBackend::NodeBackend(QObject *parent) : QObject(parent)
{
    
}

NodeType::All NodeBackend::type() const
{
    return m_type;
}

void NodeBackend::setType(const NodeType::All &type)
{
    m_type = type;
}

QObject *NodeBackend::target() const
{
    return m_target;
}

void NodeBackend::setTarget(QObject *target)
{
    m_target = target;
}

void update() {

}
