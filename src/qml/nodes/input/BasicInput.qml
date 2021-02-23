import QtQuick 2.15
import QtQml.Models 2.15
import QtQuick.Controls 2.15
import QtQml 2.15
import com.rzecki.logix 1.0

import "../"
import "../nodeio/"


BasicNode {
    id: basicNode

    property alias output: connectionPath

    ConnectionPath{
        id: connectionPath
        x: basicNode.width
        y: basicNode.height/2
        connectionState: SlotState.LOW
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.9;height:480;width:640}
}
##^##*/
