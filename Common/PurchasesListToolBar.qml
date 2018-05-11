import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

RowLayout {

    property int headerRectWidth
    property int headerTextSize: 11
    property color headerTextColor: "#90a4ae"

    Rectangle {
        id: itemSerialNoHeader
        height: parent.height
        width: Math.round(headerRectWidth / 5)
        color: "transparent"
        anchors.left: parent.left
        anchors.leftMargin: 20

        Text {
            anchors.centerIn: parent
            font.pixelSize: headerTextSize
            color: headerTextColor
            text: "#"
            wrapMode: Text.WordWrap
        }
    }

    Rectangle {
        id: itemNameHeader
        height: parent.height
        width: headerRectWidth
        color: "transparent"
        anchors.left: itemSerialNoHeader.right
        anchors.leftMargin: 20
        Text {
            anchors.centerIn: parent
            font.pixelSize: headerTextSize
            color: headerTextColor
            text: "ITEM"
            width: parent.width - 20
            wrapMode: Text.WordWrap
        }
    }

    Rectangle {
        id: itemQtyHeader
        height: parent.height
        width: Math.round(headerRectWidth / 2)
        color: "transparent"
        anchors.left: itemNameHeader.right
        anchors.leftMargin: 20
        Text {
            anchors.centerIn: parent
            font.pixelSize: headerTextSize
            color: headerTextColor
            text: "QUANTITY"
            width: parent.width - 20
            wrapMode: Text.WordWrap
        }
    }

    Rectangle {
        id: itemCostHeader
        height: parent.height
        width: Math.round(headerRectWidth / 2)
        color: "transparent"
        anchors.left: itemQtyHeader.right
        anchors.leftMargin: 20
        Text {
            anchors.centerIn: parent
            font.pixelSize: headerTextSize
            color: headerTextColor
            text: "COST"
            width: parent.width - 20
            wrapMode: Text.WordWrap
        }
    }
}

