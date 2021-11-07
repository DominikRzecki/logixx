import QtQuick 2.15

import com.rzecki.logix 1.0

import "./"


//This Item manages all slots(inputs) of a node, it consists of a ListView and an ListModel
Item {
    id: slotList

    property int slotType: SlotType.INPUT //Specyfies the type of the slots

    property alias list: slotView           //Alias to ListView
    property alias model: slotModel         //Alias to ListModel
    property alias count: slotView.count    //Alias to ListView.count
    property int maxSlots: -1
    property int minSlots: 2

    //ListModel Holding all Slots
    ListModel {
        id: slotModel
        dynamicRoles: true

        //This function enables accessing Slots from c++
        function getSlot(index) {
            console.debug(slotList + ".getSlot("+ index + ")");
            return slotView.itemAtIndex(index).children[0];
        }
    }

    ListView {
        id: slotView

        x: -10
        width: 20

        anchors.fill: parent
        interactive: false
        orientation: Qt.Vertical
        //verticalLayoutDirection: slotView.BottomToTop
        spacing: slotView.height/(slotView.count+1)
        transformOrigin: Item.Center

        model: slotModel//basicNode.backend.//slotModel
        delegate: Item {
            width: 20
            x: 0

            property bool permanent: false

            Component.onCompleted: {
                slot.index = slotView.count-1
            }

            Slot {
                id: slot

                type: slotList.slotType

                posY: slotView.height/(slotView.count+1)
                posX: 0
                z: parentNode.z + 0.5 //(source === null) ? basicNode.z + 0.5 : source.parent.z + 0.3

                width: 10
                height: 10
                radius: 3

                highlightColor: "green"

                //Keys are "disabled" when basicNode disabled
                dragKeys: slotList.parent.keys

                parentNode: slotList.parent
                listView: slotView
            }
        }
    }
}
