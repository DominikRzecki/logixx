#ifndef NODEPROCESSOR_H
#define NODEPROCESSOR_H

#include <QObject>
#include <qqml.h>
#include <QThread>

class nodeprocessor : public QObject
{
    Q_OBJECT
        Q_PROPERTY(QObject* targetParent READ targetParent WRITE setTargetParent NOTIFY targetParentChanged)
    QML_ELEMENT

public:

    explicit nodeprocessor(QObject *parent = nullptr);

    QObject *targetParent() const;
    void setTargetParent(QObject *targetParent);

signals:

    void targetParentChanged();

protected:

    void startProcessing(QObject* targetParent = nullptr);
    void pauseProcessing(QObject* targetParent = nullptr);
    void stopProcessing(QObject* targetParent = nullptr);

    //Holds a QPointer to the parent of the nodes to process
    QObject* m_targetParent;
};

#endif // NODEPROCESSOR_H
