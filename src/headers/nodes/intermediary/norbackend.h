#ifndef NORBACKEND_H
#define NORBACKEND_H

#include <QObject>
#include <qqml.h>

#include "nodebackend.h"

class NorBackend : public NodeBackend
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit NorBackend(QObject* parent = nullptr);

    virtual void updatederived() override;
};

#endif // NORBACKEND_H
