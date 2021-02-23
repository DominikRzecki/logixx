import QtQuick 2.15
import QtQml.Models 2.15
import QtQuick.Controls 2.15
import QtQml 2.15
import com.rzecki.logix 1.0

import "../"
import "../nodeio/"


BasicNode {
    id: basicNode

    property alias connectionPath: connectionPath

    //BasicGate has one Output (target), a connectionPath
    backend.target: connectionPath

    DropArea {
        id: dropArea
        width: basicNode.width-10
        z: basicNode.z + 0.25
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        //keys: ["text/plain"]
        onEntered: (drag) => {
                       // <=1=>
                       //Creates a slot when drag entered.
                       console.debug(basicNode + " : " + "onEntered");
                       if( drag.source.parent.parent !== this.parent ) {
                           slotModel.append({"ind" : slotView.count, "perm" : false});
                       }
                   }

        onExited: (drag) => {
                      // <=2 or 4=>
                      //Removes a slot when drag exited without dropping.
                      console.debug(basicNode + " : " + "onExited");
                      if( dropArea.drag.source.parent.parent !== this.parent && slotView.itemAtIndex(slotView.count-1).permanent === false) {
                          slotModel.remove(slotModel.count-1);
                      }
                  }
    }

    ListModel {
        id: slotModel
        dynamicRoles: true
    }

    ListView {
        id: slotView
        x: -10
        width: 20
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        interactive: false
        anchors.bottomMargin: 0
        anchors.topMargin: 0
        anchors.leftMargin: 0
        orientation: Qt.Vertical
        //verticalLayoutDirection: slotView.BottomToTop
        spacing: slotView.height/(slotView.count+1)
        transformOrigin: Item.Center

        model: slotModel
        delegate: Item {
            id: slotDelegate
            width: 20
            x: -10

            property int index: ind
            property bool permanent: perm

            Slot {
                id: slot
                y: slotView.height/(slotView.count+1)/2
                x: 5
                z: basicNode.z + 0.5 //(source === null) ? basicNode.z + 0.5 : source.parent.z + 0.3
                width: 10
                height: 10
                radius: 3
                color: "green"

            }

            DropArea {
                id: slotDropArea
                enabled: true
                y: slotView.height/(slotView.count+1)-5
                x: slotDelegate.x+10
                width: slotDelegate.width
                height: 20

                onEntered: (drag) => {
                    console.debug(basicNode + " : " + slotDropArea + " : " + "onEntered");
                }

                onExited: {
                    console.debug(basicNode + " : " + slotDropArea + " : " + "onExited");
                    //if (slot.source )
                    if (slotDropArea.drag.source.parent.target === slot) {
                        slot.currentState = SlotState.UNDEFINED;
                        slotDropArea.drag.source.parent.target = null;
                        slot.source = null;
                    }

                }

                onDropped: {
                    // <=3=>
                    console.debug(basicNode + " : " + slotDropArea + " : " + "onDropped");
                    if(slotDropArea.drag.source.parent.parent !== basicNode) {
                        //Droped on another node
                        //setting the source of the slot to the connectionPath that has been dropped
                        slot.source = slotDropArea.drag.source;

                        //setting the target of the drop source to slot
                        slot.source.parent.target = slot

                        //setting slot state to connectionState of the source connectionPath
                        slot.currentState = slot.source.parent.connectionState;

                        //binding visual properties
                        slot.source.x = Qt.binding( function() {
                            return basicNode.x - slot.source.parent.parent.x - slot.source.width/2 - slot.source.parent.parent.width;
                        } )
                        slot.source.y = Qt.binding( function() {
                            return basicNode.y - slot.source.parent.parent.y - slot.source.height/2 - slot.source.parent.parent.height/2 + slotView.height/(slotView.count+1)*(slotDelegate.index+1);
                        } )

                    } else {

                        // reset path if connection impossible
                        //slotDropArea.drag.source.x = 0//slotDropArea.drag.source.x + slotDropArea.drag.source.width/2;
                        //slotDropArea.drag.source.y = 0//slotDropArea.drag.source.y + slotDropArea.drag.source.height/2;
                    }
                }
            }

        }
    }

    ConnectionPath{
        id: connectionPath
        x: basicNode.width
        y: basicNode.height/2
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.9;height:480;width:640}
}
##^##*/
