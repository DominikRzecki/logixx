import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Item {
    id: item1
    width: 45
    height: 25
    Row {
        id: columns
        width: 45
        height: 25
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        Column {
            id: rows
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: columns.width/3

            Button {
                id: b1
                y: 0
                width: parent.width
                height: parent.height/2
                text: "+"
                font.pixelSize: item1.height/ 2
                onPressed: {
                    textin.text++;
                }
            }

            Button {
                y: parent.height/2
                width: parent.width
                height: parent.height/2
                text: "-"
                font.pixelSize: item1.height/ 2
                onPressed: {
                    textin.text--;
                }
            }
        }
        Rectangle {
            id: rect
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: columns.width/3*2
            color: b1.color
            TextInput {
                id: textin
                anchors.fill: parent
                font.pixelSize: item1.height
                maximumLength: 2
                validator: IntValidator {bottom: 2; top: 16}
                text: "2"
            }
        }

    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:10}
}
##^##*/
