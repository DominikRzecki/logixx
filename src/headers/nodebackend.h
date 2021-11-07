#ifndef NODEBACKEND_H
#define NODEBACKEND_H

#include <QObject>
#include <QAbstractListModel>
#include <QtQml/QQmlComponent>

#include "QQmlEngine"
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
        NOT = 10,
        AND,
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
        NOT = 10,
        AND,
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
        Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
        Q_PROPERTY(QObject* target READ target WRITE setTarget NOTIFY targetChanged)
        Q_PROPERTY(QObject* slotModel READ slotModel WRITE setSlotModel NOTIFY slotModelChanged)
    QML_ELEMENT

public:

    explicit NodeBackend(QObject *parent = nullptr);

    NodeType::All type() const;
    void setType(const NodeType::All &type);

    QString name() const;
    void setName(const QString &name);

    QObject* target() const;
    void setTarget(QObject* target);

    QObject *slotModel() const;
    void setSlotModel(QObject *slotModel);


public slots:

    void update();
    static QObject* createNode( QObject* parent, NodeType::All type, int x, int y);

signals:

    void typeChanged();
    void nameChanged();
    void targetChanged();
    void slotModelChanged();

protected:

    virtual void updatederived();

    NodeType::All m_type = NodeType::All::BASIC;
    QString m_name;
    QObject* m_target = nullptr;
    QObject* m_slotModel = nullptr;
    //ObjectList m_inputs; list(nullptr, {"foo"}, "foo");
};

#endif // NODEBACKEND_H
