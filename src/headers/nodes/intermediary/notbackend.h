#pragma once
#include <QObject>
#include <qqml.h>

#include "nodebackend.h"

class NotBackend : public NodeBackend
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit NotBackend(QObject* parent = nullptr);

    virtual void updatederived() override;
};
