import QtQuick 2.0
import QtGraphicalEffects 1.12
import QtQuick.Shapes 1.15

Shape {
    id: circle
    width: parent.width
    height: parent.width
    x: posX-width/2
    y: posY-height/2

    property real r: 3
    property real posX
    property real posY
    property color fillColor: "blue"
    property color strokeColor: "transparent"

    ShapePath {
        id: half1
        strokeColor: circle.strokeColor
        fillColor: circle.fillColor

        startX: circle.width / 2 + circle.r
        startY: circle.height / 2 + circle.r
        PathArc {
            x: circle.width / 2 - circle.r
            y: circle.height / 2 - circle.r
            radiusX: circle.r; radiusY: circle.r
            useLargeArc: true
        }
    }

    ShapePath {
        id: half2
        strokeColor: circle.strokeColor
        fillColor: circle.fillColor

        startX: circle.width / 2 - circle.r
        startY: circle.height / 2 - circle.r
        PathArc {
            x: circle.width / 2 + circle.r
            y: circle.height / 2 + circle.r
            radiusX: circle.r; radiusY: circle.r
            useLargeArc: true
        }
    }
}
