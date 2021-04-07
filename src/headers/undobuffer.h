#ifndef UNDOBUFFER_H
#define UNDOBUFFER_H

#include <QObject>
#include <QtQml>



struct OperationType : public QObject {
    Q_OBJECT
    QML_ELEMENT
    QML_UNCREATABLE("NodeType is an enum")
public:
    enum class Type {
        CREATE,
        REMOVE,
        CHANGE,
        CONNECT,
        DISCONNECT
    };

    Q_ENUM(Type);
};

class OperationParam : public QObject {
    Q_OBJECT
        Q_PROPERTY( QString prop READ prop WRITE setProp )
    QML_ELEMENT
public:

    explicit OperationParam( QObject *parent = nullptr );
    explicit OperationParam( const OperationParam& opp );

    void operator=(const OperationParam& opp );

    QString prop() const;
    void setProp(const QString &prop);

    QVariant val() const;
    void setVal(const QVariant &val);

private:
    QString m_prop;
    QVariant m_val;
};

class Operation : public QObject {
    Q_OBJECT
    QML_ELEMENT
public:

    explicit Operation( QObject *parent = nullptr );
    explicit Operation( const Operation& op );
    explicit Operation( OperationType::Type *type, QObject *parent = nullptr );

    void operator=(const Operation& op);

public slots:
    void pushParam(OperationParam *param);

private:
    OperationType::Type m_optype;
    QVector<OperationParam> m_params;
};

class UndoBuffer : public QObject
{
    Q_OBJECT;
    QML_SINGLETON;
    QML_ELEMENT;
public:
    explicit UndoBuffer(QObject *parent = nullptr);

public slots:

    void undo();
    void redo();
    void push( Operation *op );

private:
    QVector<Operation> m_undobuffer;

};

#endif // UNDOBUFFER_H
