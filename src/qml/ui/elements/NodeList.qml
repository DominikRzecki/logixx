import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ScrollView {
    id: scrollView
    Layout.margins: 5
    contentWidth: -1
    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
    ScrollBar.horizontal.interactive: false

    property int nodeheight: 100
    property alias model: nodeListView.model

    //This ListView holds the different types of Nodes
    ListView {
        id: nodeListView

        //Item delegate is responsible for creating nodes
        delegate: Item {
            id: nodeSpawn
            property Component comp: null       //Holds the nodes component


            height: scrollView.nodeheight
            x: 5

            //x: nodeListView./2


            onChildrenChanged: {
                if(comp.status === Component.Ready) { //Creates components
                    comp.createObject(this, {state: "disabled", x: nodeSpawn.x, y: 20});
                } else {
                    console.debug(comp.errorString());
                }
            }

            Component.onCompleted: {    //Loads component from file
                if(comp === null) {
                    comp = Qt.createComponent(src);
                }
                nodeSpawn.onChildrenChanged();
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
