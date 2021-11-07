#ifndef UNDOBUFFER_H
#define UNDOBUFFER_H

#include <QObject>
#include <QtQml>
#include "./nodebackend.h"

struct OperationType : public QObject {
    Q_OBJECT
    QML_ELEMENT
    QML_UNCREATABLE("NodeType is an enum")
public:
    enum class Type {
        CREATE,
        DELETE,
        CHANGE,
        CONNECT,
        DISCONNECT
    };

    Q_ENUM(Type);
};

class OperationParam : public QObject {
    Q_OBJECT
        Q_PROPERTY( QString prop READ prop WRITE setProp )
        Q_PROPERTY( QVariant val READ val WRITE setVal )
    QML_ELEMENT
public:

    explicit OperationParam( QObject *parent = nullptr );
    explicit OperationParam( const OperationParam& opp );

    void operator=(const OperationParam& opp );

    QString prop() const;
    void setProp(const QString &prop);

    QVariant val() const;
    void setVal(const QVariant &val);
    void setVal(const QVariant &&val);

    QString m_prop;
    QVariant m_val;
private:
};

class Operation : public QObject {
    Q_OBJECT
        Q_PROPERTY( OperationType::Type type READ optype WRITE setOptype )
    QML_ELEMENT
public:

    explicit Operation( QObject *parent = nullptr );
    explicit Operation( const Operation& op );
    explicit Operation( OperationType::Type *type);

    void operator=(const Operation& op);

    OperationType::Type optype() const;
    void setOptype(const OperationType::Type &optype);

    QVector<OperationParam*> m_params;
public slots:
    void pushParam(OperationParam *param);
    void pushParam(QObject *param);

private:
    OperationType::Type m_optype;
};

class UndoBuffer : public QObject
{
    Q_OBJECT;
    Q_PROPERTY( QObject* flickable READ getFlickable WRITE setFlickable )
    Q_PROPERTY( QObject* nodecreator READ getNodecreator WRITE setNodecreator )
    QML_SINGLETON;
    QML_ELEMENT;
public:

    UndoBuffer(UndoBuffer &other) = delete;
    explicit UndoBuffer(QObject *parent = nullptr);

    void operator=(const UndoBuffer &) = delete;

    static UndoBuffer* getInstance(){
        if( !m_undoBufferObject ) {
            m_undoBufferObject = new UndoBuffer(nullptr);
        }
        return m_undoBufferObject;
    }

    QObject* m_flickable = nullptr;


public slots:

    void undo();
    void redo();
    void push( Operation *op );
    void push( QObject *op );
    void push();

    QObject *getNodecreator() const;
    void setNodecreator(QObject *nodecreator);
    QObject *getFlickable() const;
    void setFlickable(QObject *flickable);

private:
    QObject* m_nodecreator;
    QVector<Operation*> m_undobuffer;
    signed long m_undoindex = 0;
    static UndoBuffer* m_undoBufferObject;

};

#endif // UNDOBUFFER_H
