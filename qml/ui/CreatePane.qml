import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.15
import QtQml.Models 2.3

import "../nodes/intermediary"

Pane {
    id: toolpane

    Material.elevation: 6

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
                    contentWidth: -1
                    clip: true
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.minimumWidth: 150
                    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                    ScrollBar.horizontal.interactive: false

                    BasicGate {
                        x: stackLayout.width/3
                        y: 10
                    }
                }
            }
            ListView {
                id: tabbar

                width: 60

                Layout.alignment: Qt.AlignRight
                Layout.fillHeight: true

                interactive: false

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
}
