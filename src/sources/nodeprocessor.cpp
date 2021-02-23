#include "nodeprocessor.h"

nodeprocessor::nodeprocessor(QObject *parent) : QObject(parent)
{

}

QObject *nodeprocessor::targetParent() const
{
    return m_targetParent;
}

void nodeprocessor::setTargetParent(QObject *targetParent)
{
    m_targetParent = targetParent;
}
