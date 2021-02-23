#ifndef IOLIST_H
#define IOLIST_H

#include <QAbstractListModel>
#include <QQmlContext>
#include <QQmlProperty>
#include <QQmlEngine>

class InputList : public QObject
{
    Q_OBJECT

public:
    explicit InputList(QPointer<QObject> parent);
    ~InputList();

    //Q_INVOKABLE QObject& createInput();
    Q_INVOKABLE void removeInput(QObject &input);

private:
    //QList<QPointer<QObject>> m_inputs;
    //QQmlComponent m_component;
};

class OutputList : public QObject
{
    Q_OBJECT
        Q_INVOKABLE QObject& createOutput();
        Q_INVOKABLE void removeOutput(QObject &output);
public:
    explicit OutputList(QObject *parent = 0);
    ~OutputList();

private:
    QList<QPointer<QObject>> m_outputs;
    QQmlEngine* m_engine;
    //QQmlComponent m_component;
};

#endif // IOLIST_H
