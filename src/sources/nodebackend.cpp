#include "nodebackend.h"

void NodeBackend::update()
{
    //Returning, if no target is set
    if ( !m_target )
        return;

    //setting slotModel (6th child of basicGate)
    if ( !m_slotModel) {
        m_slotModel = qobject_cast<QAbstractListModel*>(parent()->children().at(6));
    }

    //Calling the node processing algorithm
    updatederived();
}

void NodeBackend::updatederived()
{
    //Setting target connectionState to undefined if Basic Nodebackend is used.
    qDebug() << "basic nodebackend";
    m_target->setProperty("connectionState", QVariant::fromValue(SlotState::State::UNDEFINED));
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
