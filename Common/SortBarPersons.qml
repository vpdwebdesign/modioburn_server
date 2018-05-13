import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

RowLayout {
    id: sortBarPersonsLayout
    height: parent.height
    anchors.left: parent.left
    anchors.leftMargin: 30
    spacing: 5

    property int rectangleWidth: 120
    property int rectangleHeight: parent.height
    property string rectangleColor: "#607d8b"
    property int columnTextFontSize: 12
    property int columnTextLeftMargin: 5
    property int sortIconRightMargin: 1

    property bool showSuspended: false
    property bool showDeregistered: false

    signal sortActivated(int col, int sortOrder)

    Rectangle {
        id: sortByName
        width: rectangleWidth
        height: rectangleHeight
        color: rectangleColor

        state: "ascending"

        Text {
            id: sortByNameText
            text: "Name"
            font.pixelSize: columnTextFontSize
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: columnTextLeftMargin
        }

        Image {
            id: sortByNameButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 2
        }

        MouseArea {
            anchors.fill: sortByNameButton
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (sortByName.state == "ascending")
                {
                    sortByName.state = "descending"
                    sortBarPersonsLayout.sortActivated(0, Qt.DescendingOrder)
                }
                else
                {
                    sortByName.state = "ascending"
                    sortBarPersonsLayout.sortActivated(0, Qt.AscendingOrder)
                }
            }
        }

        states: [
            State {
                name: "ascending"
                PropertyChanges {
                    target: sortByNameButton
                    source: "qrc:/assets/icons/sort_down_light.png"
                }
            },
            State {
                name: "descending"
                PropertyChanges {
                    target: sortByNameButton
                    source: "qrc:/assets/icons/sort_up_light.png"
                }
            }
        ]
    }

    Rectangle {
        id: sortByGender
        width: Math.round(rectangleWidth / 1.5)
        height: rectangleHeight
        color: rectangleColor

        state: "ascending"

        Text {
            id: sortByGenderText
            text: "Gender"
            font.pixelSize: columnTextFontSize
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: columnTextLeftMargin
        }

        Image {
            id: sortByGenderButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 2
        }

        MouseArea {
            anchors.fill: sortByGenderButton
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (sortByGender.state == "ascending")
                {
                    sortByGender.state = "descending"
                    sortBarPersonsLayout.sortActivated(1, Qt.DescendingOrder)
                }
                else
                {
                    sortByGender.state = "ascending"
                    sortBarPersonsLayout.sortActivated(1, Qt.AscendingOrder)
                }
            }
        }

        states: [
            State {
                name: "ascending"
                PropertyChanges {
                    target: sortByGenderButton
                    source: "qrc:/assets/icons/sort_down_light.png"
                }
            },
            State {
                name: "descending"
                PropertyChanges {
                    target: sortByGenderButton
                    source: "qrc:/assets/icons/sort_up_light.png"
                }
            }
        ]
    }

    Rectangle {
        id: sortByPhone
        width: rectangleWidth
        height: rectangleHeight
        color: rectangleColor

//        state: "ascending"

        Text {
            id: sortByPhoneText
            text: "Phone"
            font.pixelSize: columnTextFontSize
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: columnTextLeftMargin
        }

//        Image {
//            id: sortByQuantityButton
//            anchors.verticalCenter: parent.verticalCenter
//            anchors.right: parent.right
//            anchors.rightMargin: 2
//        }

//        MouseArea {
//            anchors.fill: sortByQuantityButton
//            hoverEnabled: true
//            cursorShape: Qt.PointingHandCursor
//            onClicked: {
//                if (sortByQuantity.state == "ascending")
//                {
//                    sortByQuantity.state = "descending"
//                    sortBarPersonsLayout.sortActivated(3, Qt.DescendingOrder)
//                }
//                else
//                {
//                    sortByQuantity.state = "ascending"
//                    sortBarPersonsLayout.sortActivated(3, Qt.AscendingOrder)
//                }
//            }
//        }

//        states: [
//            State {
//                name: "ascending"
//                PropertyChanges {
//                    target: sortByQuantityButton
//                    source: "qrc:/assets/icons/sort_down_light.png"
//                }
//            },
//            State {
//                name: "descending"
//                PropertyChanges {
//                    target: sortByQuantityButton
//                    source: "qrc:/assets/icons/sort_up_light.png"
//                }
//            }
//        ]
    }

    Rectangle {
        id: sortByEmail
        width: rectangleWidth + 30
        height: rectangleHeight
        color: rectangleColor

        state: "ascending"

        Text {
            id: sortByEmailText
            text: "Email"
            font.pixelSize: columnTextFontSize
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: columnTextLeftMargin
        }

        Image {
            id: sortByEmailButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 2
        }

        MouseArea {
            anchors.fill: sortByEmailButton
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (sortByEmail.state == "ascending")
                {
                    sortByEmail.state = "descending"
                    sortBarPersonsLayout.sortActivated(3, Qt.DescendingOrder)
                }
                else
                {
                    sortByEmail.state = "ascending"
                    sortBarPersonsLayout.sortActivated(3, Qt.AscendingOrder)
                }
            }
        }

        states: [
            State {
                name: "ascending"
                PropertyChanges {
                    target: sortByEmailButton
                    source: "qrc:/assets/icons/sort_down_light.png"
                }
            },
            State {
                name: "descending"
                PropertyChanges {
                    target: sortByEmailButton
                    source: "qrc:/assets/icons/sort_up_light.png"
                }
            }
        ]
    }

    Rectangle {
        id: sortByUsername
        width: rectangleWidth
        height: rectangleHeight
        color: rectangleColor

        state: "ascending"

        Text {
            id: sortByUsernameText
            text: "Username"
            font.pixelSize: columnTextFontSize
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: columnTextLeftMargin
        }

        Image {
            id: sortByUsernameButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 2
        }

        MouseArea {
            anchors.fill: sortByUsernameButton
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (sortByUsername.state == "ascending")
                {
                    sortByUsername.state = "descending"
                    sortBarPersonsLayout.sortActivated(4, Qt.DescendingOrder)
                }
                else
                {
                    sortByUsername.state = "ascending"
                    sortBarPersonsLayout.sortActivated(4, Qt.AscendingOrder)
                }
            }
        }

        states: [
            State {
                name: "ascending"
                PropertyChanges {
                    target: sortByUsernameButton
                    source: "qrc:/assets/icons/sort_down_light.png"
                }
            },
            State {
                name: "descending"
                PropertyChanges {
                    target: sortByUsernameButton
                    source: "qrc:/assets/icons/sort_up_light.png"
                }
            }
        ]
    }

    Rectangle {
        id: sortByRegDate
        width: rectangleWidth + 50
        height: rectangleHeight
        color: rectangleColor

        state: "ascending"

        Text {
            id: sortByRegDateText
            text: "Registered"
            font.pixelSize: columnTextFontSize
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: columnTextLeftMargin
        }

        Image {
            id: sortByRegDateButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 2
        }

        MouseArea {
            anchors.fill: sortByRegDateButton
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (sortByRegDate.state == "ascending")
                {
                    sortByRegDate.state = "descending"
                    sortBarPersonsLayout.sortActivated(5, Qt.DescendingOrder)
                }
                else
                {
                    sortByRegDate.state = "ascending"
                    sortBarPersonsLayout.sortActivated(5, Qt.AscendingOrder)
                }
            }
        }

        states: [
            State {
                name: "ascending"
                PropertyChanges {
                    target: sortByRegDateButton
                    source: "qrc:/assets/icons/sort_down_light.png"
                }
            },
            State {
                name: "descending"
                PropertyChanges {
                    target: sortByRegDateButton
                    source: "qrc:/assets/icons/sort_up_light.png"
                }
            }
        ]
    }

    Rectangle {
        id: sortBySuspendedDate
        width: rectangleWidth + 50
        height: rectangleHeight
        color: rectangleColor
        visible: showSuspended

        state: "ascending"

        Text {
            id: sortBySuspendedDateText
            text: "Suspended"
            font.pixelSize: columnTextFontSize
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: columnTextLeftMargin
        }

        Image {
            id: sortBySuspendedDateButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 2
        }

        MouseArea {
            anchors.fill: sortBySuspendedDateButton
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (sortBySuspendedDate.state == "ascending")
                {
                    sortBySuspendedDate.state = "descending"
                    sortBarPersonsLayout.sortActivated(6, Qt.DescendingOrder)
                }
                else
                {
                    sortBySuspendedDate.state = "ascending"
                    sortBarPersonsLayout.sortActivated(6, Qt.AscendingOrder)
                }
            }
        }

        states: [
            State {
                name: "ascending"
                PropertyChanges {
                    target: sortBySuspendedDateButton
                    source: "qrc:/assets/icons/sort_down_light.png"
                }
            },
            State {
                name: "descending"
                PropertyChanges {
                    target: sortBySuspendedDateButton
                    source: "qrc:/assets/icons/sort_up_light.png"
                }
            }
        ]
    }

    Rectangle {
        id: sortByDeregDate
        width: rectangleWidth + 50
        height: rectangleHeight
        color: rectangleColor
        visible: showDeregistered

        state: "ascending"

        Text {
            id: sortByDeregDateText
            text: "Deregistered"
            font.pixelSize: columnTextFontSize
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: columnTextLeftMargin
        }

        Image {
            id: sortByDeregDateButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 2
        }

        MouseArea {
            anchors.fill: sortByDeregDateButton
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (sortByDeregDate.state == "ascending")
                {
                    sortByDeregDate.state = "descending"
                    sortBarPersonsLayout.sortActivated(7, Qt.DescendingOrder)
                }
                else
                {
                    sortByDeregDate.state = "ascending"
                    sortBarPersonsLayout.sortActivated(7, Qt.AscendingOrder)
                }
            }
        }

        states: [
            State {
                name: "ascending"
                PropertyChanges {
                    target: sortByDeregDateButton
                    source: "qrc:/assets/icons/sort_down_light.png"
                }
            },
            State {
                name: "descending"
                PropertyChanges {
                    target: sortByDeregDateButton
                    source: "qrc:/assets/icons/sort_up_light.png"
                }
            }
        ]
    }

    Rectangle {
        id: action
        width: rectangleWidth * 2.2
        height: rectangleHeight
        color: rectangleColor

        Text {
            id: actionText
            text: "Action"
            font.pixelSize: columnTextFontSize
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: columnTextLeftMargin
        }
    }
}
