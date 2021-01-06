import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls.Material 2.15

Window {
    visible: true
    width: Screen.desktopAvailableWidth/2
    height: Screen.desktopAvailableHeight
    title: qsTr("logixx")

    Flickable {
        id: flickable
        anchors.fill: parent
            flickDeceleration: 1999
            synchronousDrag: true
            //boundsMovement: Flickable.StopAtBounds
            boundsBehavior: Flickable.FollowBoundsBehavior
            contentWidth: 2000
            contentHeight: 2000
            contentX: contentWidth/2
            contentY: contentHeight/2
            focus: true
            interactive: true

            Node {
                id: nodec
                x: 50
                y: 50
                //z: 1
            }

            Node {
                id: nodeq
                x: 600
                y: 600
                //z: 0
            }
            Rectangle {
                x: 5
                y: 5
                color: "red"

            }

           /*onnectionPath{
                id: connPath
                x: 100
                y: 100
                z: 2
                width: 3000
                height: 3000
                originX: nodec.x
                originY: nodec.y-nodec.height/2
                target.x: nodeq.x
                target.y: nodeq.y-nodeq.height/2
            }*/
        }



    /*DragHandler{
        id: draghandler
        target: null
    }*/
}


