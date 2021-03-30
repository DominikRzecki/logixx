import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.15
import QtQml.Models 2.3

import com.rzecki.logix 1.0

import "../nodes"
import "../nodes/intermediary"
import "elements"

Pane {
    id: createpane

    contentWidth: rowLayout.implicitWidth
    contentHeight: rowLayout.implicitHeight

    Material.elevation: 10

    ColumnLayout {
        id: columnLayout
        anchors.fill: parent

        Text {
            id: paneTitle
            text: qsTr("Add")
            font.pointSize: 15
        }

        RowLayout {
            id: rowLayout
            Layout.alignment: Qt.AlignTop


            StackLayout {
                id: stackLayout
                Layout.fillWidth: true
                Layout.fillHeight: true
                currentIndex: tabbar.currentIndex

                Layout.alignment: Qt.AlignLeft

                clip: true

                NodeList {
                    id: inputList
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.minimumWidth: 110

                    model: ListModel {
                        ListElement {
                            src: "qrc:/src/qml/nodes/input/SwitchInput.qml"
                            name: "switch"
                        }
                    }
                }

                NodeList {
                    id: outputList
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.minimumWidth: 100

                    model: ListModel {
                        ListElement {
                            src: "qrc:/src/qml/nodes/output/BasicOutput.qml"
                            name: "output"
                        }
                    }
                }
                NodeList {
                    id: gateList
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.minimumWidth: 100

                    model: ListModel {
                        ListElement {
                            src: "qrc:/src/qml/nodes/intermediary/AndGate.qml"
                            name: "AND"
                        }
                    }
                }
            }



            // Vertical Tabbar with buttons
            ListView {
                id: tabbar

                width: 60

                Layout.alignment: Qt.AlignRight
                Layout.fillHeight: true

                interactive: true
                clip: true

                z: -1

                property int currentIndex: 0

                model: ListModel {
                    id: tabbarmodel
                        ListElement {
                            name: "input"
                            index: 0
                        }
                        ListElement {
                            name: "output"
                            index: 1
                        }
                        ListElement {
                            name: "gate"
                            index: 2
                        }
                        ListElement {
                            name: "flipflop"
                            index: 3
                        }
                    }

                delegate: Button {
                    height: parent.width - 10
                    width: parent.width

                    text: qsTr(name)
                    font.pointSize: 8

                    checkable: true
                    checked: (index == tabbar.currentIndex)? true : false

                    onClicked: tabbar.currentIndex = index

                    ButtonGroup.group: exclusiveGroup
                }
                ButtonGroup {
                    id: exclusiveGroup
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
            drag.source.parent = createpane;
        }
    }
}
