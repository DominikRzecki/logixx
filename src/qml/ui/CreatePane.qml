import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.15
import QtQml.Models 2.3

import "../nodes"
import "../nodes/intermediary"

Pane {
    id: toolpane

    contentWidth: rowLayout.implicitWidth
    contentHeight: rowLayout.implicitHeight

    Material.elevation: 10

    ColumnLayout {
        id: columnLayout
        anchors.fill: parent

        RowLayout {
            id: rowLayout
            Layout.alignment: Qt.AlignTop

            StackLayout {
                id: stackLayout
                Layout.fillWidth: true
                Layout.fillHeight: true
                currentIndex: tabbar.currentIndex

                Layout.alignment: Qt.AlignLeft

                ScrollView {
                    id: scrollView
                    Layout.margins: 5
                    contentWidth: -1
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.minimumWidth: 100
                    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                    ScrollBar.horizontal.interactive: false

                    //This ListView holds the different types of Nodes
                    ListView {
                        id: nodeListView
                        anchors.fill: parent


                        model: ListModel {
                            ListElement {
                                src: "../nodes/input/SwitchInput.qml"
                            }
                            ListElement {
                                src: "../nodes/intermediary/AndGate.qml"
                            }
                        }

                        //Item delegate is responsible for creating nodes
                        delegate: Item {
                            property Component comp: null       //Holds the nodes component
                            property bool first: true           //true if first time created

                            height: 100
                            //x: nodeListView./2

                            onChildrenChanged: {
                                if(comp.status === Component.Ready)
                                    comp.createObject(this, {state: "disabled", x: this.x});
                            }

                            Component.onCompleted: {
                                if(comp === null) {
                                    comp = Qt.createComponent(src);
                                }
                                if( first && comp.status === Component.Ready) {
                                    comp.createObject(this, {state: "disabled", x: this.width});
                                }
                                first = false;
                            }
                        }
                    }

                }
            }
            ListView {
                id: tabbar

                width: 60

                Layout.alignment: Qt.AlignRight
                Layout.fillHeight: true

                interactive: false
                clip: true

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
                            name: "basic"
                            index: 2
                        }
                        ListElement {
                            name: "flipflop"
                            index: 2
                        }
                    }

                delegate: Button {
                    height: parent.width - 10
                    width: parent.width
                    text: qsTr(name)
                    font.pointSize: 8
                    checkable: true
                    checked: false
                    onClicked: tabbar.currentIndex = index

                    ButtonGroup.group: exclusiveGroup
                }
                ButtonGroup {
                    id: exclusiveGroup
                }
            }
        }
    }
    DropArea {
        anchors.fill: parent
        keys: ["disabled"]
    }
}
