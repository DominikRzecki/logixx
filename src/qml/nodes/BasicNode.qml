import QtQuick 2.15
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.4
import com.rzecki.logix 1.0

import "nodeio"

Item {
    id: basicnode
    width: 100
    height: 100
    color: "white"

    property alias color: rectangle.color
    property alias taphandler: taphandler
    property alias draghandler: draghandler
    property bool enabled: true
    property var keys: []
    property NodeBackend backend

    property bool ready: false

    //scale: (parent.parent instanceof Flickable ) ? 0.5 : 1

    backend: NodeBackend {
        type: NodeType.BASIC
    }

    states: [
        //Basicnode cant interact with other nodes, if disabled
        State {
            name: "disabled"
            PropertyChanges {
                target: basicnode
                enabled: false
                Drag.keys: ['disabled']
                keys: Drag.keys
            }
        },
        State {
            name: "enabled"
            PropertyChanges {
                target: basicnode
                enabled: true
                Drag.keys: []
                keys: Drag.keys
            }
        }
    ]

    Rectangle {
        id: rectangle
        anchors.fill: basicnode
        onColorChanged: {
            update();
        }
    }

    DropShadow {
        id: shadow
        anchors.fill: rectangle
        color: "#80000000"
        radius: 10
        samples: 15
        source: rectangle
    }

    TapHandler {
        id: taphandler
        target: parent
        acceptedDevices: PointerDevice.AllDevices
        dragThreshold: 5
        onTapped: {
            forceActiveFocus()
        }
    }

    // Workaround enabling real time update of the pathcoordinates, even when Drag.dragType is set to Drag.Automatic instead of Drag.Internal
    property bool dragActive: draghandler.active

    onDragActiveChanged: {
        //<=3=>
        if (dragActive) {
            console.debug(basicnode + " : drag started");
            Drag.start();
        } else {
            console.debug(basicnode + " : drag finished");
            Drag.drop();
        }
    }

    /*
    When Drag.Automatic is set, the drop signal will be emited with a valid drop.source, otherwise
    the drop source will be null.
    */

    Drag.dragType: Drag.Automatic


    onXChanged: {
        //console.debug(basicnode.x + " - " + basicnode.y)
    }

    DragHandler {
        id: draghandler
        target: parent
        onActiveChanged: {
            if( active ) {
                forceActiveFocus();
            } else {
                if ( basicnode.state === "disabled"){
                //handles first drop event makes the main flickable the parent
                    if ( basicnode.Drag.target !== null && basicnode.Drag.target.parent.parent instanceof Flickable ){
                        console.debug( "node "+ basicnode + " added to: " + basicnode.Drag.target.parent.parent )
                        var coords = basicnode.mapToItem(basicnode.Drag.target.parent.parent.contentItem, 0, 0);
                        //var coords = Qt.vector2d()
                        basicnode.parent = basicnode.Drag.target.parent.parent.contentItem
                        //Setting the proper coords of basicnode
                        basicnode.x = coords.x
                        basicnode.y = coords.y
                        basicnode.state = "enabled";
                        basicnode.enabled = true;
                        basicnode.ready = true;
                        var op = Qt.createQmlObject("import com.rzecki.logix 1.0; Operation{}", basicnode);
                        var ptr = Qt.createQmlObject("import com.rzecki.logix 1.0; OperationParam{}", op)
                        var type = Qt.createQmlObject("import com.rzecki.logix 1.0; OperationParam{}", op)
                        var x = Qt.createQmlObject("import com.rzecki.logix 1.0; OperationParam{}", op)
                        var y = Qt.createQmlObject("import com.rzecki.logix 1.0; OperationParam{}", op)
                        op.type = OperationType.CREATE;
                        ptr.prop = "object";
                        ptr.val = basicnode;
                        type.prop = "backend.type"
                        type.val = backend.type
                        x.val = basicnode.x
                        y.val = basicnode.y
                        op.pushParam(ptr);
                        op.pushParam(type);
                        op.pushParam(x);
                        op.pushParam(y);
                        UndoBuffer.push(op);
                    } else if (!( basicnode.Drag.target.parent.parent instanceof Flickable) && basicnode.state !== "enabled"){
                        basicnode.destroy();
                    }
                }

                //enables grid snapping
                basicnode.x = basicnode.x - basicnode.x % 10
                basicnode.y = basicnode.y - basicnode.y % 10
            }
        }
    }

    onFocusChanged: {
        if (focus && enabled) {
            shadow.radius = 15
            shadow.samples = 20
            basicnode.z = 3
            console.debug(basicnode + "focus active");
        }else{
            basicnode.z = 2
            shadow.radius = 10
            shadow.samples = 15
            console.debug(basicnode + "focus inactive");
        }
    }
}
