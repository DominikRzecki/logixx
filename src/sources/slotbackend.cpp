#include "slotbackend.h"

SlotBackend::SlotBackend(QObject *parent) : QObject(parent)
{

}

SlotState::State SlotBackend::state() const
{
    return m_state;
}

void SlotBackend::setState(const SlotState::State &state)
{
    if ( m_state != state ) {
        m_state = state;
        emit stateChanged();
    }
}

QObject *SlotBackend::source()
{
    return m_source;
}

void SlotBackend::setSource(QObject * src)
{
    if ( m_source != src ) {
        m_source = src;
        emit sourceChanged();
    }
}
