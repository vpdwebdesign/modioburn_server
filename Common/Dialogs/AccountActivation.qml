import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import ModioBurn.Tools 1.0

import "../../Common"

Dialog {
    id:accountActivationDialog

    x: Math.round((parent.width - width) / 2)
    y: Math.round((parent.height - height) / 2)
    width: 480
    height: 180
//    modal: true
    focus: true
    title: "Confirm Account Activation"
    closePolicy: Popup.NoAutoClose


    property string role
    property string name
    property string username

    Colors {
        id: commonColors
    }

    UserManager {
        id: userManagerForAccountActivation
    }

    ColumnLayout {
        width: parent.width
        spacing: 10

        Label {
            width: parent.width
            text: "Please confirm account activation for " + role + " : " + name + ".\nAccount activation is effective immediately."
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
        userManagerForAccountActivation.getUser(username)
        userManagerForAccountActivation.status = "active"
        if (userManagerForAccountActivation.updateUser())
        {
            message.color = commonColors.success
            message.text = "Account activation successful."
        }
        else
        {
            message.color = commonColors.danger
            message.text = "Account activation failed."
        }

        delayTimer.interval = 5000
        delayTimer.start()
    }

    onRejected: {
        accountActivationDialog.close()
    }

    Timer {
        id: delayTimer
        running: false
        repeat: false
        triggeredOnStart: false
        onTriggered: {
            accountActivationDialog.close()
        }
    }
}
