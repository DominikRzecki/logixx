#ifndef SLOTBACKEND_H
#define SLOTBACKEND_H

#include <QObject>
#include <qqml.h>


class SlotState : public QObject {
    Q_OBJECT
    QML_ELEMENT
    QML_UNCREATABLE("SlotState is an enum")

public:
    enum class State {
        UNDEFINED = -2,
        UNKNOWN = -1,
        LOW = 0,
        HIGH = 1
    };

    Q_ENUM(State)

};

class SlotType : public QObject {
    Q_OBJECT
    QML_ELEMENT
    QML_UNCREATABLE("SlotType is an enum")

public:
    enum class Type {
        UNDEFINIED = -1,
        INPUT = 0,
        OUTPUT = 1,
        BIDIRECTIONAL = 2
    };

    Q_ENUM(Type)

};

Q_DECLARE_METATYPE(SlotState::State)
Q_DECLARE_METATYPE(SlotType::Type)

class SlotBackend : public QObject
{
    Q_OBJECT
        Q_PROPERTY(SlotState::State state READ state WRITE setState NOTIFY stateChanged)
        Q_PROPERTY(SlotType::Type type READ type WRITE setType NOTIFY typeChanged)
        Q_PROPERTY(QObject* source READ source WRITE setSource NOTIFY sourceChanged)
    QML_ELEMENT

public:

    explicit SlotBackend(QObject *parent = nullptr);

    SlotType::Type type() const;
    void setType(const SlotType::Type &type);

    SlotState::State state() const;
    void setState(const SlotState::State &state);

    QObject* source();
    void setSource(QObject* src);

    SlotState::State m_state = SlotState::State::UNDEFINED;
    SlotType::Type m_type = SlotType::Type::UNDEFINIED;

protected:

signals:

    void typeChanged();
    void stateChanged();
    void sourceChanged();

private:
    QObject* m_source;

};

#endif // SLOTBACKEND_H
