#ifndef NODEDROPAREA_H
#define NODEDROPAREA_H

#include <QQuickItem>
#include <QGraphicsSceneDragDropEvent>
#include <QMimeData>

class NodeDropArea : public QQuickItem
{
    Q_OBJECT
        Q_PROPERTY(bool acceptingDrops READ isAcceptingDrops WRITE setAcceptingDrops NOTIFY acceptingDropsChanged)
        //Q_PROPERTY(QObject* source READ source() WRITE setSource())
    QML_ELEMENT
public:
    NodeDropArea(QQuickItem* parent = 0);
    bool isAcceptingDrops() const { return m_accepting; }
    void setAcceptingDrops(bool accepting);
    //QObject* source();
    //void setSource(QObject* source);
signals:
    void dropped();
    void entered();
    void exited();
    void acceptingDropsChanged();

protected:
    void dragEnterEvent(QDragEnterEvent* event);
    void dragLeaveEvent(QDragLeaveEvent* event);
    void dropEvent(QDropEvent* event);

private:
    bool m_accepting;
    QObject* m_source;
};

#endif // NODEDROPAREA_H
