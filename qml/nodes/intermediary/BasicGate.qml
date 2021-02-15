import QtQuick 2.15
import QtQml.Models 2.15
import QtQuick.Controls 2.15
import QtQml 2.15
import com.rzecki.logix 1.0

import "../"
import "../nodeio/"


BasicNode {
    id: basicNode

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
                       console.debug("entered");
                       if( drag.source.parent.parent !== this.parent ) {
                           slotModel.append({"ind" : listView.count, "perm" : false});
                       }
                   }

        onExited: (drag) => {
                        // <=2 or 4=>
                      console.debug("exited");
                      console.debug(dropArea.drag.source.parent.parent);
                      if( dropArea.drag.source.parent.parent !== this.parent && listView.itemAtIndex(listView.count-1).permanent === false) {
                          slotModel.remove(slotModel.count-1);
                      }
                  }
    }

    ListView {
        id: listView
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
        //verticalLayoutDirection: ListView.BottomToTop
        spacing: listView.height/(listView.count+1)
        transformOrigin: Item.Center

        ListModel {
            id: slotModel
            dynamicRoles: true
        }

        model: slotModel
        delegate: Item {
            id: slotDelegate
            width: 20
            x: -10

            property int index: ind
            property bool permanent: perm


            Slot {
                id: slot
                y: listView.height/(listView.count+1)/2
                x: 5
                width: 10
                height: 10
                radius: 3
                color: "green"
            }

            DropArea {
                id: slotDropArea
                enabled: true
                y: listView.height/(listView.count+1)-5
                x: slotDelegate.x+10
                width: slotDelegate.width
                height: 20

                onEntered: (drag) => {
                    console.debug("entered");
                }

                onExited: {
                    //slot.source.x = 0;
                    //slot.source.y = 0;
                    //slot.source = basicNode;
                }

                onDropped: {
                    // <=3=>
                    console.debug("dropped");
                    if(slotDropArea.drag.source.parent.parent !== basicNode && slotDropArea.drag.source !== basicNode){
                        console.debug("other");
                        slot.source = slotDropArea.drag.source;
                        console.debug(slotDelegate.index);
                        slot.source.x = Qt.binding( function() {
                            return basicNode.x - slot.source.parent.parent.x - slot.source.width/2 - slot.source.parent.parent.width;
                        } )
                        slot.source.y = Qt.binding( function() {
                            return basicNode.y - slot.source.parent.parent.y - slot.source.height/2 - slot.source.parent.parent.height/2 + listView.height/(listView.count+1)*(slotDelegate.index+1);
                        } )
                        slotDropArea.drag.source.parent.parent.backend.target = basicNode;
                        console.debug(slotDropArea.drag.source.parent.parent.backend.target);
                    }
                }
            }
        }
    }

    ConnectionPath{
        x: basicNode.width
        y: basicNode.height/2
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.9;height:480;width:640}
}
##^##*/
