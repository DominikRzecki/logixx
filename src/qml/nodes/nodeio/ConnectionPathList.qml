import QtQuick 2.15

import com.rzecki.logix 1.0

import "./"
import "../"

//This Item manages all connected Paths of a slot, it consists of a ListView and an ListModel
Item {
    id: connPathList

    property alias list: connPathList.list               //Alias to ListView

    property var oldFlickable: null

    property bool enabled: false                         //Needed to avoid falling into an infinite loop when closing Application

    required property var flickable                     //Flickable has to be set

    required property var parentSlot                    //ParentSlot has to be set

    property Component comp: Qt.createComponent("ConnectionPath.qml")

    property var list: []                               //Stores connected DragRectangles

    property int length: 0;                             //Needed to create the onLengthChanged callback


    Component.onDestruction: {                          //When the App is closed and thus connPathList is destroyed, enabled is set to false.
        enabled = false;
        for ( var i = 0; i < length; i++ ) {            //Destroying all connected ConnectionPaths when List Destroyed
            if ( list[i] !== null ) {
                list[i].parent.destroy();
            }
        }
    }

    onFlickableChanged: {
        /*if( oldFlickable !== null ){
            for (var i = 0; i < list.length; i++) {
                list[i].parent.parent = flickable.contentItem
            }
        }*/
        if ( flickable instanceof Flickable ) {
            if ( enabled ) {
                //create();
            } else {
                enabled == true;
            }
        } else {
            enabled = true;
        }
    }

    //Functions encapsulating js list methods, in order to enable the onLengthChanged callback
    function push(obj) {
        list.push(obj);
        length = list.length;
        if( !enabled )
            enabled = true;
    }

    function splice(ind, num) {
        list.splice(ind, num);
        length = list.length;
    }

    function indexOf(obj) {
        return list.indexOf(obj);
    }
    //#########

    //Called when list length changed
    onLengthChanged: {
        //If length is 0 and enabled is TRUE ( Application is still runing ) a new ConnectionPath is created.
        //IMPORTANT: if enabld is let out ante app i closed, it will fall into an infinite loop, because
        //qml tries to delete the connectionPaths, but they are created again when Length is 0.
        if(list)
            console.debug(parentSlot + "."+ connPathList +".list.length: " + list.length);
        if ( list.length === 0 && comp !== null && flickable instanceof Flickable && enabled) {
            create();
        } else if ( comp === null ) {
            comp = Qt.createComponent("ConnectionPath.qml");
        }
    }

    Component.onCompleted: {
        oldFlickable = flickable
    }

    //The following function is used to create ConnectionPaths and move their DragRectangles onto parentSlots DropArea, so it can be added to the Slot
    function create() {
        console.debug(connPathList + ".create()")
        var obj;

        if( comp.status === Component.Ready ) { //Creates components
            obj = comp.createObject( (flickable instanceof Flickable)? flickable.contentItem : flickable);
            obj.targetA.Drag.start();
            //console.debug(connPathList.parentSlot.parentNode.parent.parent + "---------------s--")
            //console.debug(connPathList.parentSlot.parentNode.x + "---------------s--")
            //console.debug(connPathList.parentSlot.parentNode.y + "---------------s--")
            obj.targetA.x = connPathList.parentSlot.parentNode.x + connPathList.parentSlot.posX - obj.targetA.width/2;
            obj.targetA.y = connPathList.parentSlot.parentNode.y + connPathList.parentSlot.posY + ((connPathList.parentSlot.listView !== null) ? connPathList.parentSlot.parent.y : 0) - obj.targetA.height/2;
            obj.targetA.Drag.drop();

            obj.targetB.Drag.start();
            obj.targetB.x = connPathList.parentSlot.parentNode.x + connPathList.parentSlot.posX - obj.targetA.width/2;
            obj.targetB.y = connPathList.parentSlot.parentNode.y + connPathList.parentSlot.posY + ((connPathList.parentSlot.listView !== null) ? connPathList.parentSlot.parent.y : 0) - obj.targetA.height/2;
            obj.targetB.Drag.drop();

//            obj.targetA.oldTargetSlot = parentSlot;
//            obj.targetB.oldTargetSlot = parentSlot;
        } else {
            console.debug(comp.errorString());
        }
    }
}
