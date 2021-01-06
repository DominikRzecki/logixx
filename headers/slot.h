#ifndef SLOT_H
#define SLOT_H

#include <QQuickItem>
#include <QObject>

class SlotClass : public QQuickItem
{
    enum State{
        UNKNOWN = -1,
        LOW = 0,
        HIGH = 1,
        UNDEFINED = 2
    };

    Q_OBJECT
        Q_ENUM(SlotClass::State)
        Q_PROPERTY(quint8 state READ state WRITE setState NOTIFY stateChanged)
    QML_ELEMENT
public:
    SlotClass(QQuickItem *parent = Q_NULLPTR);
    ~SlotClass();

    quint8 m_state = UNDEFINED;

signals:
    void stateChanged();

protected:
    quint8 state() const;
    void setState(const quint8 &state);

private:

};

#endif // SLOT_H
