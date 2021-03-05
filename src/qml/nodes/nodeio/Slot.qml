import QtQuick 2.12
import QtGraphicalEffects 1.15
import com.rzecki.logix 1.0
import "../"

Item {
    id: slot

    property alias currentState: slotbackend.state
    property alias source: slotbackend.source
    property alias color: circle.fillColor
    property alias highlightColor: shadow.color
    property alias radius: circle.r

    SlotBackend {
        id: slotbackend
        state: SlotState.UNDEFINED
        onStateChanged: {
            console.debug(slot + " : " + "state changed")

            //Setting slot color
            if ( state === SlotState.HIGH ) {
                circle.fillColor = "red";
            } else if ( state == SlotState.UNDEFINED ){
                circle.fillColor = highlightColor;
            } else {
                circle.fillColor = "black";
            }

            //Updating node output
            slot.parent.parent.parent.parent.backend.update();
        }
    }

    Circle {
        id: circle
        posX: slot.x
        posY: slot.y
        z: slot.z
        r: 4
        fillColor: "black"

        TapHandler {
            onTapped: {
                console.debug(slot + " : " + slotbackend.state)
            }
        }
    }

    DropShadow {
        id: shadow
        anchors.fill: circle
        color: Qt.rgba(0, 0, 0, 0.5)
        radius: 7
        samples: 14
        source: circle
    }
}
