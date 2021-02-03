import QtQuick 2.12
import QtGraphicalEffects 1.15
import com.rzecki.logix 1.0
import "../"

Item {
    id: slot

    property alias currentState: slotbackend.state
    property alias color: circle.fillColor
    property alias radius: circle.r

    SlotBackend {
        id: slotbackend
        state: SlotType.UNDEFINED
    }

    Circle {
        id: circle
        posX: slot.x
        posY: slot.y
        z: slot.z
        r: 4
        TapHandler {
            onTapped: console.log(slotbackend.state)
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
}
