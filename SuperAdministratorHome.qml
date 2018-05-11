import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import "Common"
import "Common/Dialogs"

Pane {

    property string pageTitle: "System Control Center"
    property int iconSpacing: 70
    property double iconsLayoutWidthDivisor: 2

    RowLayout {
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width
        height: Math.round(mainAppWindow.height / 2)


        Label {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: iconSpacing
            color: "#ababab"
            font.pixelSize: 50
            text: qsTr("Choose a task:")
        }

        Item {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            width: (subscriptionsIcon.width * 3) + (iconSpacing * 3)

            Image {
                id: subscriptionsIcon
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/assets/icons/subscriptions.png"


                MouseArea {
                    anchors.fill: subscriptionsIcon
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: subscriptionsIconRectangle.opacity = 1.0
                    onExited: subscriptionsIconRectangle.opacity = 0.0
                    onClicked: mainView.push("Subscriptions.qml")
                }
            }

            Image {
                id: salesReportsIcon
                anchors.left: subscriptionsIcon.right
                anchors.leftMargin: iconSpacing
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/assets/icons/sales3.png"


                MouseArea {
                    anchors.fill: salesReportsIcon
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: salesReportsIconRectangle.opacity = 1.0
                    onExited: salesReportsIconRectangle.opacity = 0.0
                    onClicked: notYet.open()
                }
            }

            Image {
                id: systemStatusIcon
                anchors.left: salesReportsIcon.right
                anchors.leftMargin: iconSpacing
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/assets/icons/system3.png"

                MouseArea {
                    anchors.fill: systemStatusIcon
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: systemStatusIconRectangle.opacity = 1.0
                    onExited: systemStatusIconRectangle.opacity = 0.0
                    onClicked: notYet.open()
                }
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
                id: subscriptionsIconRectangle
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width / 2
                height: 70
                color: "transparent"
                border.color: "#e0e0e0"
                opacity: 0.0

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#f3f3f4"
                    text: qsTr("Subscriptions")
                    font.pixelSize: 25
                }
            }

            Rectangle {
                id: salesReportsIconRectangle
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width / 2
                height: 70
                color: "transparent"
                border.color: "#e0e0e0"
                opacity: 0.0

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#f3f3f4"
                    text: qsTr("Financial Reports")
                    font.pixelSize: 25
                }
            }

            Rectangle {
                id: systemStatusIconRectangle
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width / 2
                height: 70
                color: "transparent"
                border.color: "#e0e0e0"
                opacity: 0.0

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#f3f3f4"
                    text: qsTr("Network Status")
                    font.pixelSize: 25
                }
            }
        }
    }

    RoleSwitcher {
        id: roleSwitcher
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.bottomMargin: 10
        anchors.rightMargin: 10
        spacing: 5
        userRole: role
    }

    StackView.onActivated: {
        if (role == "super-administrator")
        {
            userManager.session.switchedRoles = false
            userManager.session.selectedRole = ""
        }
    }
}
