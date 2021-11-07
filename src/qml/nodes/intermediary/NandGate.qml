import QtQuick 2.0
import QtQuick.Layouts 1.12
import "../"

import com.rzecki.logix 1.0

BasicGate {
    id: basicgate
    backend: NandBackend {
        type: NodeType.NAND
        target: basicgate.outputSlot
        slotModel: basicgate.slotList.model
        name: "NAND"
    }

    //backend.type: NodeType.AND

    /*NumInput {
        x: 10
        y: 10
        width: 30
        height: 15
    }*/
}
