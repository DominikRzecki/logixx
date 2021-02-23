import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtGraphicalEffects 1.0

Item {
    id: menurect
    height: menubar.height
    width: menubar.width
    MenuBar {
        id: menubar

        Menu {
            title: qsTr("&File")

            Action {
                text: qsTr("&Open")
            }
            Action {
                text: qsTr("Open Recent")
            }
            Action {
                text: qsTr("&Save")
            }
            Action {
                text: qsTr("Save &As")
            }
            MenuSeparator {}

            Action {
                text: qsTr("&Quit")
            }
        }

        Menu {
            title: qsTr("&Edit")
        }

        Menu {
            title: qsTr("&Tools")
        }

        Menu {
            title: qsTr("&View")
        }
        Menu {
            title: qsTr("&Help")
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
