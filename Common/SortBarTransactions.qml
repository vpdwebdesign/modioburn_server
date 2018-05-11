import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

RowLayout {
    id: sortBarTransactionsLayout
    height: parent.height
    anchors.left: parent.left
    anchors.leftMargin: 30
    spacing: 5

    property int rectangleWidth: 120
    property int rectangleHeight: parent.height
    property int yearRectangleWidth: Math.round(rectangleWidth / 1.5)
    property string rectangleColor: "#607d8b"
    property int columnTextFontSize: 12
    property int columnTextLeftMargin: 5
    property int sortIconRightMargin: 1

    signal sortActivated(int col, int sortOrder)

    Rectangle {
        id: sortByItemType
        width: rectangleWidth - 20
        height: rectangleHeight
        color: rectangleColor

        state: "ascending"

        Text {
            id: sortByItemTypeText
            text: "Item Type"
            font.pixelSize: columnTextFontSize
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: columnTextLeftMargin
        }

//        Image {
//            id: sortByItemTypeButton
//            anchors.verticalCenter: parent.verticalCenter
//            anchors.right: parent.right
//            anchors.rightMargin: 2
//        }

//        MouseArea {
//            anchors.fill: sortByItemTypeButton
//            hoverEnabled: true
//            cursorShape: Qt.PointingHandCursor
//            onClicked: {
//                if (sortByItemType.state == "ascending")
//                {
//                    sortByItemType.state = "descending"
//                    sortBarTransactionsLayout.sortActivated(0, Qt.DescendingOrder)
//                }
//                else
//                {
//                    sortByItemType.state = "ascending"
//                    sortBarTransactionsLayout.sortActivated(0, Qt.AscendingOrder)
//                }
//            }
//        }

//        states: [
//            State {
//                name: "ascending"
//                PropertyChanges {
//                    target: sortByItemTypeButton
//                    source: "qrc:/assets/icons/sort_down_light.png"
//                }
//            },
//            State {
//                name: "descending"
//                PropertyChanges {
//                    target: sortByItemTypeButton
//                    source: "qrc:/assets/icons/sort_up_light.png"
//                }
//            }
//        ]
    }

    Rectangle {
        id: sortByDescription
        width: rectangleWidth + 40
        height: rectangleHeight
        color: rectangleColor

        state: "ascending"

        Text {
            id: sortByDescriptionText
            text: "Description"
            font.pixelSize: columnTextFontSize
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: columnTextLeftMargin
        }

//        Image {
//            id: sortByDescriptionButton
//            anchors.verticalCenter: parent.verticalCenter
//            anchors.right: parent.right
//            anchors.rightMargin: 2
//        }

//        MouseArea {
//            anchors.fill: sortByDescriptionButton
//            hoverEnabled: true
//            cursorShape: Qt.PointingHandCursor
//            onClicked: {
//                if (sortByDescription.state == "ascending")
//                {
//                    sortByDescription.state = "descending"
//                    sortBarTransactionsLayout.sortActivated(0, Qt.DescendingOrder)
//                }
//                else
//                {
//                    sortByDescription.state = "ascending"
//                    sortBarTransactionsLayout.sortActivated(0, Qt.AscendingOrder)
//                }
//            }
//        }

//        states: [
//            State {
//                name: "ascending"
//                PropertyChanges {
//                    target: sortByDescriptionButton
//                    source: "qrc:/assets/icons/sort_down_light.png"
//                }
//            },
//            State {
//                name: "descending"
//                PropertyChanges {
//                    target: sortByDescriptionButton
//                    source: "qrc:/assets/icons/sort_up_light.png"
//                }
//            }
//        ]
    }

    Rectangle {
        id: sortByQuantity
        width: rectangleWidth - 40
        height: rectangleHeight
        color: rectangleColor

        state: "ascending"

        Text {
            id: sortByQuantityText
            text: "Quantity"
            font.pixelSize: columnTextFontSize
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: columnTextLeftMargin
        }

        Image {
            id: sortByQuantityButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 2
        }

        MouseArea {
            anchors.fill: sortByQuantityButton
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (sortByQuantity.state == "ascending")
                {
                    sortByQuantity.state = "descending"
                    sortBarTransactionsLayout.sortActivated(3, Qt.DescendingOrder)
                }
                else
                {
                    sortByQuantity.state = "ascending"
                    sortBarTransactionsLayout.sortActivated(3, Qt.AscendingOrder)
                }
            }
        }

        states: [
            State {
                name: "ascending"
                PropertyChanges {
                    target: sortByQuantityButton
                    source: "qrc:/assets/icons/sort_down_light.png"
                }
            },
            State {
                name: "descending"
                PropertyChanges {
                    target: sortByQuantityButton
                    source: "qrc:/assets/icons/sort_up_light.png"
                }
            }
        ]
    }

    Rectangle {
        id: sortByPPU
        width: rectangleWidth - 30
        height: rectangleHeight
        color: rectangleColor

        state: "ascending"

        Text {
            id: sortByPPUText
            text: "PPU (Ksh)"
            font.pixelSize: columnTextFontSize
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: columnTextLeftMargin

            MouseArea {
                id: sortByPPUMouseArea
                anchors.fill: sortByPPUText
                hoverEnabled: true

                ToolTip.visible: sortByPPUMouseArea.containsMouse
                ToolTip.text: "Price Per Unit"
            }
        }

        Image {
            id: sortByPPUButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 2
        }

        MouseArea {
            anchors.fill: sortByPPUButton
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (sortByPPU.state == "ascending")
                {
                    sortByPPU.state = "descending"
                    sortBarTransactionsLayout.sortActivated(4, Qt.DescendingOrder)
                }
                else
                {
                    sortByPPU.state = "ascending"
                    sortBarTransactionsLayout.sortActivated(4, Qt.AscendingOrder)
                }
            }
        }

        states: [
            State {
                name: "ascending"
                PropertyChanges {
                    target: sortByPPUButton
                    source: "qrc:/assets/icons/sort_down_light.png"
                }
            },
            State {
                name: "descending"
                PropertyChanges {
                    target: sortByPPUButton
                    source: "qrc:/assets/icons/sort_up_light.png"
                }
            }
        ]
    }

    Rectangle {
        id: sortByTotalCost
        width: rectangleWidth - 10
        height: rectangleHeight
        color: rectangleColor

        state: "ascending"

        Text {
            id: sortByTotalCostText
            text: "Total Cost (Ksh)"
            font.pixelSize: columnTextFontSize
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: columnTextLeftMargin
        }

        Image {
            id: sortByTotalCostButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 2
        }

        MouseArea {
            anchors.fill: sortByTotalCostButton
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (sortByTotalCost.state == "ascending")
                {
                    sortByTotalCost.state = "descending"
                    sortBarTransactionsLayout.sortActivated(5, Qt.DescendingOrder)
                }
                else
                {
                    sortByTotalCost.state = "ascending"
                    sortBarTransactionsLayout.sortActivated(5, Qt.AscendingOrder)
                }
            }
        }

        states: [
            State {
                name: "ascending"
                PropertyChanges {
                    target: sortByTotalCostButton
                    source: "qrc:/assets/icons/sort_down_light.png"
                }
            },
            State {
                name: "descending"
                PropertyChanges {
                    target: sortByTotalCostButton
                    source: "qrc:/assets/icons/sort_up_light.png"
                }
            }
        ]
    }

    Rectangle {
        id: sortByCopyMedium
        width: rectangleWidth - 40
        height: rectangleHeight
        color: rectangleColor

        state: "ascending"

        Text {
            id: sortByCopyMediumText
            text: "Medium"
            font.pixelSize: columnTextFontSize
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: columnTextLeftMargin
        }

//        Image {
//            id: sortByCopyMediumButton
//            anchors.verticalCenter: parent.verticalCenter
//            anchors.right: parent.right
//            anchors.rightMargin: 2
//        }

//        MouseArea {
//            anchors.fill: sortByCopyMediumButton
//            hoverEnabled: true
//            cursorShape: Qt.PointingHandCursor
//            onClicked: {
//                if (sortByCopyMedium.state == "ascending")
//                {
//                    sortByCopyMedium.state = "descending"
//                    sortBarTransactionsLayout.sortActivated(0, Qt.DescendingOrder)
//                }
//                else
//                {
//                    sortByCopyMedium.state = "ascending"
//                    sortBarTransactionsLayout.sortActivated(0, Qt.AscendingOrder)
//                }
//            }
//        }

//        states: [
//            State {
//                name: "ascending"
//                PropertyChanges {
//                    target: sortByCopyMediumButton
//                    source: "qrc:/assets/icons/sort_down_light.png"
//                }
//            },
//            State {
//                name: "descending"
//                PropertyChanges {
//                    target: sortByCopyMediumButton
//                    source: "qrc:/assets/icons/sort_up_light.png"
//                }
//            }
//        ]
    }

    Rectangle {
        id: sortByPaymentMethod
        width: rectangleWidth
        height: rectangleHeight
        color: rectangleColor

        state: "ascending"

        Text {
            id: sortByPaymentMethodText
            text: "Payment Method"
            font.pixelSize: columnTextFontSize
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: columnTextLeftMargin
        }

//        Image {
//            id: sortByPaymentMethodButton
//            anchors.verticalCenter: parent.verticalCenter
//            anchors.right: parent.right
//            anchors.rightMargin: 2
//        }

//        MouseArea {
//            anchors.fill: sortByPaymentMethodButton
//            hoverEnabled: true
//            cursorShape: Qt.PointingHandCursor
//            onClicked: {
//                if (sortByPaymentMethod.state == "ascending")
//                {
//                    sortByPaymentMethod.state = "descending"
//                    sortBarTransactionsLayout.sortActivated(0, Qt.DescendingOrder)
//                }
//                else
//                {
//                    sortByPaymentMethod.state = "ascending"
//                    sortBarTransactionsLayout.sortActivated(0, Qt.AscendingOrder)
//                }
//            }
//        }

//        states: [
//            State {
//                name: "ascending"
//                PropertyChanges {
//                    target: sortByPaymentMethodButton
//                    source: "qrc:/assets/icons/sort_down_light.png"
//                }
//            },
//            State {
//                name: "descending"
//                PropertyChanges {
//                    target: sortByPaymentMethodButton
//                    source: "qrc:/assets/icons/sort_up_light.png"
//                }
//            }
//        ]
    }


    Rectangle {
        id: sortByCustomerUsername
        width: rectangleWidth - 20
        height: rectangleHeight
        color: rectangleColor

        state: "ascending"

        Text {
            id: sortByCustomerUsernameText
            text: "Username"
            font.pixelSize: columnTextFontSize
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: columnTextLeftMargin
        }

//        Image {
//            id: sortByCustomerUsernameButton
//            anchors.verticalCenter: parent.verticalCenter
//            anchors.right: parent.right
//            anchors.rightMargin: 2
//        }

//        MouseArea {
//            anchors.fill: sortByCustomerUsernameButton
//            hoverEnabled: true
//            cursorShape: Qt.PointingHandCursor
//            onClicked: {
//                if (sortByCustomerUsername.state == "ascending")
//                {
//                    sortByCustomerUsername.state = "descending"
//                    sortBarTransactionsLayout.sortActivated(0, Qt.DescendingOrder)
//                }
//                else
//                {
//                    sortByCustomerUsername.state = "ascending"
//                    sortBarTransactionsLayout.sortActivated(0, Qt.AscendingOrder)
//                }
//            }
//        }

//        states: [
//            State {
//                name: "ascending"
//                PropertyChanges {
//                    target: sortByCustomerUsernameButton
//                    source: "qrc:/assets/icons/sort_down_light.png"
//                }
//            },
//            State {
//                name: "descending"
//                PropertyChanges {
//                    target: sortByCustomerUsernameButton
//                    source: "qrc:/assets/icons/sort_up_light.png"
//                }
//            }
//        ]
    }

    Rectangle {
        id: sortByDateTime
        width: rectangleWidth
        height: rectangleHeight
        color: rectangleColor

        state: "ascending"

        Text {
            id: sortByDateTimeText
            text: "Date/Time"
            font.pixelSize: columnTextFontSize
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: columnTextLeftMargin
        }

        Image {
            id: sortByDateTimeButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 2
        }

        MouseArea {
            anchors.fill: sortByDateTimeButton
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (sortByDateTime.state == "ascending")
                {
                    sortByDateTime.state = "descending"
                    sortBarTransactionsLayout.sortActivated(9, Qt.DescendingOrder)
                }
                else
                {
                    sortByDateTime.state = "ascending"
                    sortBarTransactionsLayout.sortActivated(9, Qt.AscendingOrder)
                }
            }
        }

        states: [
            State {
                name: "ascending"
                PropertyChanges {
                    target: sortByDateTimeButton
                    source: "qrc:/assets/icons/sort_down_light.png"
                }
            },
            State {
                name: "descending"
                PropertyChanges {
                    target: sortByDateTimeButton
                    source: "qrc:/assets/icons/sort_up_light.png"
                }
            }
        ]
    }

    Rectangle {
        id: action
        width: rectangleWidth
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

    Rectangle {
        id: options
        width: rectangleWidth - 40
        height: rectangleHeight
        color: rectangleColor

        Text {
            id: optionsText
            text: "Option"
            font.pixelSize: columnTextFontSize
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: columnTextLeftMargin
        }
    }
}
