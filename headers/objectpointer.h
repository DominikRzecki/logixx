#ifndef OBJECTPOINTER_H
#define OBJECTPOINTER_H

#include <QObject>
#include <qqml.h>

class ObjectPointer : public QObject
{
    Q_OBJECT
        Q_PROPERTY(QObject* pointer READ objectPointer)
        Q_INVOKABLE void setObjectPointer(QObject* pointer);
    QML_ELEMENT
public:
    explicit ObjectPointer(QObject *parent = nullptr);
    //void setObjectPointer(QObject* pointer);
    QObject* objectPointer();
signals:

private:
    QObject* m_objectPointer;
};

#endif // OBJECTPOINTER_H
