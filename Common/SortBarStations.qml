import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

RowLayout {

    height: parent.height
    anchors.left: parent.left
    anchors.leftMargin: 180
    spacing: 10

    property int rectangleWidth: 170
    property int rectangleHeight: parent.height
    property string rectangleColor: "#393f4c"

    Rectangle {
        id: sortByStationName
        width: rectangleWidth
        height: rectangleHeight
        color: rectangleColor

        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 5
            text: qsTr("Station")
            font.pixelSize: 15
            color: "white"
        }

        Image {
            id: sortByStationNameButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 5
            source: "qrc:/assets/icons/sort_down.png"
        }

        MouseArea {
            anchors.fill: sortByStationNameButton
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (sortByStationNameButton.source == "qrc:/assets/icons/sort_down.png") {
                    sortByStationNameButton.source = "qrc:/assets/icons/sort_up.png"
                } else {
                    sortByStationNameButton.source = "qrc:/assets/icons/sort_down.png"
                }
            }
        }
    }

    Rectangle {
        id: sortByLocation
        width: rectangleWidth
        height: rectangleHeight
        color: rectangleColor

        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 5
            text: qsTr("Location")
            font.pixelSize: 15
            color: "white"
        }

        Image {
            id: sortByLocationButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 5
            source: "qrc:/assets/icons/sort_down.png"
        }

        MouseArea {
            anchors.fill: sortByLocationButton
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (sortByLocationButton.source == "qrc:/assets/icons/sort_down.png") {
                    sortByLocationButton.source = "qrc:/assets/icons/sort_up.png"
                } else {
                    sortByLocationButton.source = "qrc:/assets/icons/sort_down.png"
                }
            }
        }
    }

    Rectangle {
        id: sortBySubscriptionStatus
        width: rectangleWidth
        height: rectangleHeight
        color: rectangleColor

        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 5
            text: qsTr("Status")
            font.pixelSize: 15
            color: "white"
        }

        Image {
            id: sortBySubscriptionStatusButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 5
            source: "qrc:/assets/icons/sort_down.png"
        }

        MouseArea {
            anchors.fill: sortBySubscriptionStatusButton
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (sortBySubscriptionStatusButton.source == "qrc:/assets/icons/sort_down.png") {
                    sortBySubscriptionStatusButton.source = "qrc:/assets/icons/sort_up.png"
                } else {
                    sortBySubscriptionStatusButton.source = "qrc:/assets/icons/sort_down.png"
                }
            }
        }
    }

    Rectangle {
        id: actions
        width: Math.round(rectangleWidth * 3.0)
        height: rectangleHeight
        color: rectangleColor

        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 5
            text: qsTr("Actions")
            font.pixelSize: 15
            color: "white"
        }
    }
}


