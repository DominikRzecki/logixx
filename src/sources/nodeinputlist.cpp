#include "../headers/nodeinputlist.h"


NodeInputList::NodeInputList(QObject *parent, const QList<QByteArray> &exposedRoles, const QByteArray &displayRole)
    :QOlm<NodeInput>(parent, exposedRoles, displayRole)
{}
