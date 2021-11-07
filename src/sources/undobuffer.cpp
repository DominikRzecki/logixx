#include "../headers/undobuffer.h"

UndoBuffer* UndoBuffer::m_undoBufferObject = nullptr;

UndoBuffer::UndoBuffer(QObject *parent) : QObject(parent)
{
    if ( !m_undoBufferObject ) {
        m_undoBufferObject = this;
    }
}

void UndoBuffer::undo()
{
    QObject* obj;
    if (m_undobuffer.size() > 0 && m_undoindex > - 1 && m_undoindex < m_undobuffer.size() ) {
        switch ( m_undobuffer.at(m_undoindex)->optype() ) {
        case OperationType::Type::CREATE:
            obj = qvariant_cast<QObject*>(m_undobuffer.at(m_undoindex)->m_params.at(0)->val());
            qDebug() << obj;
            obj->deleteLater();
            break;
        default:
            break;
        }
        m_undoindex--;
        qDebug()<< "undoindex:" << m_undoindex;
        qDebug()<< "size:" << m_undobuffer.size();
    }
}

void UndoBuffer::redo()
{

    if ( m_undoindex + 1 < m_undobuffer.size() ) {
        switch ( m_undobuffer.at( m_undoindex + 1 )->optype() ) {
        case OperationType::Type::CREATE:
            NodeType::All type;
            QVariant variant;
            QObject* obj = nullptr;
            int x, y;
            type = qvariant_cast<NodeType::All>(m_undobuffer.at(m_undoindex + 1)->m_params.at(1)->val());
            x = qvariant_cast<int>(m_undobuffer.at(m_undoindex + 1)->m_params.at(2)->val());
            y = qvariant_cast<int>(m_undobuffer.at(m_undoindex + 1)->m_params.at(3)->val());
            qDebug() << type << m_flickable;
            QMetaObject::invokeMethod(m_nodecreator, "create", Qt::DirectConnection, Q_RETURN_ARG(QVariant, variant), Q_ARG(QVariant, QVariant::fromValue(m_flickable)), Q_ARG(QVariant, static_cast<int>(type)), Q_ARG(QVariant, "enabled"), Q_ARG(QVariant, x), Q_ARG(QVariant, y));
            //obj = qvariant_cast<QObject*>(QVariant(variant));
            //variant.setValue(QVariant::fromValue(obj));
            //auto&& v = variant;
            //for(int i = 0; i < m_undobuffer.at(m_undoindex + 1)->m_params.size(); i++){
            //    qDebug() << "#";
            //}
            //if ( m_undobuffer.size() > 0)
                //m_undobuffer.at(m_undoindex + 1)->m_params.at(0)->m_val.setValue
                        //(variant);

            qDebug()<<"--------------";
            break;
        }
        m_undoindex++;
        qDebug()<< "undoindex:" << m_undoindex;
        qDebug()<< "size:" << m_undobuffer.size();
    }
}

void UndoBuffer::push(Operation *op)
{
    m_undobuffer.push_back(op);
}

void UndoBuffer::push(QObject *op)
{
    if ( m_undoindex < (m_undobuffer.size() - 1) ){
        m_undobuffer.erase(m_undobuffer.begin() + m_undoindex + 1, m_undobuffer.end());
    }
    m_undoindex = m_undobuffer.size();
    m_undobuffer.push_back(qobject_cast<Operation*>(op));
    qDebug()<< "undoindex:" << m_undoindex;
    qDebug()<< "size:" << m_undobuffer.size();
}

void UndoBuffer::push()
{
    m_undobuffer.push_back(new Operation);
}

QObject *UndoBuffer::getFlickable() const
{
    return m_flickable;
}

void UndoBuffer::setFlickable(QObject *flickable)
{
    m_flickable = flickable;
}

QObject *UndoBuffer::getNodecreator() const
{
    return m_nodecreator;
}

void UndoBuffer::setNodecreator(QObject *nodecreator)
{
    m_nodecreator = nodecreator;
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

void OperationParam::setVal(const QVariant &&val)
{
    m_val = val;
}

Operation::Operation(QObject *parent) : QObject( UndoBuffer::getInstance() )
{
    Q_UNUSED(parent);
}

Operation::Operation(const Operation &op)
    :QObject( op.parent() )
{
    m_optype = op.m_optype;
    m_params = op.m_params;
}

Operation::Operation(OperationType::Type *type) : QObject( UndoBuffer::getInstance() )
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
    m_params.push_back( param );
}

void Operation::pushParam(QObject *param)
{
    m_params.push_back( qobject_cast<OperationParam*>(param) );
}

OperationType::Type Operation::optype() const
{
    return m_optype;
}

void Operation::setOptype(const OperationType::Type &optype)
{
    m_optype = optype;
}
