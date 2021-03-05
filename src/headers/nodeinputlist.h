#ifndef SLOTLIST_H
#define SLOTLIST_H

#include <QOlm/QOlm.hpp>
#include <QObject>
#include "nodeinput.h"

class NodeInputList : public qolm::QOlm<NodeInput>
{
    Q_OBJECT
    QML_ELEMENT
public:
    NodeInputList(QObject* parent = nullptr,
        const QList<QByteArray>& exposedRoles = {},
        const QByteArray& displayRole = {});
};

#endif // SLOTLIST_H
