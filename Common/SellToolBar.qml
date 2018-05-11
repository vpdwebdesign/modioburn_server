import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

RowLayout {

    property int headerRectWidth
    property int headerTextSize: 11
    property color headerTextColor: "#90a4ae"
    property int sellToolBarRectMargin: 10

    Rectangle {
        id: itemSerialNoHeader
        height: parent.height
        width: Math.round(headerRectWidth / 5)
        color: "transparent"
        anchors.left: parent.left
        anchors.leftMargin: sellToolBarRectMargin

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
        anchors.leftMargin: Math.round(sellToolBarRectMargin / 2)
        Text {
            anchors.centerIn: parent
            font.pixelSize: headerTextSize
            color: headerTextColor
            text: "NAME"
            width: parent.width - sellToolBarRectMargin
            wrapMode: Text.WordWrap
        }
    }

    Rectangle {
        id: itemSizeHeader
        height: parent.height
        width: Math.round(headerRectWidth / 2)
        color: "transparent"
        anchors.left: itemNameHeader.right
        anchors.leftMargin: sellToolBarRectMargin
        Text {
            anchors.centerIn: parent
            font.pixelSize: headerTextSize
            color: headerTextColor
            text: "SIZE"
            width: parent.width - sellToolBarRectMargin
            wrapMode: Text.WordWrap
        }
    }

    Rectangle {
        id: itemDescHeader
        height: parent.height
        width: headerRectWidth
        color: "transparent"
        anchors.left: itemSizeHeader.right
        anchors.leftMargin: sellToolBarRectMargin
        Text {
            anchors.centerIn: parent
            font.pixelSize: headerTextSize
            color: headerTextColor
            text: "DESCRIPTION"
            width: parent.width - sellToolBarRectMargin
            wrapMode: Text.WordWrap
        }
    }

    Rectangle {
        id: itemBrandHeader
        height: parent.height
        width: Math.round(headerRectWidth / 2)
        color: "transparent"
        anchors.left: itemDescHeader.right
        anchors.leftMargin: sellToolBarRectMargin
        Text {
            anchors.centerIn: parent
            font.pixelSize: headerTextSize
            color: headerTextColor
            text: "BRAND"
            width: parent.width - sellToolBarRectMargin
            wrapMode: Text.WordWrap
        }
    }

    Rectangle {
        id: itemQtyHeader
        height: parent.height
        width: Math.round(headerRectWidth / 2)
        color: "transparent"
        anchors.left: itemBrandHeader.right
        anchors.leftMargin: sellToolBarRectMargin
        Text {
            anchors.centerIn: parent
            font.pixelSize: headerTextSize
            color: headerTextColor
            text: "QUANTITY"
            width: parent.width - sellToolBarRectMargin
            wrapMode: Text.WordWrap
        }
    }

    Rectangle {
        id: itemPPUHeader
        height: parent.height
        width: Math.round(headerRectWidth / 2)
        color: "transparent"
        anchors.left: itemQtyHeader.right
        anchors.leftMargin: sellToolBarRectMargin
        Text {
            anchors.centerIn: parent
            font.pixelSize: headerTextSize
            color: headerTextColor
            text: "UNIT PRICE (Ksh)"
            width: parent.width - sellToolBarRectMargin
            wrapMode: Text.WordWrap
        }
    }
}

