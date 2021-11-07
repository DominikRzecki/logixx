import QtQuick 2.15
import QtQml.Models 2.15
import QtQuick.Controls 2.15
import QtQml 2.15
import com.rzecki.logix 1.0

import "../"
import "../nodeio/"


BasicNode {
    id: basicNode

    property alias output: outputSlot

    DropArea {
        id: dropArea
        width: basicNode.width-10
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        //Keys are "disabled" when basicNode disabled
        keys: basicNode.Drag.keys
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

    Slot{
        id: outputSlot
        posX: basicNode.width
        posY: basicNode.height/2
        connectionState: SlotState.LOW
        highlightColor: color
        parentNode: basicNode
        type: SlotType.OUTPUT
    }
    
    onReadyChanged: {
        if ( ready ) {
            outputSlot.connectionList.create();
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.75;height:480;width:640}
}
##^##*/
