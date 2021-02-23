#ifndef NODEBACKEND_H
#define NODEBACKEND_H

#include <QObject>
#include <QAbstractListModel>
#include <qqml.h>

#include "slotbackend.h"

class NodeType : public QObject{
    Q_OBJECT
    QML_ELEMENT
    QML_UNCREATABLE("NodeType is an enum")

public:
    enum class Input {
        SWITCH = 0
    };

    enum class Gate{
        AND = 10,
        OR,
        NAND,
        NOR,
        XAND,
        XOR
    };

    enum class Output {
        LAMP = 20
    };

    enum class All {
        BASIC = -1,
        SWITCH = 0,
        AND = 10,
        OR,
        NAND,
        NOR,
        XAND,
        XOR,
        LAMP = 20
    };

    Q_ENUM(Input)
    Q_ENUM(Gate)
    Q_ENUM(Output)
    Q_ENUM(All)

};

Q_DECLARE_METATYPE(NodeType::Input)
Q_DECLARE_METATYPE(NodeType::Gate)
Q_DECLARE_METATYPE(NodeType::Output)
Q_DECLARE_METATYPE(NodeType::All)

class NodeBackend : public QObject
{
    Q_OBJECT
        Q_PROPERTY(NodeType::All type READ type WRITE setType NOTIFY typeChanged)
        Q_PROPERTY(QObject* target READ target WRITE setTarget NOTIFY targetChanged)
    QML_ELEMENT

public:

    explicit NodeBackend(QObject *parent = nullptr);

    NodeType::All type() const;
    void setType(const NodeType::All &type);

    QObject* target() const;
    void setTarget(QObject* target);

public slots:

    void update();

signals:

    void typeChanged();
    void targetChanged();

protected:

    virtual void updatederived();

    NodeType::All m_type = NodeType::All::BASIC;
    QObject* m_target = nullptr;
    QAbstractListModel* m_slotModel = nullptr;
    QList<QVariant> m_inputs;
};

#endif // NODEBACKEND_H
