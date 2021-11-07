import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15

import com.rzecki.logix 1.0

import "backend"
import "nodes"
import "nodes/intermediary"
import "nodes/input"
import "ui"

ApplicationWindow {
    id: appWindow
    visible: true
    width: (Qt.platform.os === "android" || Qt.platform.os === "ios") ? Screen.desktopAvailableWidth : Screen.desktopAvailableWidth/2
    height: Screen.desktopAvailableHeight


    //Screen.orientationUpdateMask:  Qt.LandscapeOrientation | Qt.PortraitOrientation
    //Screen.orientationUpdateMask: (Qt.platform.os === "android" || Qt.platform.os === "ios") ? Qt.LandscapeOrientation : Qt.LandscapeOrientation | Qt.PortraitOrientation;

    //Material.theme: Material.Amber
    Material.accent: Material.Red

    property string display
    title: qsTr("logixx")

    Component.onCompleted: {
        UndoBuffer.setFlickable(flickable.contentItem);
        UndoBuffer.setNodecreator(nodeCreator);
    }

    onActiveFocusItemChanged: (obj) => {
        editPane.currentFocusItem = activeFocusItem;
    }
    /*Item {
        id: flickableRect
        anchors.fill: parent
        scale: 1.0 + (grid.slider.value)*/
    Flickable {
        id: flickable

        anchors.fill: parent

        boundsBehavior: Flickable.StopAtBounds


        clip: true

        contentWidth: 4000
        contentHeight: 4000
        contentX: 1500
        contentY: 1500

        contentItem.clip: true
        contentItem.scale: 1.0 - ( ( 1 - grid.slider.value) * 0.5 )
        //scale:
        interactive: true


        //contentItem.scale: 0.8
        contentItem.children: [
            Rectangle {
                id: rect
                anchors.fill: parent
                border.color: "red"
                border.width: 2
                color: "transparent"

            },
            DropArea {
                id: nodeDropArea
                anchors.fill: rect
                keys: ['disabled']
            }
        ]
    }
    //}


    GridLayout {
        id: grid
        anchors.fill: parent
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 10
        anchors.topMargin: 10

        columns: 3
        rows: 3

        property alias slider: scaleSlider
        //layoutDirection: Qt.LeftToRight



        MenuBarPane {
            id: menubarpane
            Layout.row: 0
            Layout.column: 0
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop


        }

        CreatePane {
            id: createpane
            Layout.row: 1
            Layout.column: 0
            Layout.fillHeight: true
            Layout.maximumHeight: grid.height / 2
            //Layout.minimumWidth: 200
            Layout.alignment: Qt.AlignLeft | Qt.AlignHCenter
        }
        Button {
            id: createPanetoggleButton
            Layout.row: 2
            Layout.column: 0
            Layout.alignment: Qt.AlignBottom
            Material.accent: Material.Blue
            Material.elevation: 10
            text: "toggle"
            onPressed: {
                createpane.visible = !createpane.visible
            }
        }

        Item {
            id: gridItem
            Layout.row: 2
            Layout.column: 1
            Layout.alignment: Qt.AlignBottom
            width: scaleSlider.width
            height: scaleSlider.height + scaleText.height
            Text {
                id: scaleText
                text: Math.round( (50 + ( scaleSlider.value * 0.5)*100 )) + "%"
                y: 0
                x: scaleSlider.width * ( scaleSlider.value * 0.87)
            }
            Slider {
                y: 15
                id: scaleSlider
                value: 0.5
                orientation: Qt.Horizontal
            }
        }

        EditPane {
            id: editPane
            Layout.row: 1
            Layout.column: 2
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
        }

        Button {
            id: editPanetoggleButton
            Layout.row: 2
            Layout.column: 2
            Layout.alignment: Qt.AlignBottom | Qt.AlignRight
            Material.accent: Material.Blue
            Material.elevation: 10
            text: "toggle"
            onPressed: {
                editPane.visible = !editPane.visible
            }
        }

    }

    NodeCreator {
        id: nodeCreator
    }
    Pane {
        id: aboutPane

        x: parent.width/2 - width/2
        y: parent.height/2 - height/2


        visible: menubarpane.aboutVisible

        Material.elevation: 11
        anchors.margins: 15
        //clip: true

        GridLayout {

            anchors.fill: parent

            columns: 3
            rows: 3
            Text {
                id: aboutTitle
                text: qsTr("About")
                font.pointSize: 30
                font.bold: true
            }

            Image {
                id: aboutImg
                source: "qrc:/logo.svg"
                Layout.column: 0
                Layout.row: 1

                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            }


            TextEdit {
                readOnly: true
                textFormat: Text.RichText
                onLinkActivated: Qt.openUrlExternally(link)
                text: " <html>
                        <div style='font-size: 30px;'>Logixx "+ Qt.application.version +"</div>
                        <p>
                            <div style='font-size: 20px;'> A simple logic gate simulator. </div>
                            <div style='font-size:15px;'> license: </div>
                            <a style='font-size: 15px; 'href='https://www.gnu.org/licenses/gpl-3.0-standalone.html'>  GNU GPLv3</a>
                            <div style='font-size:15px;'> contribute: </div>
                            <a style='font-size: 15px; 'href='https://github.com/DominikRzecki/logixx'> GitHub</a>
                        </p>
                        <p>
                            <div style='font-size: 15px;'> creator: </div>
                            <span style='font-size: 15px;'>\t Dominik Rzecki </span>
                            <div style='font-size: 15px;'> mail: </div>
                            <a style='font-size: 15px; 'href='mailto:drzecki@student.tgm.ac.at'> drzecki@student.tgm.ac.at</a>
                        </p>
                    </html>"

                Layout.column: 1
                Layout.row: 1

                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.NoButton // we don't want to eat clicks on the Text
                    cursorShape: parent.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
                }
            }

            Button {
                id: aboutPaneClose
                text: "close"

                onPressed: {
                    menubarpane.aboutVisible = false;
                }

                Layout.column: 2
                Layout.row: 2

                Layout.alignment: Qt.AlignRight | Qt.AlignBottom
            }
        }
    }
}
/*##^##
Designer {
    D{i:0;formeditorZoom:0.25}
}
##^##*/
