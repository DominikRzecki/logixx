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

OperationParam::OperationParam(const OperationParam &opp)
    :QObject(opp.parent())
{
    m_prop = opp.m_prop;
    m_val = opp.m_val;
}

void OperationParam::operator=(const OperationParam &opp)
{
    setParent(opp.parent());

    m_prop = opp.m_prop;
    m_val = opp.m_val;
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
    :QObject(op.parent())
{
    m_optype = op.m_optype;
    m_params = op.m_params;
}

Operation::Operation(OperationType::Type *type, QObject *parent) : QObject( parent )
{
    m_optype = *type;
}

void Operation::operator=(const Operation &op)
{
    setParent(op.parent());

    m_optype = op.m_optype;
    m_params = op.m_params;
}

void Operation::pushParam(OperationParam *param)
{
    m_params.push_back( *param );
}
