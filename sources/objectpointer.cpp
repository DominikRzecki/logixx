#include "../headers/objectpointer.h"

ObjectPointer::ObjectPointer(QObject *parent) : QObject(parent)
{

}

void ObjectPointer::setObjectPointer(QObject *pointer)
{
    m_objectPointer = pointer;
}

QObject *ObjectPointer::objectPointer()
{
    return m_objectPointer;
}
