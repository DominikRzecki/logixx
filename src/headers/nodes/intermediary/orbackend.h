#ifndef ORBACKEND_H
#define ORBACKEND_H

#include <QObject>
#include <qqml.h>

#include "nodebackend.h"

class OrBackend : public NodeBackend
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit OrBackend(QObject* parent = nullptr);

    virtual void updatederived() override;
};

#endif // ANDBACKEND_H
