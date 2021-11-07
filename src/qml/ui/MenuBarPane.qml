import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtGraphicalEffects 1.0
import com.rzecki.logix 1.0
Item {
    id: menurect
    height: menubar.height
    width: menubar.width

    property alias aboutVisible: aboutAction.aboutPaneVisible

    MenuBar {
        id: menubar

        Menu {
            title: qsTr("&File")

            Action {
                text: qsTr("&Open")
                enabled: false
            }
            Action {
                text: qsTr("Open Recent")
                enabled: false
            }
            Action {
                text: qsTr("&Save")
                enabled: false
            }
            Action {
                text: qsTr("Save &As")
                enabled: false
            }
            MenuSeparator {}

            Action {
                text: qsTr("&Quit")
                onTriggered: {
                    appWindow.close();
                }
            }
        }

        Menu {
            title: qsTr("&Edit")
            Action {
                text: qsTr("&Undo")
                onTriggered: {
                    UndoBuffer.undo();
                }
            }
            Action {
                text: qsTr("&Redo")
                enabled: false
                onTriggered: {
                    UndoBuffer.redo();
                }
            }
        }
        Menu {
            id: helpMenu
            title: qsTr("&Help")
            Action {
                id: aboutAction
                text: qsTr("&About")
                property bool aboutPaneVisible: false
                onTriggered: {
                    aboutPaneVisible = true;
                }
            }
        }
    }



    DropShadow {
        id: menushadow
        anchors.fill: menubar
        source: menubar
        radius: 10
        samples: 15
        color: "#80000000"
    }
}
