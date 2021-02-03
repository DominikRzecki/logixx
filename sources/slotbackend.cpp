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
