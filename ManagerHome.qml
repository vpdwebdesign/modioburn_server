import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import "Common"
import "Common/Dialogs"
import "Common/JS/functions.js" as Js

Pane {

    property string managerName: Js.capitalize(Js.getFirstWord(name, ' '))
    property string pageTitle: "Welcome, " + managerName

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
            text: "Select a task:"
        }

        Item {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            width: (manageAttendantsIcon.width * 3) + (iconSpacing * 3)

            Image {
                id: manageAttendantsIcon
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/assets/icons/manage2.png"


                MouseArea {
                    anchors.fill: manageAttendantsIcon
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: manageAttendantsIconRectangle.opacity = 1.0
                    onExited: manageAttendantsIconRectangle.opacity = 0.0
                    onClicked: mainView.push("ManageAttendants.qml")
                }
            }

            Image {
                id: manageContentIcon
                anchors.left: manageAttendantsIcon.right
                anchors.leftMargin: iconSpacing
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/assets/icons/media.png"


                MouseArea {
                    anchors.fill: manageContentIcon
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: manageContentIconRectangle.opacity = 1.0
                    onExited: manageContentIconRectangle.opacity = 0.0
                    onClicked: mainView.push("ManageContent.qml")
                }
            }

            Image {
                id: salesIcon
                anchors.left: manageContentIcon.right
                anchors.leftMargin: iconSpacing
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/assets/icons/sales.png"


                MouseArea {
                    anchors.fill: salesIcon
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: salesIconRectangle.opacity = 1.0
                    onExited: salesIconRectangle.opacity = 0.0
                    onClicked: mainView.push("SalesReport.qml")
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
                id: manageContentIconRectangle
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
                    text: qsTr("Manage Content")
                    font.pixelSize: 25
                }
            }

            Rectangle {
                id: manageAttendantsIconRectangle
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
                    text: qsTr("Manage Attendants")
                    font.pixelSize: 25
                }
            }

            Rectangle {
                id: salesIconRectangle
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
                    text: qsTr("Sales Reports")
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
        enabled: role == "manager"
        userRole: role
    }

    StackView.onActivated: {
        if (role == "manager")
        {
            userManager.session.switchedRoles = false
            userManager.session.selectedRole = ""
        }
    }
}
