ifndef SLOT_H
#define SLOT_H

#include <QQuickItem>

class NodeInput : public QQuickItem
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit NodeInput(QQuickItem *parent = nullptr);

signals:

};

#endif // SLOT_H
