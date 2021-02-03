#ifndef NODEDROPAREA_H
#define NODEDROPAREA_H

#include <QQuickItem>
#include <QGraphicsSceneDragDropEvent>
#include <QMimeData>

class NodeDropArea : public QQuickItem
{
    Q_OBJECT
        Q_PROPERTY(bool acceptingDrops READ isAcceptingDrops WRITE setAcceptingDrops NOTIFY acceptingDropsChanged)
    QML_ELEMENT
public:
    NodeDropArea(QQuickItem *parent = 0);
    bool isAcceptingDrops() const { return m_accepting; }
    void setAcceptingDrops(bool accepting);
signals:
    void dropped();
    void acceptingDropsChanged();

protected:
    void dragEnterEvent(QDragEnterEvent *event);
    void dragLeaveEvent(QDragLeaveEvent *event);
    void dropEvent(QDropEvent *event);

private:
    bool m_accepting;
};

#endif // NODEDROPAREA_H
