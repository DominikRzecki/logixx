import QtQuick 2.0
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15

import "../nodes"

Pane {
    id: editPane

    contentWidth: columnLayout.implicitWidth
    contentHeight: columnLayout.implicitHeight

    property var currentFocusItem: null
    property var lastFocusNode

    onCurrentFocusItemChanged: {
       if ( currentFocusItem instanceof BasicNode ) {
            if( currentFocusItem !== lastFocusNode) {
                lastFocusNode = currentFocusItem;
                //lastFocusNode.backend.name = Qt.binding(function() { return nodeItemNameInput.text; })
            }
       }
    }


    Material.elevation: 10


    focusPolicy: Qt.NoFocus
    ColumnLayout {
        id: columnLayout
        anchors.fill: parent

        Text {
            id: paneTitle
            text: qsTr("Edit")
            font.pointSize: 15
        }

        GridLayout {
            Text {
                id: nodeItemName
                text: "name: "
                Layout.row: 0
                Layout.column:0
            }

            TextField {
                id: nodeItemNameInput
                //text: ((lastFocusNode) ? lastFocusNode.backend.name : "")
                onTextChanged: {
                    //lastFocusNode.backend.name = text;
                }
                Binding on text {
                    //target: lastFocusNode.backend
                    //property: "name"
                    when: ( nodeItemNameInput.activeFocus && lastFocusNode !== null)
                    //restoreMode: Binding.RestoreBinding
                    value: lastFocusNode.backend.name
                }


                Layout.row: 0
                Layout.column:1
            }

        }

        Button {
            id: deleteButton
            text: qsTr("delete")
            Material.accent: Material.Red
            Layout.alignment: Qt.AlignHCenter

            onClicked: {
                if(lastFocusNode !== undefined) {
                    lastFocusNode.destroy();
                    lastFocusNode = null;
                }
            }
        }

    }

    // Disables dropping nodes on the CreatePane
    DropArea {
        id: dropArea
        anchors.fill: parent
        keys: ["disabled"]
        onEntered: (drag) => {
                       drag.source.parent = editPane;
                   }
    }
}
