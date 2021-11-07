#ifndef NANDBACKEND_H
#define NANDBACKEND_H

#include <QObject>
#include <qqml.h>

#include "nodebackend.h"

class NandBackend : public NodeBackend
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit NandBackend(QObject* parent = nullptr);

    virtual void updatederived() override;
};

#endif // NANDBACKEND_H
