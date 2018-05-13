import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import ModioBurn.Tools 1.0

import "../../Common"

Dialog {
    id:accountSuspensionDialog

    x: Math.round((parent.width - width) / 2)
    y: Math.round((parent.height - height) / 2)
    width: 480
    height: 180
//    modal: true
    focus: true
    title: "Confirm Account Suspension"
    closePolicy: Popup.NoAutoClose


    property string role
    property string name
    property string username

    Colors {
        id: commonColors
    }

    UserManager {
        id: userManagerForAccountSuspension
    }

    ColumnLayout {
        width: parent.width
        spacing: 10

        Label {
            width: parent.width
            text: "Please confirm account suspension for " + role + " : " + name + ".\nYou can lift the suspension at any time."
            wrapMode: Text.Wrap
        }

        Label {
            id: message
            width: parent.width
            wrapMode: Text.Wrap
        }
    }

    standardButtons: Dialog.No | Dialog.Yes

    onAccepted: {
        userManagerForAccountSuspension.getUser(username)
        userManagerForAccountSuspension.status = "suspended"
        if (userManagerForAccountSuspension.updateUser())
        {
            message.color = commonColors.success
            message.text = "Account suspension successful."
        }
        else
        {
            message.color = commonColors.danger
            message.text = "Account suspension failed."
        }

        delayTimer.interval = 5000
        delayTimer.start()
    }

    onRejected: {
        accountSuspensionDialog.close()
    }

    Timer {
        id: delayTimer
        running: false
        repeat: false
        triggeredOnStart: false
        onTriggered: {
            accountSuspensionDialog.close()
        }
    }
}
