import QtQuick 2.0
import QtGraphicalEffects 1.12
import QtQuick.Shapes 1.15

Shape {
    id: circle
    width: 5
    height: 5
    x: posX-width/2
    y: posY-height/2
    property real r: 3
    property real posX
    property real posY

    ShapePath {
        strokeColor: "transparent"
        fillColor: "blue"

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
        strokeColor: "transparent"
        fillColor: "blue"

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
