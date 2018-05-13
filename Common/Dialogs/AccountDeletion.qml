import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import ModioBurn.Tools 1.0

import "../../Common"

Dialog {
    id:accountDeletionDialog

    x: Math.round((parent.width - width) / 2)
    y: Math.round((parent.height - height) / 2)
    width: 480
    height: 240
//    modal: true
    focus: true
    title: "Confirm Account Deletion"
    closePolicy: Popup.NoAutoClose


    property string role
    property string name
    property string username

    Colors {
        id: commonColors
    }

    UserManager {
        id: userManagerForAccountDeletion
    }

    ColumnLayout {
        width: parent.width
        spacing: 10

        Label {
            width: parent.width
            text: "Please confirm account deletion for " + role + " : " + name + ".\nThis process is not reversible."
            wrapMode: Text.Wrap
        }

        CheckBox {
            id: confirmFullDeletion
            anchors.left: parent.left
            anchors.leftMargin: 10
            text: "Permanently delete user's data from the database"
        }

        Label {
            id: message
            width: parent.width
            wrapMode: Text.Wrap
        }
    }

    standardButtons: Dialog.No | Dialog.Yes

    onAccepted: {
        if (confirmFullDeletion.checked)
        {
            if (userManagerForAccountDeletion.deleteUser(username))
            {
                message.color = commonColors.success
                message.text = "Permanent account deletion successful."
            }
            else
            {
                message.color = commonColors.danger
                message.text = "Permanent account deletion failed."
            }
        }
        else
        {
            userManagerForAccountDeletion.getUser(username)
            userManagerForAccountDeletion.status = "deleted"
            if (userManagerForAccountDeletion.updateUser())
            {
                message.color = commonColors.success
                message.text = "Account deletion successful."
            }
            else
            {
                message.color = commonColors.danger
                message.text = "Account deletion failed."
            }
        }

        delayTimer.interval = 5000
        delayTimer.start()
    }

    onRejected: {
        accountDeletionDialog.close()
    }

    Timer {
        id: delayTimer
        running: false
        repeat: false
        triggeredOnStart: false
        onTriggered: {
            accountDeletionDialog.close()
        }
    }
}
