#include "../headers/nodebackend.h"

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
