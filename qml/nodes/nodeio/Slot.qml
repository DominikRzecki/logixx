import QtGraphicalEffects 1.12
import com.rzecki.logix 1.0

SlotClass {
    id: slot
    x: 0
    y: 0 //parent.height/4
    z: 0 //parent.z+1
    Circle {
        id: circle
        posX: slot.x
        posY: slot.y
        z: slot.z
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
