import QtQuick 2.15

import com.rzecki.logix 1.0

Item {
    id: nodeCreator
    property var comp: []
    property var urls: [ "qrc:/src/qml/nodes/BasicNode.qml",
                        "qrc:/src/qml/nodes/input/SwitchInput.qml",
                        "qrc:/src/qml/nodes/intermediary/AndGate.qml",
                        "qrc:/src/qml/nodes/output/BasicOutput.qml" ]

    Component.onCompleted: {
        for ( var i = 0; i < urls.length; i++ ) {
            comp.push(Qt.createComponent(urls[i]));
            if(comp[i].status !== Component.Ready) {
                console.debug(comp[i].errorString());
            }
        }
    }

    function create(parent, type, state = "enabled", x, y) {
        console.debug(parent + " " + type + " " + state + " " + x + " " + y)
        var obj;
        switch (type) {
        case NodeType.BASIC:
            obj = comp[0].createObject(parent, {state: state, x: x, y: y});
            break;
        case NodeType.SWITCH:
            obj = comp[1].createObject(parent, {state: state, x: x, y: y});
            break;
        case NodeType.AND:
            obj = comp[2].createObject(parent, {state: state, x: x, y: y});
            break;
        case NodeType.LAMP:
            obj = comp[3].createObject(parent, {state: state, x: x, y: y});
            break;
        default:
            obj = comp[0].createObject(parent, {state: state, x: x, y: y});
            break;
        }

        return obj;
    }
}
