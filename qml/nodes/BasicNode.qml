import QtQuick 2.15
import QtGraphicalEffects 1.0
import com.rzecki.logix 1.0
import "nodeio"

Item {
    id: basicnode
    width: 100
    height: 100
    color: "white"

    property alias color: rectangle.color
    property alias backend: backend

    NodeBackend {
        id: backend
        type: NodeType.AND
    }

    Rectangle {
        id: rectangle
        anchors.fill: parent 
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
        onTapped: {
            console.log("tap " + backend.type)
            forceActiveFocus()
        }
    }

    DragHandler {
        target: parent
        onActiveChanged: {
            if(active){
                forceActiveFocus()
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
