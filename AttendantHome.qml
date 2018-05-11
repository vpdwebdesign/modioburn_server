import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import "Common"
import "Common/Dialogs"
import "Common/JS/functions.js" as Js

Pane {    

    property string attendantName: Js.capitalize(Js.getFirstWord(name, ' '))
    property string pageTitle: "Welcome, " + attendantName

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
            width: (transactionsIcon.width * 2) + (iconSpacing * 2)

            Image {
                id: transactionsIcon
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/assets/icons/transactions.png"


                MouseArea {
                    anchors.fill: transactionsIcon
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: transactionsIconRectangle.opacity = 1.0
                    onExited: transactionsIconRectangle.opacity = 0.0
                    onClicked: {
                        mainView.push("Transactions.qml")
                    }
                }
            }

//            Image {
//                id: usersIcon
//                anchors.left: transactionsIcon.right
//                anchors.leftMargin: iconSpacing
//                anchors.verticalCenter: parent.verticalCenter
//                source: "qrc:/assets/icons/users.png"


//                MouseArea {
//                    anchors.fill: usersIcon
//                    hoverEnabled: true
//                    cursorShape: Qt.PointingHandCursor
//                    onEntered: usersIconRectangle.opacity = 1.0
//                    onExited: usersIconRectangle.opacity = 0.0
//                    onClicked: notYet.open()
//                }
//            }

            Image {
                id: shopIcon
                anchors.left: transactionsIcon.right
                anchors.leftMargin: iconSpacing
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/assets/icons/shop.png"

                MouseArea {
                    anchors.fill: shopIcon
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: shopIconRectangle.opacity = 1.0
                    onExited: shopIconRectangle.opacity = 0.0
                    onClicked: {
                        mainView.push("Sell.qml")
                    }
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
                id: transactionsIconRectangle
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
                    text: "Transactions"
                    font.pixelSize: 25
                }
            }

//            Rectangle {
//                id: usersIconRectangle
//                anchors.bottom: parent.bottom
//                anchors.horizontalCenter: parent.horizontalCenter
//                width: parent.width / 2
//                height: 70
//                color: "transparent"
//                border.color: "#e0e0e0"
//                opacity: 0.0

//                Text {
//                    anchors.verticalCenter: parent.verticalCenter
//                    anchors.horizontalCenter: parent.horizontalCenter
//                    color: "#f3f3f4"
//                    text: "Users"
//                    font.pixelSize: 25
//                }
//            }

            Rectangle {
                id: shopIconRectangle
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
                    text: "Sell Shop Items"
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
        enabled: role == "attendant"
        userRole: role
    }

    StackView.onActivated: {
        if (role == "attendant")
        {
            userManager.session.switchedRoles = false
            userManager.session.selectedRole = ""
        }
    }
}
