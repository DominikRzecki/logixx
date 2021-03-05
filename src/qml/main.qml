import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15

import "nodes"
import "nodes/intermediary"
import "nodes/input"
import "ui"

ApplicationWindow {
    id: appWindow
    visible: true
    width: Screen.desktopAvailableWidth/2
    height: Screen.desktopAvailableHeight

    //Material.theme: Material.
    Material.accent: Material.Red

    property string display
    title: qsTr("logixx")


    Flickable {
        id: flickable

        anchors.fill: parent

        boundsBehavior: Flickable.StopAtBounds

        contentWidth: 4000
        contentHeight: 4000

        //scale: 0.85

        interactive: true

        children: DropArea {
            id: nodeDropArea
            anchors.fill: flickable
            keys: ['disabled']
        }
    }


    GridLayout {
        id: row
        anchors.fill: parent
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 10
        anchors.topMargin: 10

        columns: 3
        rows: 3
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
            Layout.maximumHeight: row.height / 2
            //Layout.minimumWidth: 200
            Layout.alignment: Qt.AlignLeft | Qt.AlignHCenter
        }
    }


}

/*Flickable {
    id: dragFlickable

    anchors.fill: parent

    boundsMovement: Flickable.FollowBoundsBehavior
    boundsBehavior: Flickable.DragOverBounds

    contentWidth: 2000
    contentHeight: 2000

    contentX: contentWidth/2
    contentY: contentHeight/2

    interactive: false*/

/*DragHandler {
        id: touchdraghandler
        //target: parent

        property real _startX
        property real _startY

        onActiveChanged: {
            if (active) {
                _startX = dragFlickable.contentX
                _startY = dragFlickable.contentY
            } else {
                dragFlickable.returnToBounds()
            }
        }

        onTranslationChanged: {
            //console.debug(".")
            dragFlickable.contentX = _startX - translation.x
            dragFlickable.contentY = _startY - translation.y
        }
    }*/

/*MouseArea {
        property real _startX
        property real _startY

        onDragChanged: {
            if ( drag.active ) {
                _startX = dragFlickable.contentX
                _startY = dragFlickable.contentY
            } else {
                dragFlickable.returnToBounds()
            }
        }

        onMo {
            dragFlickable.contentX = _startX - translation.x
            dragFlickable.contentY = _startY - translation.y
        }
    }*/

/*WheelHandler {
    target: scaleFlickable
    onWheel: {
        if (event.angleDelta.y > 0) {
            if ( scaleFlickable.scale < 2 ) {
                scaleFlickable.scale = scaleFlickable.scale + 0.05;
            }
        } else {
            if ( scaleFlickable.scale > 0.3 ) {
                scaleFlickable.scale = scaleFlickable.scale - 0.05;
            }
        }
        //console.debug(flickable.scale)
    }
}*/

/*
PinchArea {
        id: pinchArea
        anchors.fill: parent
        pinch.minimumScale: 0.3
        pinch.maximumScale: 2.0
        pinch.maximumX: scaleFlickable.width
        pinch.maximumY: scaleFlickable.height
        pinch.dragAxis: pinch.XAndYAxis

        pinch.target: null

        onScaleChanged: {
            scaleFlickable.scale = scale
        }
}*/

/*##^##
Designer {
    D{i:0;formeditorZoom:0.33}
}
##^##*/
