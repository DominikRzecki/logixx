import QtQuick 2.12
import QtGraphicalEffects 1.15
import com.rzecki.logix 1.0
import "../"

Item {
    id: slot

    property alias connectionState: backend.state
    property alias type: backend.type
    property alias source: backend.source
    property alias connectionList: connList     //Alias to connList storing the DragRectangles

    property alias color: circle.fillColor
    property alias highlightColor: shadow.color
    property alias radius: circle.r
    radius: 3

    property alias dragKeys: slotDropArea.keys

    required property BasicNode parentNode  //Holds the Node the solt belongs to
    property ListView listView: null        //Holds the parent ListView should be null, if thereis none
    property int index: 0                   //Holds the index of the current slot

    property real posX: 0
    property real posY: 0

    x: posX - radius// / 2
    y: posY - radius// 2

    width: radius * 2
    height: radius * 2

    SlotBackend {
        id: backend
        state: SlotState.UNDEFINED
        onStateChanged: {
            console.debug(slot + " : " + "state changed");
            update();
        }
    }

    //The following function can be called when updating the Slots connectionState is needed
    function update() {
        console.debug(slot + ".update()")

        //If the Slot s an OUTPUT al connncted DragRectangles are updated
        if (backend.type === SlotType.OUTPUT && connList.list) {
            console.debug(slot + ".backend.type: OUTPUT")
            for( var i = 0; i < connList.list.length; i++ ) {
                connList.list[i].connectionState = backend.state;
            }
        }
        //If the Slot is an INPUT, connectionState is set to the highest connectionState of all conneced DrRectangles
        if ( backend.type === SlotType.INPUT ) {
            console.debug(slot + ".backend.type: INPUT")
            var stat = SlotState.UNDEFINED;
            for( i = 0; i < connList.list.length; i++ ) {
                if ( stat < connList.list[i].connectionState )
                    stat = connList.list[i].connectionState;
                console.debug(i + " state: " + connList.list[i].connectionState);
            }
            backend.state = stat;
            slot.parentNode.backend.update();
        }

        //Setting slot color
        if ( backend.state === SlotState.HIGH ) {
            circle.fillColor = "red";
        } else if ( backend.state === SlotState.UNDEFINED ){
            circle.fillColor = highlightColor;
        } else {
            circle.fillColor = "black";
        }
    }

    ConnectionPathList {
        id: connList
        parentSlot: slot
        flickable: slot.parentNode.parent.parent
    }

    Circle {
        id: circle
        posX: r
        posY: r
        z: slot.z

        fillColor: "green"

        TapHandler {
            onTapped: {
                console.debug(slot + ".connList.list.length: " + connList.list.length);
            }
        }
    }

    DropArea {
        id: slotDropArea
        enabled: true
        anchors.fill: circle

        onEntered: (drag) => {
                       console.debug(slot + " : " + slotDropArea + " : " + "onEntered");
                   }

        onExited: {
            console.debug(slot + " : " + slotDropArea + " : " + "onExited");
        }

        onDropped: {
            // <=3=>
            console.debug(slot + " : " + slotDropArea + " : " + "onDropped");
            if( slotDropArea.drag.source.parent.parent.parent !== slot.parent.parent.parent.parent.parent ) {
                //Droped on another node
                //setting the source of the slot to the connectionPath that has been dropped
                slot.source = slotDropArea.drag.source;
                console.debug(slot + ".source: " + slot.source);

                //setting the targetSlot of the drop source to slot
                slot.source.targetSlot = slot
                slot.source.oldTargetSlot = slot

                //Setting targetNode to parentNode
                slot.source.targetNode = parentNode

                //Adding slot.source to slotList
                connList.push(slot.source);
                slot.source.index = connList.list.length;

                //Needed to calculate the bindings correctly. Do not use slot.source because it changes everytime a new DragRectangle is Dropped
                var src = slot.source;
                //Bindings compute x and y of the slot
                slot.source.x = Qt.binding( function() {
                    //return slot.parentNode.x - slot.source.otherRect.targetNode.x - slot.source.width/2 - slot.source.otherRect.targetNode.width;
                    return slot.parentNode.x + slot.posX - src.width/2;
                } )
                slot.source.y = Qt.binding( function() {
                    //return slot.parentNode.y - slot.source.otherRect.targetNode.y - slot.source.height/2 - slot.source.otherRect.targetNode.height/2 + parentNode.height / ((listView !== null) ? (listView.count+1) : 2)*(slot.index+1);
                    return slot.parentNode.y  + slot.posY - src.height/2 + ((listView === null) ? 0 : (parentNode.height / (listView.count+1) *(slot.index)));
                } )

                slot.source.parent.updateState();

                //Update the connectionStates of SlotList
                slot.update();

            } else {

                // reset path if connection impossible
                //slotDropArea.drag.source.x = 0//slotDropArea.drag.source.x + slotDropArea.drag.source.width/2;
                //slotDropArea.drag.source.y = 0//slotDropArea.drag.source.y + slotDropArea.drag.source.height/2;
            }
        }
    }

    DropShadow {
        id: shadow
        anchors.fill: circle
        color: "green"
        radius: 7
        samples: 14
        source: circle
    }
}
