#include "slot.h"

SlotClass::SlotClass(QQuickItem *parent):QQuickItem(parent)
{
    QQuickItem::setFlag(QQuickItem::ItemHasContents);
}

SlotClass::~SlotClass()
{

}

quint8 SlotClass::state() const
{
    return m_state;
}

void SlotClass::setState(const quint8 &state)
{
    if(m_state != state) {
        m_state = state;
    }
}


