import QtQuick 2.15
import QtGraphicalEffects 1.0
import QtQuick.Shapes 1.15

Shape {
    id: shape
    width: 3000
    height: 3000
    antialiasing: true

    property alias originX: path.startX
    property alias originY: path.startY
    property alias target: targetPoint

    ShapePath {
        id: path
        strokeColor: "black"
        fillColor: "transparent"
        strokeWidth: 3
        startX: shape.x; startY: shape.y
        capStyle: ShapePath.RoundCap

        PathCurve {id: targetPoint; x: shape.x; y: shape.y;
        }
        //PathCurve { x: nodeq.x; y: nodeq.y }
        //PathCurve { x: 325; y: 25 }
        //PathCurve { x: 400; y: 100 }
    }

    Circle {
        id: circle
        posX: path.startX
        posY: path.startY
        z: shape.parent.z+1
    }

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
