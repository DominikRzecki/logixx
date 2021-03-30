#include "../headers/undobuffer.h"

UndoBuffer::UndoBuffer(QObject *parent) : QObject(parent)
{

}

void UndoBuffer::undo()
{

}

void UndoBuffer::redo()
{

}

void UndoBuffer::push(Operation *op)
{
    m_undobuffer.push_back(*op);
}

OperationParam::OperationParam(QObject *parent) : QObject( parent )
{

}

QString OperationParam::prop() const
{
    return m_prop;
}

void OperationParam::setProp(const QString &prop)
{
    m_prop = prop;
}

QVariant OperationParam::val() const
{
    return m_val;
}

void OperationParam::setVal(const QVariant &val)
{
    m_val = val;
}

Operation::Operation(QObject *parent) : QObject(parent)
{

}

Operation::Operation(const Operation &op)
{

}

Operation::Operation(OperationType::Type *type, QObject *parent) : QObject( parent )
{
    m_optype = *type;
}

void Operation::pushParam(OperationParam *param)
{
    m_params.push_back( *param );
}
