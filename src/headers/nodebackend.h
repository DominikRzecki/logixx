#ifndef NODEBACKEND_H
#define NODEBACKEND_H

#include <QObject>
#include <QAbstractListModel>
#include <QtQml/QQmlComponent>

#include "QOlm/QOlm.hpp"
#include "slotbackend.h"
#include "nodeinputlist.h"

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
        Q_PROPERTY(QObject* slotModel READ  slotModel WRITE setSlotModel NOTIFY slotModelChanged)
        //Q_PROPERTY(ObjectList inputs READ inputs WRITE setInputs)
    QML_ELEMENT

public:

    explicit NodeBackend(QObject *parent = nullptr);

    NodeType::All type() const;
    void setType(const NodeType::All &type);

    QObject* target() const;
    void setTarget(QObject* target);

    //qolm::QOlm<QObject> inputs() const;
    //void setInputs(const qolm::QOlm<QObject> &inputs);

    QObject *slotModel() const;
    void setSlotModel(QObject *slotModel);

public slots:

    void update();

signals:

    void typeChanged();
    void targetChanged();
    void slotModelChanged();

protected:

    virtual void updatederived();

    NodeType::All m_type = NodeType::All::BASIC;
    QObject* m_target = nullptr;
    QObject* m_slotModel = nullptr;
    //ObjectList m_inputs; list(nullptr, {"foo"}, "foo");
};

#endif // NODEBACKEND_H
