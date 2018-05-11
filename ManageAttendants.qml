import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.3
import QtQuick.XmlListModel 2.0

import "Common"
import "Common/Dialogs"

Pane {

    property string pageTitle: qsTr("Manage Attendants")

    property int delegateHeight: 90
    property int attendantsListRectangleWidth: 170
    property int attendantsListRectangleHeight: delegateHeight
    property int datesRectangleWidth: Math.round(attendantsListRectangleWidth / 1.4)
    property string attendantsListRectangleColor: "transparent"
    property real attendantsListRectangleOpacity: 1.0

    property int attendantsListFontSize: 16

    RowLayout {
        id: searchBarRow
        width: parent.width
        height: 80

        Button {
            id: addPersonButton
            anchors.left: parent.left
            anchors.leftMargin: 20
            text: "Add"

            ToolTip {
                visible: parent.hovered
                text: "Add Attendant"
            }
        }

        SearchBar {
            id: search
            Layout.fillWidth: true
            placeHolder: qsTr("Attendant name, employment date, etc")
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
        id: attendantsListView
        clip: true
        anchors.top: sortBarRow.bottom
        anchors.topMargin: 20
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        model: attendantsListModel
        delegate: attendantsListDelegate
        ScrollBar.vertical: ScrollBar {
            id: attendantsListScrollbar
            active: true
            contentItem: Rectangle {
                width: 8
                radius: 4
                color: attendantsListScrollbar.pressed ? "#b61616" : "#ea5354"
            }
        }
    }

    ListModel {
        id: attendantsListModel

        ListElement {
            profilePicSource: "qrc:/assets/profiles/customer2.jpg"
            name: "Esther Njeri"
            gender: "F"
            doe: "5th Aug 2017"
        }

        ListElement {
            profilePicSource: "qrc:/assets/profiles/customer1.jpg"
            name: "Hamisi Juma"
            gender: "M"
            doe: "5th Sep 2017"
        }
    }


    Component {
        id: attendantsListDelegate

        Item {
            width: parent.width
            height: delegateHeight

            RowLayout {
                id: attendantsListDataRow
                width: parent.width
                height: parent.height - 4

                Rectangle {
                    id: numberDisplayRect
                    height: parent.height
                    width: 60
                    color: attendantsListRectangleColor
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
                    id: attendantProfilePicDisplayRect
                    height: parent.height
                    width: Math.round(attendantsListRectangleWidth / 1.4)
                    color: attendantsListRectangleColor
                    anchors.left: numberDisplayRect.right
                    Image {
                        id: attendantProfilePic
                        anchors.centerIn: parent
                        source: profilePicSource
                        width: 70
                        height: 70
                        property bool rounded: true

                        layer.enabled: rounded
                        layer.effect: OpacityMask {

                            property bool adapt: false
                            maskSource: Item {
                                width: attendantProfilePic.width
                                height: attendantProfilePic.height
                                Rectangle {
                                    anchors.centerIn: parent
                                    width: adapt ? attendantProfilePic.width : Math.min(attendantProfilePic.width, attendantProfilePic.height)
                                    height: adapt ? attendantProfilePic.height : width
                                    radius: Math.min(width, height)
                                }
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: attendantProfilePic
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: notYet.open()
                    }
                }

                Rectangle {
                    id: attendantNameDisplayRect
                    height: parent.height
                    width: attendantsListRectangleWidth
                    color: attendantsListRectangleColor
                    anchors.left: attendantProfilePicDisplayRect.right
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
                    width: Math.round(attendantsListRectangleWidth / 1.4)
                    color: attendantsListRectangleColor
                    anchors.left: attendantNameDisplayRect.right
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
                    width: attendantsListRectangleWidth
                    color: attendantsListRectangleColor
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
                    width: Math.round(attendantsListRectangleWidth * 1.5)
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

