import QtQuick 2.15
import QtGraphicalEffects 1.0
import QtQuick.Shapes 1.15
import "../"

Shape {
    id: shape
    antialiasing: true
    width: targetX-x
    height: targetY-y

    property alias targetX: targetRect.x
    property alias targetY: targetRect.y
    property var target

    ShapePath {
        id: path
        strokeColor: "black"
        fillColor: "transparent"
        strokeWidth: 3
        startX: 0; startY: 0
        capStyle: ShapePath.RoundCap

        PathCurve { id: targetPoint; x: targetRect.x+targetRect.width/2; y: targetRect.y+targetRect.height/2; }
    }

    Circle {
        id: circle
        posX: 0
        posY: 0
        z: shape.parent.z+0.5
        fillColor: "blue"
        strokeColor: "transparent"
    }



    /*MouseArea {
        id: mouseArea
        x: -width/2
        y: -height/2
        z: circle.z+0.2
        width: 20
        height: 20

        onReleased: targetRect.Drag.drop

        drag.target: targetRect
        //onReleased:*/
    /*MouseArea {
            id: mouseArea
            anchors.fill: parent
            drag.target: targetRect
        }*/
    Rectangle {
        id: targetRect
        x: -width/2
        y: -height/2
        z: circle.z+0.2
        width: 20
        height: 20
        color: "green"

        //Drag.source:  targetRect
        Drag.active: dragHandler.active
        //Drag.active: mouseArea.drag.active
        //Drag.mimeData: { "text/plain": shape.display }
        Drag.hotSpot.x: width/2
        Drag.hotSpot.y: height/2
        Drag.onDragStarted: console.log("drag started");
        Drag.dragType: Drag.Automatic

        DragHandler {
            id: dragHandler
            target: targetRect
            acceptedButtons: Qt.LeftButton
            acceptedDevices: PointerDevice.AllDevices
            /*onActiveChanged: {
                console.log("drop")
                if(targetRect.Drag.target === null) {
                    targetRect.x = -targetRect.width/2; targetRect.y = -targetRect.height/2;
                } else {
                    //console.log(targetRect.Drag.target.parent.x);

                    //targetRect.x = targetRect.Drag.target.parent.x;
                    //targetRect.y = targetRect.Drag.target.parent.y;
                    targetRect.Drag.drop();
                    //targetRect.x = targetRect.Drag.target.x;
                    //console.log(targetRect.Drag.target);
                }
                targetRect.Drag.targe
            }*/
        }
    }
    property string display


        /*Item {
            z: circle.z+0.3
            id: draggable
            anchors.fill: parent
            Drag.active: mouseArea.drag.active
            Drag.hotSpot.x: 0
            Drag.hotSpot.y: 0
            Drag.mimeData: { "text/plain": shape.display }
            Drag.dragType: Drag.Automatic
            Drag.onDragFinished: (dropAction) => {
                if (dropAction == Qt.MoveAction)
                    item.display = ""
            }
        }*/


    TapHandler {
        target: parent
        onTapped: {
            forceActiveFocus()
        }
    }

    DropShadow {
        id: shadow
        anchors.fill: circle
        color: Qt.rgba(0, 0, 0, 0.5)
        radius: 5
        samples: 10
        source: circle
    }
    //layer.enabled: true
    //layer.samples: 4
    /*layer.effect: DropShadow {
        id: shadow
        color: Qt.rgba(0, 0, 0, 0.5)
        radius: 5
        samples: 10
    }*/

    onFocusChanged: {
        if (focus) {
            shadow.radius = 15
            shadow.samples = 20
            shape.z = shape.parent.z + 2
            console.log("act\n");
        }else{
            shape.z = shape.parent.z + 1
            shadow.radius = 10
            shadow.samples = 15
            console.log("inact\n");
        }
    }
}
