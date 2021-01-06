import QtQuick 2.15
import QtGraphicalEffects 1.0
import com.rzecki.logix 1.0

Item {
    id: basicnode
    width: 100
    height: 100

    NodeBackend {
        id: backend
        anchors.fill: parent
    }

/*    ListModel {
        id: inputs
    }

    ListModel {
        id: outputs
    }

*/
    Rectangle {
        id: rectangle
        anchors.fill: parent 
        color: "white"
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
            console.log("tap")
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
            node.z = 3
            console.log("act\n");
        }else{
            node.z = 2
            shadow.radius = 10
            shadow.samples = 15
            console.log("inact\n");
        }
    }
}
