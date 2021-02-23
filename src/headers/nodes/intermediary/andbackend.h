#ifndef ANDBACKEND_H
#define ANDBACKEND_H

#include <QObject>
#include <qqml.h>

#include "nodebackend.h"

class AndBackend : public NodeBackend
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit AndBackend(QObject* parent = nullptr);

    virtual void updatederived() override;
};

#endif // ANDBACKEND_H
