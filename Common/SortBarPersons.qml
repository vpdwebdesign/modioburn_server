import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

RowLayout {

    height: parent.height
    anchors.left: parent.left
    anchors.leftMargin: 60
    spacing: 10

    property int rectangleWidth: 170
    property int rectangleHeight: parent.height
    property int datesRectangleWidth: Math.round(rectangleWidth / 1.4)
    property string rectangleColor: "#7b93c5"

    Rectangle {
        id: profilePic
        width: Math.round(rectangleWidth / 1.4)
        height: rectangleHeight
        color: rectangleColor

        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 5
            text: qsTr("Profile Pic")
            font.pixelSize: 15
            color: "white"
        }
    }

    Rectangle {
        id: sortByName
        width: rectangleWidth
        height: rectangleHeight
        color: rectangleColor

        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 5
            text: qsTr("Name")
            font.pixelSize: 15
            color: "white"
        }

        Image {
            id: sortByNameButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 5
            source: "qrc:/assets/icons/sort_down.png"
        }

        MouseArea {
            anchors.fill: sortByNameButton
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (sortByNameButton.source == "qrc:/assets/icons/sort_down.png") {
                    sortByNameButton.source = "qrc:/assets/icons/sort_up.png"
                } else {
                    sortByNameButton.source = "qrc:/assets/icons/sort_down.png"
                }
            }
        }
    }

    Rectangle {
        id: sortByGender
        width: Math.round(rectangleWidth / 1.4)
        height: rectangleHeight
        color: rectangleColor

        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 5
            text: qsTr("Gender")
            font.pixelSize: 15
            color: "white"
        }

        Image {
            id: sortByGenderButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 5
            source: "qrc:/assets/icons/sort_down.png"
        }

        MouseArea {
            anchors.fill: sortByGenderButton
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (sortByGenderButton.source == "qrc:/assets/icons/sort_down.png") {
                    sortByGenderButton.source = "qrc:/assets/icons/sort_up.png"
                } else {
                    sortByGenderButton.source = "qrc:/assets/icons/sort_down.png"
                }
            }
        }
    }

    Rectangle {
        id: sortByDOE
        width: rectangleWidth
        height: rectangleHeight
        color: rectangleColor

        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 5
            text: qsTr("Employment Date")
            font.pixelSize: 15
            color: "white"
        }

        Image {
            id: sortByDOEButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 5
            source: "qrc:/assets/icons/sort_down.png"
        }

        MouseArea {
            anchors.fill: sortByDOEButton
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (sortByDOEButton.source == "qrc:/assets/icons/sort_down.png") {
                    sortByDOEButton.source = "qrc:/assets/icons/sort_up.png"
                } else {
                    sortByDOEButton.source = "qrc:/assets/icons/sort_down.png"
                }
            }
        }
    }

    Rectangle {
        id: actions
        width: rectangleWidth * 1.5
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


