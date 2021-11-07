import QtQuick 2.15

import com.rzecki.logix 1.0

import "../"
import "./"

//Rectangle that can be dragged is "leading" the path
/* ###############################
  Emits enter, exit and drop signals when dropped a object accepting drops.
  That signal can be caught and the targetX and targetY or targetRect.x/-y properties
  can be bound to a property of that object. That allows us to permanently bind the target position
  of the ConnectionPath to that object.
*/
Rectangle {
    id: targetRect
    width: 25
    height: 25

    //scale: 0.5

    color: "transparent"
    transformOrigin: Item.Center

    property alias enabled: dragHandler.enabled
    enabled: true

    //Holds the index of the DragRectangle in ConnectionPathList.list
    property int index: 0

    //The following property holds The state of the ConnectionPath, if the state hasnt been computed yet, it should be SlotType.UNKNOWN.
    property int connectionState: SlotState.UNKNOWN

    //This property holds the other DragRectangle
    required property DragRectangle otherRect

    //This property holds the target node. If there is none, it should default to null.
    property BasicNode targetNode: null

    //This property holds the target slot. If there is none, it should default to null.
    property Slot targetSlot: null

    //Holds the previously connected target slot
    property Slot oldTargetSlot: null

    // Workaround enabling real time update of the pathcoordinates, even when Drag.dragType is set to Drag.Automatic instead of Drag.Internal
    property bool dragActive: dragHandler.active

    onConnectionStateChanged: {
        parent.updateState();
        console.debug(targetRect + ".state: " + connectionState);
        if ( targetRect.targetSlot !== null && targetRect.targetSlot.type === SlotType.INPUT ){
            targetRect.targetSlot.update();
        }
    }

    Component.onDestruction: {
        console.log(targetRect + ".onDestruction()");
        //Deleting references in other objects, if DragRectangle destroyed
        if ( targetSlot !== null) {
            targetRect.index = targetRect.targetSlot.connectionList.indexOf(targetRect);
            if( targetRect.index !== -1 )
                targetSlot.connectionList.splice( targetRect.index, 1);
        } else if ( oldTargetSlot !== null ) {
            targetRect.index = targetRect.oldTargetSlot.connectionList.indexOf(targetRect);
            if( targetRect.index !== -1 )
                oldTargetSlot.connectionList.splice( targetRect.index, 1);
        }
    }

    Drag.hotSpot.x: width/2
    Drag.hotSpot.y: height/2

    onDragActiveChanged: {
        //<=3=>
        if (dragActive) {
            console.debug(targetRect + " : drag started");
            Drag.start();
        } else {
            console.debug(targetRect + " : drag finished");
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

        onActiveChanged: {
            //<=2=>
            //The functions are called in the order of the number n of <=n=>
            console.debug(targetRect + " : " + "onActiveChanged: " + active);

            // checks if dropped onto nothing or itself
            if( !active ) {
                if( targetRect.Drag.target === null || targetRect.Drag.target.parent === otherRect.targetNode ) {
                    //If the rectangle is dropped outside a an object or onto the other DragRectangle, it returns to 0 0
                    if ( otherRect.targetSlot !== null && otherRect.targetSlot.connectionList.length <= 2 ) {
                        targetRect.x = otherRect.x;
                        targetRect.y = otherRect.y;
                        targetRect.targetNode = otherRect.targetNode;
                        targetRect.targetSlot = otherRect.targetSlot;
                    } else {
                        targetRect.parent.destroy();
                    }

                // checks if dropped onto another BasicNode
                } else if ( targetRect.Drag.target.parent instanceof BasicNode ) {

                    //Connection target is set to BasicNode
                    targetRect.targetNode = targetRect.Drag.target.parent;

                    //targetSlot and oldTargetSlot is set to the newly created slot
                    targetRect.targetSlot = targetRect.targetNode.slotList.list.itemAtIndex(targetRect.targetNode.slotList.count-1).children[0]
                    if( oldTargetSlot === null ) {
                        oldTargetSlot = targetSlot;
                    }
                    /*
                    If targetRect is dropped onto a instance of BasicNode, then the property "permanent" of a assigned "Slot",
                    which was created before, is set to true and targetRect is moved onto that Slot, so it can trigger its DropAreas onDropped.
                    See BasicGate.qml for more info.
                    */
                    targetRect.targetSlot.parent.permanent = true;

                    //Bindings x and y of targetRect to the targetSlot
                    targetRect.x = targetNode.x - targetRect.width/2;
                    targetRect.y = targetNode.y - targetRect.height/2 + targetRect.targetNode.slotList.list.height / (targetRect.targetNode.slotList.count+1) * targetRect.targetNode.slotList.count;
                // checks if dropped onto another Slot, if yes, setting target to that Slot
                } else if ( targetRect.Drag.target.parent instanceof Slot ) {
                    targetRect.targetSlot = targetRect.Drag.target.parent;
                    if( oldTargetSlot === null ) {
                        oldTargetSlot = targetSlot;
                    }

                    targetRect.targetNode = targetRect.Drag.target.parent.parentNode;

                    console.debug( targetRect + ".target: " + targetRect.targetNode);
                }
                //setting oldTargetSolt to slot
                targetRect.oldTargetSlot = targetRect.targetSlot;

            //Cleaning up oldTarget if oldTarget is not same as new target.
            } else {
                console.debug( targetRect + " disconnected from: " + targetRect.oldTargetSlot );

                var oldTrgt = targetSlot; //Temporrily storing targetSlot
                //Removing the DragRectangle from ConnectionPathList and updating the ConnectionPath and Slot
                targetSlot = null;
                targetNode = null;

                targetRect.index = targetRect.oldTargetSlot.connectionList.indexOf(targetRect);
                if( targetRect.index !== -1 )
                    targetRect.oldTargetSlot.connectionList.splice(targetRect.index, 1);
                targetRect.oldTargetSlot.update();
                targetRect.parent.updateState();

                //setting oldTarget to current target
                targetRect.oldTargetSlot = null//oldTrgt;
            }
        }
    }

}
