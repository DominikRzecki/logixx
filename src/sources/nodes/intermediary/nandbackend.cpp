#include "nandbackend.h"
#include <QAbstractListModel>

NandBackend::NandBackend(QObject *parent) : NodeBackend(parent)
{

}

void NandBackend::updatederived()
{
    //QVariant that is returned from getState() in BasicNode.slotModel
    QVariant variant;
    //QObject the QVariant is casted to
    QObject* slot;

    int checksum = 0;
    qDebug() << m_slotModel;
    for( int i = 0; i < m_slotModel->property("count").toInt(); i++ ){
        //Invoking BasicNode.slotModel.getState() (JS functions return QVariant)
        qDebug() << QMetaObject::invokeMethod(m_slotModel, "getSlot", Qt::DirectConnection, Q_RETURN_ARG(QVariant, variant), Q_ARG(QVariant, i));
        //Casting QVariant to QObject*
        slot = qvariant_cast<QObject* >(variant);
        //Casting the first child of QObject* slot to SlotBackend* and comparing its property m_state with SlotState::State::LOW
        if( qobject_cast<SlotBackend* >( slot->children().at(0) )->m_state == SlotState::State::HIGH ) {
            qDebug() << "m_state:" << qobject_cast<SlotBackend* >(slot->children().at(0) )->m_state;
            //Setting connectionState property of BasicNode.connectionPath to SlotState::LOW, if Output slot->m_state != SlotState::State::HIGH and returning the function
            //Setting the connectionState property of connectionPath (8th child of BasicNode) to LOW
            checksum++;
            //this->parent()->children().at(8)->setProperty("connectionState", QVariant::fromValue(SlotState::State::LOW));
            //return;
        }
        if (checksum == m_slotModel->property("count").toInt()) {
            m_target->setProperty("connectionState", QVariant::fromValue(SlotState::State::LOW));
        } else {
            m_target->setProperty("connectionState", QVariant::fromValue(SlotState::State::HIGH));
        }

        //If m_state was HIGH for each slot, connectionPath.connectionState is set to HIGH

    }
}
