#include "headers/slotbackend.h"

SlotBackend::SlotBackend(QObject *parent) : QObject(parent)
{

}

SlotType::State SlotBackend::state() const
{
    return m_state;
}

void SlotBackend::setState(const SlotType::State &state)
{
    m_state = state;
}

QObject *SlotBackend::source()
{
    return m_source;
    //emit onSourceChanged();
}

void SlotBackend::setSource(QObject * src)
{
    m_source = src;
    //emit onSourceChanged();
}
