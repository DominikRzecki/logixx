import QtQuick 2.15
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.4
import com.rzecki.logix 1.0
import "nodeio"

Item {
    id: basicnode
    width: 100
    height: 100
    color: "white"

    property alias color: rectangle.color
    property alias taphandler: taphandler
    property alias draghandler: draghandler
    property NodeBackend backend

    backend: NodeBackend {
        type: NodeType.BASIC
    }

    Rectangle {
        id: rectangle
        anchors.fill: parent 
        onColorChanged: {
            update();
        }
    }



    DropShadow {
        id: shadow
        anchors.fill: rectangle
        color: "#80000000"
        radius: 10
        samples: 15
        source: rectangle
    }

    TapHandler {
        id: taphandler
        target: parent
        acceptedDevices: PointerDevice.AllDevices
        dragThreshold: 5
        onTapped: {
            forceActiveFocus()
        }
    }

    DragHandler {
        id: draghandler
        target: parent

        onActiveChanged: {
            if(active){
                forceActiveFocus()
                /*if (basicnode.parent instanceof GridLayout) {
                    basicnode.parent = basicnode.parent.parent.parent.parent.parent.parent.parent
                    console.log("asf")
                }*/
            } else {
                //enables grid snapping
                basicnode.x = basicnode.x - basicnode.x % 10
                basicnode.y = basicnode.y - basicnode.y % 10
            }
        }
    }

    onFocusChanged: {
        if (focus) {
            shadow.radius = 15
            shadow.samples = 20
            basicnode.z = 3
            console.log("act\n");
        }else{
            basicnode.z = 2
            shadow.radius = 10
            shadow.samples = 15
            console.log("inact\n");
        }
    }
}
