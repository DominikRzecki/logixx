import QtQuick 2.15
import QtGraphicalEffects 1.0
import QtQuick.Shapes 1.15
import "../"
import "../intermediary"

import com.rzecki.logix 1.0

/*############################################################################

  ConnectionPath.qml
  Enables connecting different Nodes visually, using a Line(path),
  which can be draged using a invisible rectangle(targetRect).
  The start of that line is marked by a dot (circle)

#############################################################################*/

Shape {
    id: shape
    antialiasing: true

    width: targetA.x-targetB.x
    height: targetA.y-targetB.y


    //Holds true, if connPath enabled
    property bool enabled: true

    //Theese are aliases for the target Rectangles
    property alias targetA: targetA
    property alias targetB: targetB

    //Thees properties hold aliases to the connectionState properties of targetA and targetB
    property alias stateA: targetA.connectionState
    property alias stateB: targetB.connectionState

    //The following property holds The state of the ConnectionPath, if the state hasnt been computed yet, it should be SlotType.UNKNOWN.
    property int connectionState: ( stateA < stateB ) ? stateA : stateB;

    Component.onDestruction: {
        console.log(shape + ".onDestruction()");
    }

    //Theese two callbacks call updateState() when the connectionState of one of the two targets changes and set their target states to connectionState
    onStateAChanged: {
        console.debug(shape + " : onStateAChanged");
        //updateState();
    }

    onStateBChanged: {
        console.debug(shape + " : onStateBChanged");
       //updateState();
    }

    function updateState() {
        console.debug(shape + " : updateState()");

        if ( targetA.targetSlot !== targetB.targetSlot ) {
            if ( targetB.targetSlot !== null && targetA.targetSlot !== null ) {
                if ( targetA.targetSlot.type > targetB.targetSlot.type ) {
                    stateB = stateA;
                } else if ( targetA.targetSlot.type < targetB.targetSlot.type ) {
                    stateA = stateB;
                } else {
                    if ( targetA.targetSlot.type === SlotType.INPUT ) {
                        stateA = SlotState.UNDEFINED;
                        stateB = SlotState.UNDEFINED;
                    }
                }
            } else if ( targetA.targetSlot !== null ) {
                if ( targetA.targetSlot.type === SlotType.INPUT ) {
                    stateA = SlotState.UNDEFINED;
                    stateB = SlotState.UNDEFINED;
                } else {
                    stateB = stateA;
                }
            } else if ( targetB.targetSlot !== null ) {
                if ( targetB.targetSlot.type === SlotType.INPUT ) {
                    stateA = SlotState.UNDEFINED;
                    stateB = SlotState.UNDEFINED;
                } else {
                    stateA = stateB;
                }
            } else {
                stateA = SlotState.UNDEFINED;
                stateB = SlotState.UNDEFINED;
            }
        }
    }


    //When connectionState changes, the following function is called.
    onConnectionStateChanged: {
        console.debug(shape + ".state: " + connectionState)

        if ( connectionState === SlotState.HIGH) {
            //if the connectionState is HIGH, the visual color of the path is set to red, else it defaults to black.
            path.strokeColor = "red";
        } else {
            path.strokeColor = "black";
        }
    }

    //Path visualising the connection, between different Nodes
    /*######################################################

      Split into 4 dynamically adjustable segments(S1, S2, E2, E1) + start segment + target Segment

                           |20px-|
                   node1----
                   O       |
                   | start O----S1
                   O       |     |
                -  ---------     |
node.width/2+20 |                |
                -    E2---------S2      -
                      |                 | node.width/2+20
                      |    node2-----   –
                      |    |        |
                     E1---[] target |
                           |        O--..
                           O        |
                           |        |
                           ----------
                      |20px|

    #######################################################*/
    ShapePath {
        id: path
        strokeColor: "black"
        fillColor: "transparent"
        strokeWidth: 3
        startX: targetA.x + targetB.width / 2;
        startY: targetA.y + targetB.height / 2;
        capStyle: ShapePath.RoundCap

        //S1
        PathLine {
            id: pathlineS1
            x: ( path.startX === targetPoint.x ) ? path.startX : ( targetA.targetNode === null )? path.startX : ( targetA.targetNode.x + targetA.targetNode.width / 2 < shape.x + path.startX ) ? path.startX + 20 : path.startX - 20;
            y: path.startY
        }

        //S2
        PathLine {
            id: pathlineS2
            x: ( pathlineE1.x > pathlineS1.x ) ? (path.startX + targetPoint.x) / 2 : pathlineS1.x
            y: ( (path.startY === targetPoint.y && path.startX === targetPoint.x ) ) ? path.startY : ( pathlineE1.x > pathlineS1.x ) ?  path.startY : (path.startY + targetPoint.y ) / 2;
        }

        //E2
        PathLine {
            id: pathlineE2
            x: ( pathlineE1.x > pathlineS1.x ) ? (path.startX + targetPoint.x) / 2 : pathlineE1.x
            y: ( (path.startY === targetPoint.y && path.startX === targetPoint.x ) ) ? path.startY : ( pathlineE1.x > pathlineS1.x ) ?  targetPoint.y : (path.startY + targetPoint.y ) / 2
        }

        PathLine {
            id: pathlineE1
            x: ( path.startX === targetPoint.x ) ? targetPoint.x : ( targetB.targetNode === null )? targetPoint.x : ( targetB.targetNode.x + targetB.targetNode.width / 2 < shape.x + targetPoint.x ) ? targetPoint.x + 20 : targetPoint.x - 20;
            y: targetPoint.y
        }
        //target coords are bound to targetRect
        PathLine {
            id: targetPoint;
            x: targetB.x + targetB.width / 2;
            y: targetB.y + targetB.height / 2;
        }
    }

    DragRectangle {
        id: targetA

        x: -width/2
        y: -height/2

        otherRect: targetB

        enabled: shape.enabled
    }

    DragRectangle {
        id: targetB

        x: -width/2
        y: -height/2

        otherRect: targetA

        enabled: shape.enabled
    }
}
