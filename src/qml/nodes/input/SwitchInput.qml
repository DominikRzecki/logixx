import QtQuick 2.15
import QtQml.Models 2.15
import QtQuick.Controls 2.15
import QtQml 2.15
import com.rzecki.logix 1.0

import "../"
import "../nodeio/"


BasicInput {
    id: basicNode
    color: "white"
    height: 40
    width: 20

    backend.name: qsTr("switch")
    backend.type: NodeType.SWITCH

    taphandler.onTapped: {
        if( output.connectionState === SlotState.LOW ) {
            output.connectionState = SlotState.HIGH;
            basicNode.color = "lightgreen"
        } else {
            output.connectionState = SlotState.LOW;
            basicNode.color = "white"
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.9;height:480;width:640}
}
##^##*/
