import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import "Common"
import "Common/Dialogs"

Pane {

    property string pageTitle: qsTr("Welcome, ") + username
    property int iconSpacing: 70
    property double iconsLayoutWidthDivisor: 3

    RowLayout {
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width
        height: 512

        Label {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: iconSpacing
            color: "#ababab"
            font.pixelSize: 50
            text: qsTr("Select a task:")
        }

        Item {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            width: Math.round(parent.width / iconsLayoutWidthDivisor)

            Image {
                id: manageManagersIcon
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/assets/icons/manage2.png"


                MouseArea {
                    anchors.fill: manageManagersIcon
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: manageManagersIconRectangle.opacity = 1.0
                    onExited: manageManagersIconRectangle.opacity = 0.0
                    onClicked: mainView.push("ManageManagers.qml")
                }
            }

            Image {
                id: salesIcon
                anchors.left: manageManagersIcon.right
                anchors.leftMargin: iconSpacing
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/assets/icons/sales2.png"


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
                id:manageManagersIconRectangle
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
                    text: qsTr("Manage Managers")
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
        enabled: role == "administrator"
        userRole: role
    }

    StackView.onActivated: {
        if (role == "administrator")
        {
            userManager.session.switchedRoles = false
            userManager.session.selectedRole = ""
        }
    }
}
