import QtQuick 2.15
import QtQml.Models 2.15
import QtQuick.Controls 2.15
import QtQml 2.15
import com.rzecki.logix 1.0

import "../"
import "../nodeio/"


BasicNode {
    id: basicNode

    width: 100
    height: 100

    property alias outputSlot: outputSlot
    property alias slotList: slotView //alias to the slotView

    //BasicGate has one Output (target), a connectionPath
    backend.target: outputSlot

    FocusScope {
        anchors.fill: parent
        anchors.margins: 5
            Row {
                TextInput {
                    width: basicNode.width/2
                    text: basicNode.backend.name
                    enabled: basicNode.enabled
                }
            }
        }

        DropArea {
            id: dropArea
            width: basicNode.width-10
            z: basicNode.z + 0.25
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 10

            //Keys are "disabled" when basicNode disabled
            keys: basicNode.Drag.keys

            onEntered: (drag) => {
                           // <=1=>
                           //Creates a slot when drag entered.
                           console.debug(basicNode + " : " + "onEntered");
                           if( drag.source.otherRect.targetNode !== basicNode && drag.source.parent instanceof ConnectionPath) {
                               //slotModel.append(new NodeInput());
                               slotView.model.append({"ind" : slotView.model.count-1});
                               //slotView.model.get(slotView.model.count-1).children[0].index = slotView.model.count - 1;
                           }
                       }

            onExited: (drag) => {
                          // <=2 or 4=>
                          //Removes a slot when drag exited without dropping.
                          console.debug(basicNode + " : " + "onExited");
                          if( dropArea.drag.source.targetNode !== basicNode && slotView.list.itemAtIndex(slotView.count-1).permanent === false) {
                              slotView.model.remove(slotView.count-1);
                          }
                      }
        }

        //Manages dynamic slots
        SlotList {
            id: slotView
            anchors.top: parent.top
            anchors.bottom: parent.bottom
        }

        Slot {
            id: outputSlot
            posX: basicNode.width
            posY: basicNode.height/2
            parentNode: basicNode
            type: SlotType.OUTPUT
            color: "black"
            highlightColor: color
        }
    }

    /*##^##
Designer {
    D{i:0;formeditorZoom:0.9}
}
##^##*/
