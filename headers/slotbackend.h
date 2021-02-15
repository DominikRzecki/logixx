﻿#ifndef SLOTBACKEND_H
#define SLOTBACKEND_H

#include <QObject>
#include <qqml.h>


class SlotType : public QObject {
    Q_OBJECT
    QML_ELEMENT
    QML_UNCREATABLE("SlotType is an enum")

public:
    enum class State {
        UNDEFINED = -1,
        LOW = 0,
        HIGH = 1,
        UNKNOWN = 2
    };

    Q_ENUM(State)

};

Q_DECLARE_METATYPE(SlotType::State)

class SlotBackend : public QObject
{
    Q_OBJECT
        Q_PROPERTY(SlotType::State state READ state WRITE setState NOTIFY stateChanged)
        Q_PROPERTY(QObject* source READ source WRITE setSource /*NOTIFY onSourceChanged*/)
    QML_ELEMENT
public:
    explicit SlotBackend(QObject *parent = nullptr);

    SlotType::State m_state = SlotType::State::UNDEFINED;

signals:
    void stateChanged();
    //void onSourceChanged();

protected:
    SlotType::State state() const;
    void setState(const SlotType::State &state);
    QObject* source();
    void setSource(QObject* src);
private:
    QObject* m_source;
};

#endif // SLOTBACKEND_H