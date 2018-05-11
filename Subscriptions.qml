import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.3
import QtQuick.XmlListModel 2.0

import "Common"
import "Common/Dialogs"

Page {

    property string pageTitle: qsTr("Manage Subscriptions")

    property int delegateHeight: 90
    property int stationsListRectangleWidth: 170
    property int stationsListRectangleHeight: delegateHeight
    property int datesRectangleWidth: Math.round(stationsListRectangleWidth / 1.4)
    property string stationsListRectangleColor: "transparent"
    property real stationsListRectangleOpacity: 1.0

    property int stationsListFontSize: 16

    RowLayout {
        id: searchBarRow
        width: parent.width
        height: 80

        Button {
            id: addStationButton
            anchors.left: parent.left
            anchors.leftMargin: 20
            text: "Add"
            onClicked: notYet.open()

            ToolTip {
                visible: parent.hovered
                text: "Add Station"
            }
        }

        SearchBar {
            id: search
            Layout.fillWidth: true
            placeHolder: qsTr("Station name, location, subscription status")
        }

        SortPersons {
            anchors.right: parent.right
            anchors.rightMargin: 20
            comboBoxWidth: 170
            optionsList: ["All", "Active", "Suspended", "Inactive", "Deleted"]

        }

    }

    Item {
        id: sortBarRow
        height: 30
        anchors.top: searchBarRow.bottom
        SortBarStations {
        }

    }

    ListView {
        id: stationsListView
        clip: true
        anchors.top: sortBarRow.bottom
        anchors.topMargin: 20
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        model: stationsListModel
        delegate: stationsListDelegate
        ScrollBar.vertical: ScrollBar {
            id: stationsListScrollbar
            active: true
            contentItem: Rectangle {
                width: 8
                radius: 4
                color: stationsListScrollbar.pressed ? "#b61616" : "#ea5354"
            }
        }
    }

    ListModel {
        id: stationsListModel

        ListElement {
            stationImageSource: "qrc:/assets/icons/station-active.png"
            stationName: "Cool Muviz"
            location: "Mtwapa"
            subscriptionStatus: "Active"
        }

        ListElement {
            stationImageSource: "qrc:/assets/icons/station-suspended.png"
            stationName: "Digitali Kali Movies and Music"
            location: "Mombasa"
            subscriptionStatus: "Suspended"
        }

        ListElement {
            stationImageSource: "qrc:/assets/icons/station-inactive.png"
            stationName: "No Worries Collections"
            location: "Ukunda"
            subscriptionStatus: "Inactive"
        }

        ListElement {
            stationImageSource: "qrc:/assets/icons/station-active.png"
            stationName: "ModioBurn Junior Investments"
            location: "Mombasa"
            subscriptionStatus: "Active"
        }

        ListElement {
            stationImageSource: "qrc:/assets/icons/station-deleted.png"
            stationName: "Kichwa Ngumu Movies"
            location: "Likoni"
            subscriptionStatus: "Deleted"
        }

        ListElement {
            stationImageSource: "qrc:/assets/icons/station-active.png"
            stationName: "Showbiz HotBiz Ltd"
            location: "Mtwapa"
            subscriptionStatus: "Active"
        }
    }


    Component {
        id: stationsListDelegate

        Item {
            width: parent.width
            height: delegateHeight

            RowLayout {
                id: stationsListDataRow
                width: parent.width
                height: parent.height - 4

                Rectangle {
                    id: numberDisplayRect
                    height: parent.height
                    width: 60
                    color: stationsListRectangleColor
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
                    id: stationImageSourceDisplayRect
                    height: parent.height
                    width: Math.round(stationsListRectangleWidth / 1.4)
                    color: stationsListRectangleColor
                    anchors.left: numberDisplayRect.right
                    Image {
                        anchors.centerIn: parent
                        source: stationImageSource
                        width: 70
                        height: 70
                    }
                }

                Rectangle {
                    id: stationNameDisplayRect
                    height: parent.height
                    width: stationsListRectangleWidth
                    color: stationsListRectangleColor
                    anchors.left: stationImageSourceDisplayRect.right

                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: 16
                        color: "#f3f3f4"
                        text: stationName
                        width: parent.width - 20
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: locationDisplayRect
                    height: parent.height
                    width: stationsListRectangleWidth
                    color: stationsListRectangleColor
                    anchors.left: stationNameDisplayRect.right
                    anchors.leftMargin: 10

                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: 16
                        color: "#f3f3f4"
                        text: location
                        width: parent.width - 20
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: subscriptionStatusDisplayRect
                    height: parent.height
                    width: stationsListRectangleWidth
                    color: stationsListRectangleColor
                    anchors.left: locationDisplayRect.right
                    anchors.leftMargin: 10

                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: 16
                        color: "#f3f3f4"
                        text: subscriptionStatus
                        width: parent.width - 15
                        wrapMode: Text.WordWrap
                    }
                }

                RowLayout {
                    id: actionsDisplayRow
                    height: parent.height
                    width: Math.round(subscriptionStatusDisplayRect * 3.0)
                    anchors.left: subscriptionStatusDisplayRect.right
                    anchors.leftMargin: 10

                    Button {
                        id: activateDeactivateButton
                        anchors.left: parent.left
                        anchors.leftMargin: 5
                        text: subscriptionStatus.toLowerCase() === "active" ? "Deactivate" : "Activate"
                        enabled: subscriptionStatus.toLowerCase() !== "deleted"
                        onClicked: notYet.open()
                    }

                    Button {
                        id: suspendButton
                        anchors.left: activateDeactivateButton.right
                        anchors.leftMargin: 10
                        text: "Suspend"
                        enabled: (subscriptionStatus.toLowerCase() !== "suspended" && subscriptionStatus.toLowerCase() !== "deleted")
                        onClicked: notYet.open()
                    }

                    Button {
                        id: deleteButton
                        anchors.left: suspendButton.right
                        anchors.leftMargin: 10
                        text: "Delete"
                        enabled: subscriptionStatus.toLowerCase() !== "deleted"
                        onClicked: notYet.open()
                    }

                    Button {
                        id: sendNotificationButton
                        anchors.left: deleteButton.right
                        anchors.leftMargin: 10
                        text: "Send Notification"
                        enabled: subscriptionStatus.toLowerCase() !== "deleted"
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

