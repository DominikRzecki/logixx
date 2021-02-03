#include "../headers/nodedroparea.h"

NodeDropArea::NodeDropArea(QQuickItem *parent)
        : QQuickItem (parent),
    m_accepting(true)
{
    setFlag(QQuickItem::ItemAcceptsDrops, m_accepting);
}

void NodeDropArea::dragEnterEvent(QDragEnterEvent *event)
{
    event->acceptProposedAction();
}

void NodeDropArea::dragLeaveEvent(QDragLeaveEvent *event)
{
    unsetCursor();
}

void NodeDropArea::dropEvent(QDropEvent *event)
{
    //QPointer<QObject> a = parent();
    if(event->source() != nullptr){
        //event->source()->
    }
    //event->source()->children().at(1)->setProperty("backend.parent", QVariant::fromValue(QPointer<QObject>(this))); //children().at(1)->findChild();
    qDebug() << event->source();
    //qDebug() << event->mimeData()->text();
    //dropped();
    unsetCursor();
}

void NodeDropArea::setAcceptingDrops(bool accepting)
{
    if (accepting == m_accepting)
                return;

    m_accepting = accepting;
    setFlag(QQuickItem::ItemAcceptsDrops, m_accepting);
    emit acceptingDropsChanged();
}
