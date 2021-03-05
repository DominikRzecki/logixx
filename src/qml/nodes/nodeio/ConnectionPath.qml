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
    width: targetX-x
    height: targetY-y

    //Theese properties are aliases for the position of targetRect.
    property alias targetX: targetRect.x
    property alias targetY: targetRect.y

    //This property holds the target node. If there is none, it should default to null.
    property BasicNode targetNode

    //This property holds the target slot. If there is none, it should default to null.
    property Slot targetSlot

    // Holds the previously connected target slot
    property Slot oldTargetSlot: null

    //The following property holds The state of the ConnectionPath, if the state hasnt been computed yet, it should be SlotType.UNKNOWN.
    property int connectionState: SlotState.UNKNOWN

    //When connectionState changes, the following function is called.
    onConnectionStateChanged: {
        console.debug(shape + ".state: " + connectionState)

        //target.currentState property is set.
        if(targetSlot !== null) {
            targetSlot.currentState = connectionState;
        }

        if ( connectionState === SlotState.HIGH) {
            //if the connectionState is HIGH, the visual color of the path is set to red, else it defaults to black.
            path.strokeColor = "red";
            circle.fillColor = "red";
        } else {
            path.strokeColor = "black";
            circle.fillColor = "black";
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
        startX: 0; startY: 0
        capStyle: ShapePath.RoundCap

        PathLine {
            id: pathlineS1
            x: (path.startX === targetPoint.x) ? path.startX : path.startX + 20;
            y: path.startY
        }
        PathLine {
            id: pathlineS2
            x: ( pathlineE1.x > pathlineS1.x ) ? ( targetPoint.x - path.startX ) / 2 : pathlineS1.x
            y: ( path.startY === targetPoint.y && path.startX === targetPoint.x ) ? 0 : ( pathlineE1.x > pathlineS1.x ) ?  path.startY : (targetPoint.y >= path.startY) ? shape.parent.height / 2 + 20 : -shape.parent.height / 2 - 20
        }

        PathLine {
            id: pathlineE2
            x: ( pathlineE1.x > pathlineS1.x) ? ( targetPoint.x - path.startX ) / 2 : pathlineE1.x
            y: ( path.startY === targetPoint.y && path.startX === targetPoint.x ) ? 0 : ( pathlineE1.x > pathlineS1.x) ?  targetPoint.y : (targetPoint.y >= path.startY) ? shape.parent.height / 2 + 20 : -shape.parent.height / 2 - 20
        }

        PathLine {
            id: pathlineE1
            x: (path.startX === targetPoint.x) ? targetPoint.x : targetPoint.x - 20;
            y: targetPoint.y
        }
        //target coords are bound to targetRect
        PathLine {
            id: targetPoint;
            x: targetRect.x+targetRect.width/2;
            y: targetRect.y+targetRect.height/2;
        }
    }

    Circle {
        id: circle
        posX: 0
        posY: 0
        z: shape.parent.z+0.5
        fillColor: "black"
        strokeColor: "transparent"
    }
    //Rectangle that can be dragged is "leading" the path
    /* ###############################
      Emits enter, exit and drop signals when dropped a object accepting drops.
      That signal can be caught and the targetX and targetY or targetRect.x/-y properties
      can be bound to a property of that object. That allows us to permanently bind the target position
      of the ConnectionPath to that object.
    */
    Rectangle {
        id: targetRect
        x: -width/2
        y: -height/2
        z: circle.z+0.2
        width: 20
        height: 20
        color: "transparent"

        Drag.hotSpot.x: width/2
        Drag.hotSpot.y: height/2

        // Workaround enabling real time update of the pathcoordinates, even when Drag.dragType is set to Drag.Automatic instead of Drag.Internal
        property bool dragActive: dragHandler.active

        onDragActiveChanged: {
            //<=3=>
            if (dragActive) {
                console.debug(shape + " : drag started");
                Drag.start();
            } else {
                console.debug(shape + " : drag finished");
                Drag.drop();
            }
        }
        /*
        When Drag.Automatic is set, the drop signal will be emited with a valid drop.source, otherwise
        the drop source will be null.
        */
        Drag.dragType: Drag.Automatic

        //dragHandler enables draging of the Rectangle
        DragHandler {
            id: dragHandler
            target: targetRect
            acceptedButtons: Qt.LeftButton
            acceptedDevices: PointerDevice.AllDevices

            enabled: shape.parent.enabled

            onActiveChanged: {
                //<=2=>
                //The functions are called in the order of the number n of <=n=>
                console.debug(shape + " : " + "onActiveChanged: " + active);

                // checks if dropped onto nothing or itself
                if(targetRect.Drag.target === null || targetRect.Drag.target.parent === shape.parent) {
                    //If the rectangle is dropped outside a n object or onto its own parent, it returns to 0 0
                    targetRect.x = -targetRect.width/2;
                    targetRect.y = -targetRect.height/2;

                    //setting target to null
                    shape.targetNode = null;
                    shape.targetSlot = null;

                // checks if dropped onto another BasicNode
                } else if ( targetRect.Drag.target.parent instanceof BasicNode ) {

                    //Connection target is set to BasicNode
                    shape.targetNode = targetRect.Drag.target.parent

                    //targetSlot and oldTargetSlot is set to the newly created slot
                    shape.targetSlot =  shape.targetNode.children[3].itemAtIndex(shape.targetNode.children[3].count-1).children[0]
                    shape.oldTargetSlot = shape.targetSlot
                    /*
                    If targetRect is dropped onto a instance of BasicNode, then the property "permanent" of a assigned "Slot",
                    which was created before, is set to true and targetRect is moved onto that Slot, so it can trigger its DropAreas onDropped.
                    See BasicGate.qml for more info.
                    */

                    shape.targetSlot.parent.permanent = true;
                    targetRect.x = targetRect.Drag.target.parent.x - shape.parent.x - targetRect.width/2 - shape.parent.width;
                    targetRect.y = targetRect.Drag.target.parent.y - shape.parent.y - targetRect.height/2 - shape.parent.height/2 + shape.targetNode.children[3].height / (shape.targetNode.children[3].count+1) * shape.targetNode.children[3].count;

                // checks if dropped onto another Slot, if yes, setting target to that Slot
                } else if ( targetRect.Drag.target.parent.children[0] instanceof Slot ) {
                    shape.targetSlot = targetRect.Drag.target.parent.children[0];
                    //setting oldtargetsolt to slot
                    shape.oldTargetSlot = shape.targetSlot

                    console.debug( shape + ".target: " + shape.targetNode);
                }

                //
                //Cleaning up oldTarget if oldTarget is not same as new target.
                if ( shape.oldTargetSlot !== targetSlot && active ) {
                    console.debug( shape + " disconnected from: " + shape.oldTargetSlot )

                    // Setting slotstate to UNDEFINIED if Slot
                    shape.oldTargetSlot.currentState = SlotState.UNDEFINED;

                    // Setting property source of oldTarget to null
                    shape.oldTargetSlot.source = null;

                    //setting oldTarget to current target
                    shape.oldTargetSlot = shape.targetSlot;
                }
            }
        }
    }

    TapHandler {
        target: parent
        onTapped: {
            forceActiveFocus()
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

    onFocusChanged: {
        if (focus) {
            shadow.radius = 15
            shadow.samples = 20
            shape.z = shape.parent.z + 2
            console.log("act\n");
        }else{
            shape.z = shape.parent.z + 1
            shadow.radius = 10
            shadow.samples = 15
            console.log("inact\n");
        }
    }
}
