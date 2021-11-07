import QtQuick 2.0

import com.rzecki.logix 1.0

import "../"
import "../nodeio"

BasicNode {
    id: basicNode
    width: 30
    height: 30

    backend.name: qsTr("output")
    backend.type: NodeType.LAMP

    Slot {
        id: inputSlot

        posX: 0
        posY: basicNode.height/2

        width: 10
        height: 10
        radius: 3

        highlightColor: "green"

        type: SlotType.INPUT

        parentNode: basicNode

        onConnectionStateChanged: {
            if( connectionState === SlotState.HIGH ) {
                basicNode.color = "orange";
            } else {
                basicNode.color = "white";
            }
        }
    }

    TextInput {
        text: basicNode.backend.name
        anchors.top: parent.top
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.topMargin: basicNode.height + 5
        anchors.horizontalCenter: parent.horizontalCenter
        enabled: basicNode.enabled
        Component.onCompleted: {
            basicNode.backend.name = Qt.binding(function() { return text; })
        }
    }

    onReadyChanged: {
        if ( ready ) {
            inputSlot.connectionList.create();
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:4}
}
##^##*/
