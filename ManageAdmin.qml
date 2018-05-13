import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.3
import ModioBurn.Tools 1.0

import "Common"
import "Common/Dialogs"
import "Common/JS/functions.js" as Js

Pane {

    property string pageTitle: "Manage Administrators"

    property int delegateHeight: 70
    property int administratorsListRectangleWidth: 120
    property int administratorsListRectangleHeight: delegateHeight
    property int administratorsListRectLeftMargin: 5
    property string administratorsListRectangleColor: "transparent"
    property real administratorsListRectangleOpacity: 1.0
    property int administratorsListFontSize: 13

    property bool showSuspended: false
    property bool showDeregistered: false

    PersonnelModel {
        id: personnelModelAdministrators
    }

    RowLayout {
        id: searchBarRow
        width: parent.width
        height: 80

        Button {
            id: addPersonButton
            anchors.left: parent.left
            text: "Add"
            onClicked: {
                mainView.push("PersonnelRegistration.qml", {"newRole" : "administrator"})
            }

            ToolTip {
                visible: parent.hovered
                text: "Add Administrator"
            }
        }

        SearchBar {
            id: search
            Layout.fillWidth: true
            placeHolder: qsTr("Administrator name, phone, status")
            fuzzySearchEnabled: true
            onSearchActivated: {
               personnelModelAdministrators.filter(PersonnelModel.Administrator, searchString)
            }

        }

        RowLayout {
            anchors.right: parent.right
            anchors.rightMargin: 20
            height: parent.height
            spacing: 20

            Label {
                text: "View"
            }

            ComboBox {
                id: statusComboBox
                implicitWidth: 170
                model: ["Active", "Suspended", "Deleted"]
                onActivated: {
                    if (statusComboBox.currentText.toLowerCase() === "suspended")
                    {
                        showSuspended = true
                        sortBarPersons.showSuspended = showSuspended
                        showDeregistered = false
                        sortBarPersons.showDeregistered = showDeregistered
                    }
                    else if (statusComboBox.currentText.toLowerCase() === "deleted")
                    {
                        showDeregistered = true
                        sortBarPersons.showDeregistered = showDeregistered
                        showSuspended = false
                        sortBarPersons.showSuspended = showSuspended
                    }
                    else
                    {
                        showSuspended = false
                        sortBarPersons.showSuspended = showSuspended
                        showDeregistered = false
                        sortBarPersons.showDeregistered = showDeregistered
                    }

                    personnelModelAdministrators.filter(PersonnelModel.Administrator, statusComboBox.currentText.toLowerCase())
                }
            }
        }

    }

    Item {
        id: sortBarRow
        height: 30
        anchors.top: searchBarRow.bottom
        SortBarPersons {
            id: sortBarPersons
            onSortActivated: {
                personnelModelAdministrators.sort(PersonnelModel.Administrator, col, sortOrder)
            }
        }

    }

    ListView {
        id: administratorsListView
        clip: true
        anchors.top: sortBarRow.bottom
        anchors.topMargin: 20
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        model: personnelModelAdministrators.administratorsModel
        delegate: administratorsListDelegate
        ScrollBar.vertical: ScrollBar {}

        Component.onCompleted: {
            personnelModelAdministrators.filter(PersonnelModel.Administrator, statusComboBox.currentText.toLowerCase())
        }
    }

    Component {
        id: administratorsListDelegate

        Item {
            width: parent.width
            height: delegateHeight

            RowLayout {
                id: administratorsListDataRow
                width: parent.width
                height: parent.height

                Rectangle {
                    id: indexDisplayRect
                    height: parent.height
                    width: 25
                    color: administratorsListRectangleColor
                    anchors.left: parent.left

                    Rectangle {
                        anchors.centerIn: parent
                        height: 22
                        width: 22
                        color: "transparent"
                        border.width: 1
                        border.color: "#cccccc"
                        Text {
                            id: numberText
                            anchors.centerIn: parent
                            font.pixelSize: administratorsListFontSize - 2
                            color: "#f3f3f4"
                            text: String(model.index + 1)
                        }
                    }
                }

                Rectangle {
                    id: nameDisplayRect
                    height: parent.height
                    width: administratorsListRectangleWidth
                    color: administratorsListRectangleColor
                    anchors.left: indexDisplayRect.right
                    anchors.leftMargin: administratorsListRectLeftMargin
                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: administratorsListFontSize
                        color: "#f3f3f4"
                        text: Js.capitalizeAny(name, ' ')
                        width: parent.width - 10
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: genderDisplayRect
                    height: parent.height
                    width: Math.round(administratorsListRectangleWidth / 1.5)
                    color: administratorsListRectangleColor
                    anchors.left: nameDisplayRect.right
                    anchors.leftMargin: administratorsListRectLeftMargin
                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: administratorsListFontSize
                        color: "#f3f3f4"
                        text: Js.capitalize(gender)
                        width: parent.width - 10
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: phoneDisplayRect
                    height: parent.height
                    width: administratorsListRectangleWidth
                    color: administratorsListRectangleColor
                    anchors.left: genderDisplayRect.right
                    anchors.leftMargin: administratorsListRectLeftMargin
                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: administratorsListFontSize
                        color: "#f3f3f4"
                        text: phone
                        width: parent.width - 10
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: emailDisplayRect
                    height: parent.height
                    width: administratorsListRectangleWidth + 30
                    color: administratorsListRectangleColor
                    anchors.left: phoneDisplayRect.right
                    anchors.leftMargin: administratorsListRectLeftMargin
                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: administratorsListFontSize
                        color: "#f3f3f4"
                        text: email
                        width: parent.width - 10
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: usernameDisplayRect
                    height: parent.height
                    width: administratorsListRectangleWidth
                    color: administratorsListRectangleColor
                    anchors.left: emailDisplayRect.right
                    anchors.leftMargin: administratorsListRectLeftMargin
                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: administratorsListFontSize
                        color: "#f3f3f4"
                        text: username
                        width: parent.width - 10
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: regDateDisplayRect
                    height: parent.height
                    width: administratorsListRectangleWidth + 50
                    color: administratorsListRectangleColor
                    anchors.left: usernameDisplayRect.right
                    anchors.leftMargin: administratorsListRectLeftMargin
                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: administratorsListFontSize
                        color: "#f3f3f4"
                        text: registered_date
                        width: parent.width - 10
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: susDateDisplayRect
                    height: parent.height
                    width: administratorsListRectangleWidth + 50
                    color: administratorsListRectangleColor
                    anchors.left: regDateDisplayRect.right
                    anchors.leftMargin: administratorsListRectLeftMargin
                    visible: showSuspended

                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: administratorsListFontSize
                        color: "#f3f3f4"
                        text: suspended_date
                        width: parent.width - 10
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: deregDateDisplayRect
                    height: parent.height
                    width: administratorsListRectangleWidth + 50
                    color: administratorsListRectangleColor
                    anchors.left: regDateDisplayRect.right
                    anchors.leftMargin: administratorsListRectLeftMargin
                    visible: showDeregistered

                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: administratorsListFontSize
                        color: "#f3f3f4"
                        text: deregistered_date
                        width: parent.width - 10
                        wrapMode: Text.WordWrap
                    }
                }

                RowLayout {
                    id: actionDisplayLayout
                    height: parent.height
                    width: administratorsListRectangleWidth * 2.2
                    anchors.left: {
                        if (susDateDisplayRect.visible)
                            return susDateDisplayRect.right
                        else if (deregDateDisplayRect.visible)
                            return deregDateDisplayRect.right
                        else
                            return regDateDisplayRect.right
                    }

                    anchors.leftMargin: administratorsListRectLeftMargin
                    Button {
                        anchors.verticalCenter: parent.verticalCenter
                        enabled: (status !== "deleted")
                        text: "edit"
                    }
                    Button {
                        id: activateOrSuspendButton
                        anchors.verticalCenter: parent.verticalCenter
                        enabled: (status !== "deleted")
                        text: (status === "suspended") ? "activate" : "suspend"
                        onClicked: {
                            if (activateOrSuspendButton.text === "suspend")
                            {
                                accountSuspensionDialog.role = "administrator"
                                accountSuspensionDialog.name = Js.capitalizeAny(name, ' ')
                                accountSuspensionDialog.username = username
                                accountSuspensionDialog.open()
                            }
                            else
                            {
                                accountActivationDialog.role = "administrator"
                                accountActivationDialog.name = Js.capitalizeAny(name, ' ')
                                accountActivationDialog.username = username
                                accountActivationDialog.open()
                            }
                        }
                    }
                    Button {
                        anchors.verticalCenter: parent.verticalCenter
                        enabled: (status !== "deleted")
                        text: "delete"
                        onClicked: {
                            accountDeletionDialog.role = "administrator"
                            accountDeletionDialog.name = Js.capitalizeAny(name, ' ')
                            accountDeletionDialog.username = username
                            accountDeletionDialog.open()
                        }
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

    AccountActivation {
        id: accountActivationDialog
        onClosed: {
            // re-initialize model and run filter for current status
            personnelModelAdministrators.filter(PersonnelModel.Administrator, statusComboBox.currentText.toLowerCase())
        }
    }

    AccountSuspension {
        id: accountSuspensionDialog
        onClosed: {
            // re-initialize model and run filter for current status
            personnelModelAdministrators.filter(PersonnelModel.Administrator, statusComboBox.currentText.toLowerCase())
        }
    }

    AccountDeletion {
        id: accountDeletionDialog
        onClosed: {
            // re-initialize model and run filter for current status
            personnelModelAdministrators.filter(PersonnelModel.Administrator, statusComboBox.currentText.toLowerCase())
        }
    }
}

