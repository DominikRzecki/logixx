import QtQuick 2.0
import QtQuick.Layouts 1.12
import "../"
import"../nodeio"

import com.rzecki.logix 1.0

BasicGate {
    id: basicgate
    backend: NotBackend {
        type: NodeType.NOT
        target: basicgate.outputSlot
        slotModel: basicgate.slotList.model
        name: "NOT"
    }

    slotList.maxSlots: 1

    //backend.type: NodeType.AND

    /*NumInput {
        x: 10
        y: 10
        width: 30
        height: 15
    }*/
}
