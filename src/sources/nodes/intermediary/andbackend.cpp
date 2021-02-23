#include "andbackend.h"
#include <QAbstractListModel>

AndBackend::AndBackend(QObject *parent) : NodeBackend(parent)
{

}

void AndBackend::updatederived()
{
    //qobject_cast<QAbstractListModel*>(m_slotModel)
    //bool  = false;
    if(m_slotModel) {
        qDebug() << m_slotModel->data(m_slotModel->index(0), 0);//"slot.currentState");
    }
    //for ( auto &i : m_slotModel ) {
        //m_slotModel->data(m_slotModel->index(0), 0)
    //}
}
