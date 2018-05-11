import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import "Common"
import "Common/Dialogs"

Pane {

    property string pageTitle: qsTr("Manage Content")

    property double iconsLayoutWidthDivisor: 2.0

    RowLayout {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: 512

        Label {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 100
            color: "#ababab"
            font.pixelSize: 50
            text: "Please choose what to manage:"
        }

        Item {
            width: Math.round(parent.width / iconsLayoutWidthDivisor)
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            Image {
                id: videoIcon
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/assets/icons/movies.png"
            }

            MouseArea {
                anchors.fill: videoIcon
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: videoIconRectangle.opacity = 1.0
                onExited: videoIconRectangle.opacity = 0.0
                onClicked: notYet.open()
            }

            Image {
                id: audioIcon
                anchors.left: videoIcon.right
                anchors.leftMargin: 75
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/assets/icons/music.png"
            }

            MouseArea {
                anchors.fill: audioIcon
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: audioIconRectangle.opacity = 1.0
                onExited: audioIconRectangle.opacity = 0.0
                onClicked: notYet.open()
            }

            Image {
                id: gamesIcon
                anchors.left: audioIcon.right
                anchors.leftMargin: 75
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/assets/icons/games.png"
            }

            MouseArea {
                anchors.fill: gamesIcon
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: gamesIconRectangle.opacity = 1.0
                onExited: gamesIconRectangle.opacity = 0.0
                onClicked: notYet.open()
            }
        }
    }

    RowLayout {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: 100

        Item {
            width: parent.width / 1.8
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                id: videoIconRectangle
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width / 2
                height: 70
                color: "transparent"
                border.color: "#ababab"
                opacity: 0.0

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#f3f3f4"
                    text: qsTr("Video")
                    font.pixelSize: 25
                }
            }

            Rectangle {
                id: audioIconRectangle
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width / 2
                height: 70
                color: "transparent"
                border.color: "#ababab"
                opacity: 0.0

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#f3f3f4"
                    text: qsTr("Audio")
                    font.pixelSize: 25
                }
            }

            Rectangle {
                id: gamesIconRectangle
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width / 2
                height: 70
                color: "transparent"
                border.color: "#ababab"
                opacity: 0.0

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#f3f3f4"
                    text: qsTr("Games")
                    font.pixelSize: 25
                }
            }
        }
    }
}
