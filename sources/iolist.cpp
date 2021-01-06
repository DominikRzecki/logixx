#include "iolist.h"

InputList::InputList(QPointer<QObject> parent)
    : m_component{}
{
}

InputList::~InputList(){
    //for(auto& i : m_inputs){
    //    i->deleteLater();
    //}
}
/*QObject &InputList::createInput()
{
    QObject* object = m_component.create();
    object->setParent(this);

    QQmlEngine::setObjectOwnership(object, QQmlEngine::CppOwnership);
    m_inputs.append(object);
    return *object;
}*/

void InputList::removeInput(QObject &input)
{
    input.deleteLater();
}

QObject &OutputList::createOutput()
{
    QObject* object = m_component.create();
    object->setParent(this);


    QQmlEngine::setObjectOwnership(object, QQmlEngine::CppOwnership);
    m_outputs.append(object);
    return *object;
}

void OutputList::removeOutput(QObject &output)
{
    output.deleteLater();
}

/*OutputList::OutputList(QObject *parent)
{
    m_engine = QQmlEngine::contextForObject(parent)->engine();
}*/

OutputList::~OutputList(){
    for(auto& i : m_outputs){
        i->deleteLater();
    }
}
