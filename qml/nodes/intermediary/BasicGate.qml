import QtQuick 2.15
import QtQml.Models 2.15
import QtQml 2.15
import com.rzecki.logix 1.0

import "../"
import "../nodeio/"


BasicNode {
    id: basicNode

    /*DropArea {
        id: dropArea
        anchors.fill: parent
        //keys: ["text/plain"]
        onDropped: {
            console.log("dropped");
            listModel.append({});
            //list

            //= "backend.target", basicNode.parent)
            //drop.source.x= listModel.get(listModel.count-1).x     // Here is the problem, I cant access the properties of drop.source
        }
        onEntered: {
            console.log("entered")
        }
    }*/
    //backend.ta
    //backend

    /*Binding {
        target: backend
        property: "target"
        value: basicNode
    }*/

    DropArea {
        id: dropArea
        anchors.fill: parent
        //keys: ["text/plain"]
        onEntered: (drag) => {
            console.log("dropped");
        }
        onDropped: (drop) => {
            if (drop.hasText) {
                if (drop.proposedAction == Qt.MoveAction || drop.proposedAction == Qt.CopyAction) {
                    drop.acceptProposedAction()

                    //dropArea.drag.source.x = parent.x;
                }
            }
            console.log(dropArea.drag.source);
        }
    }

    /*NodeDropArea {
        id: dropArea
        anchors.fill: parent
        acceptingDrops: true
        onDropped: {
            console.log("dropped");
        }
    }*/

    //property list<Slot> inputs

    ListView {
        id: listView
        x: 0
        width: 10
        //height: parent.height
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        interactive: false
        anchors.bottomMargin: 0
        anchors.topMargin: 0
        anchors.leftMargin: 0
        spacing: listView.height/(listView.count+1)
        transformOrigin: Item.Center

        delegate: Item {
            Slot {
                y: listView.height/(listView.count+1)/2
                z: basicNode.z + 0.5
                width: 10
                height: 10
                radius: 3
                color: "green"

            }
        }
        model: ListModel {
            id: listModel

        }
    }

    ConnectionPath {
        x: basicNode.width
        y: basicNode.height/2
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.9;height:480;width:640}
}
##^##*/
