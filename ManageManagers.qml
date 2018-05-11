import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.3
import QtQuick.XmlListModel 2.0

import "Common"
import "Common/Dialogs"

Pane {

    property string pageTitle: qsTr("Manage Managers")

    property int delegateHeight: 90
    property int managersListRectangleWidth: 170
    property int managersListRectangleHeight: delegateHeight
    property int datesRectangleWidth: Math.round(managersListRectangleWidth / 1.4)
    property string managersListRectangleColor: "transparent"
    property real managersListRectangleOpacity: 1.0

    property int managersListFontSize: 16

    RowLayout {
        id: searchBarRow
        width: parent.width
        height: 80

        Button {
            id: addPersonButton
            anchors.left: parent.left
            anchors.leftMargin: 20
            text: "Add"
            onClicked: notYet.open()

            ToolTip {
                visible: parent.hovered
                text: "Add Manager"
            }
        }

        SearchBar {
            id: search
            Layout.fillWidth: true
            placeHolder: qsTr("Manager name, employment date, etc")
        }

        SortPersons {
            anchors.right: parent.right
            anchors.rightMargin: 20
            comboBoxWidth: 170
            optionsList: ["In Employment", "Suspended", "Dismissed"]

        }

    }

    Item {
        id: sortBarRow
        height: 30
        anchors.top: searchBarRow.bottom
        SortBarPersons {
        }

    }

    ListView {
        id: managersListView
        clip: true
        anchors.top: sortBarRow.bottom
        anchors.topMargin: 20
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        model: managersListModel
        delegate: managersListDelegate
        ScrollBar.vertical: ScrollBar {
            id: managersListScrollbar
            active: true
            contentItem: Rectangle {
                width: 8
                radius: 4
                color: managersListScrollbar.pressed ? "#b61616" : "#ea5354"
            }
        }
    }

    ListModel {
        id: managersListModel

        ListElement {
            profilePicSource: "qrc:/assets/profiles/customer10.jpg"
            name: "Leonard Kamau"
            gender: "M"
            doe: "16th Jul 2017"
        }
    }


    Component {
        id: managersListDelegate

        Item {
            width: parent.width
            height: delegateHeight

            RowLayout {
                id: managersListDataRow
                width: parent.width
                height: parent.height - 4

                Rectangle {
                    id: numberDisplayRect
                    height: parent.height
                    width: 60
                    color: managersListRectangleColor
                    anchors.left: parent.left
                    Rectangle {
                        anchors.centerIn: parent
                        height: numberText.font.pixelSize + 10
                        width: numberText.font.pixelSize + 10
                        color: "transparent"
                        border.width: 2
                        border.color: "#cccccc"
                        Text {
                            id: numberText
                            anchors.centerIn: parent
                            font.pixelSize: 18
                            color: "#f3f3f4"
                            text: (index + 1).toString()
                            wrapMode: Text.WordWrap
                        }
                    }
                }

                Rectangle {
                    id: managerProfilePicDisplayRect
                    height: parent.height
                    width: Math.round(managersListRectangleWidth / 1.4)
                    color: managersListRectangleColor
                    anchors.left: numberDisplayRect.right
                    Image {
                        id: managerProfilePic
                        anchors.centerIn: parent
                        source: profilePicSource
                        width: 70
                        height: 70
                        property bool rounded: true

                        layer.enabled: rounded
                        layer.effect: OpacityMask {

                            property bool adapt: false
                            maskSource: Item {
                                width: managerProfilePic.width
                                height: managerProfilePic.height
                                Rectangle {
                                    anchors.centerIn: parent
                                    width: adapt ? managerProfilePic.width : Math.min(managerProfilePic.width, managerProfilePic.height)
                                    height: adapt ? managerProfilePic.height : width
                                    radius: Math.min(width, height)
                                }
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: managerProfilePic
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: notYet.open()
                    }
                }

                Rectangle {
                    id: managerNameDisplayRect
                    height: parent.height
                    width: managersListRectangleWidth
                    color: managersListRectangleColor
                    anchors.left: managerProfilePicDisplayRect.right
                    anchors.leftMargin: 10
                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: 16
                        color: "#f3f3f4"
                        text: name
                        width: parent.width - 20
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: genderDisplayRect
                    height: parent.height
                    width: Math.round(managersListRectangleWidth / 1.4)
                    color: managersListRectangleColor
                    anchors.left: managerNameDisplayRect.right
                    anchors.leftMargin: 10
                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: 16
                        color: "#f3f3f4"
                        text: gender
                        width: parent.width - 20
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: doeDisplayRect
                    height: parent.height
                    width: managersListRectangleWidth
                    color: managersListRectangleColor
                    anchors.left: genderDisplayRect.right
                    anchors.leftMargin: 10
                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: 16
                        color: "#f3f3f4"
                        text: doe
                        width: parent.width - 15
                        wrapMode: Text.WordWrap
                    }
                }

                RowLayout {
                    id: actionsDisplayRow
                    height: parent.height
                    width: Math.round(managersListRectangleWidth * 1.5)
                    anchors.left: doeDisplayRect.right
                    anchors.leftMargin: 10

                    Button {
                        id: detailsButton
                        anchors.left: parent.left
                        anchors.leftMargin: 5
                        text: "Details"
                        onClicked: notYet.open()
                    }

                    Button {
                        id: suspendButton
                        anchors.left: detailsButton.right
                        anchors.leftMargin: 10
                        text: "Suspend"
                        onClicked: notYet.open()
                    }

                    Button {
                        id: dismissButton
                        anchors.left: suspendButton.right
                        anchors.leftMargin: 10
                        text: "Dismiss"
                        onClicked: notYet.open()
                    }
                }


            }

            Rectangle {
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.right: parent.right
                anchors.rightMargin: 20
                height: 1
                color: "#bfbfbf"
                opacity: 0.5
            }
        }
    }
}

