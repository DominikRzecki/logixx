#include "headers/slotbackend.h"

SlotBackend::SlotBackend(QObject *parent) : QObject(parent)
{

}

SlotState::State SlotBackend::state() const
{
    return m_state;
}

void SlotBackend::setState(const SlotState::State &state)
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
