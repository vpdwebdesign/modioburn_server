import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import ModioBurn.Tools 1.0

Pane {

    property string pageTitle: qsTr("Welcome to ModioBurn")

    Component.onCompleted: usernameTextField.focus = true

    RowLayout {
        id: login
        width: Math.round(parent.width / 2.5)
        height: 550
        anchors.centerIn: parent

        Rectangle {
            anchors.fill: parent
            color: "#404244"
            opacity: 0.9


            RowLayout {
                id: logoRow
                width: parent.width
                height: 210
                anchors.top: parent.top
                anchors.topMargin: 10

                Image {
                    id: logo
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "qrc:/assets/icons/logo.png"
                }
            }

            RowLayout {
                id: titleRow
                width: parent.width
                anchors.top: logoRow.bottom
                anchors.topMargin: 20
                height: 40

                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 25
                    color: "#e0e0e0"
                    text: "Officials Login"
                }
            }

            RowLayout {
                id: usernameRow
                spacing: 10
                width: parent.width
                anchors.top: titleRow.bottom
                anchors.topMargin: 30
                height: 50

                Label {
                    id: usernameLabel
                    text: "Username"
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                }
                TextField {
                    id: usernameTextField
                    anchors.left: usernameLabel.right
                    anchors.leftMargin: 10
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    Layout.fillWidth: true
                    placeholderText: "Enter your username or phone number"
                    selectByMouse: true
                    onAccepted: passwordTextField.focus = true
                }
            }
            RowLayout {
                id: passwordRow
                spacing: 10
                width: parent.width
                height: 50
                anchors.top: usernameRow.bottom
                anchors.topMargin: 10

                Label {
                    id: passwordLabel
                    text: "Password"
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                }
                TextField {
                    id: passwordTextField
                    anchors.left: passwordLabel.right
                    anchors.leftMargin: 10
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    Layout.fillWidth: true
                    echoMode: TextInput.Password
                    placeholderText: "Enter your password"
                    selectByMouse: true
                    onAccepted: {
                        var enteredName = (usernameTextField.text).toLowerCase()
                        var enteredPassword = passwordTextField.text

                        if (enteredName.length > 0 && enteredPassword.length > 0) {
                            if (userManager.authenticate(enteredName, enteredPassword)) {
                                usernameTextField.clear()
                                passwordTextField.clear()

                                name = userManager.name
                                username = userManager.session.username
                                role = userManager.session.role
                                loggedIn = userManager.session.loggedIn

                                switch(role.toLowerCase()) {
                                case "super-administrator":
                                    mainView.pop()
                                    mainView.push("SuperAdministratorHome.qml")
                                    break;
                                case "administrator":
                                    mainView.pop()
                                    mainView.push("AdministratorHome.qml")
                                    break;
                                case "manager":
                                    mainView.pop()
                                    mainView.push("ManagerHome.qml")
                                    break;
                                case "attendant":
                                    mainView.pop()
                                    mainView.push("AttendantHome.qml")
                                    break;
                                case "customer":
                                    genericErrorDialog.title = "Unauthorized User"
                                    genericErrorMessage.text = "You're not a ModioBurn official. Please log in at a client machine. Any further attempts to log in here will be reported to the manager."
                                    genericErrorDialog.open()

                                    userManager.session.stop()
                                    loggedIn = userManager.session.loggedIn
                                    role = userManager.session.role
                                    username = userManager.session.username

                                    break;
                                }
                            } else {
                                genericErrorDialog.title = "Wrong Credentials"
                                genericErrorMessage.text = "Please enter the correct credentials to log in"
                                genericErrorDialog.open()
                            }
                        } else {
                            genericErrorDialog.title = "Missing Info"
                            genericErrorMessage.text = "Please fill in both the username and password fields to log in"
                            genericErrorDialog.open()
                        }
                    }
                }
            }

            RowLayout {
                id: forgotPasswordRow
                width: parent.width
                height: 10
                anchors.top: passwordRow.bottom
                anchors.topMargin: 5

                Text {
                    id: forgotPasswordLink
                    color: "#3bc9db"
                    text: qsTr("Forgot Password?")
                    anchors.right: parent.right
                    anchors.rightMargin: 10

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onEntered: forgotPasswordLink.color = "#99e9f2"
                        onExited: forgotPasswordLink.color = "#3bc9db"
                        onClicked: function() {
                            forgotPasswordDialog.open();
                        }
                    }
                }
            }

            RowLayout {
                id: buttonsRow
                width: parent.width
                height: 50
                anchors.top: forgotPasswordRow.bottom
                anchors.topMargin: 20

                Button {
                    id: resetButton
                    text: "Reset"
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.right: parent.horizontalCenter
                    anchors.rightMargin: 3
                    onClicked: function() {
                        usernameTextField.clear();
                        passwordTextField.clear();
                        usernameTextField.focus = true;
                    }
                }

                Button {
                    id: loginButton
                    text: "Login"
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.left: parent.horizontalCenter
                    anchors.leftMargin: 3
                    onClicked: {
                        var enteredName = (usernameTextField.text).toLowerCase()
                        var enteredPassword = passwordTextField.text

                        if (enteredName.length > 0 && enteredPassword.length > 0) {
                            if (userManager.authenticate(enteredName, enteredPassword)) {
                                usernameTextField.clear()
                                passwordTextField.clear()

                                name = userManager.name
                                username = userManager.session.username
                                role = userManager.session.role
                                loggedIn = userManager.session.loggedIn

                                switch(role.toLowerCase()) {
                                case "super-administrator":
                                    mainView.pop()
                                    mainView.push("SuperAdministratorHome.qml")
                                    break;
                                case "administrator":
                                    mainView.pop()
                                    mainView.push("AdministratorHome.qml")
                                    break;
                                case "manager":
                                    mainView.pop()
                                    mainView.push("ManagerHome.qml")
                                    break;
                                case "attendant":
                                    mainView.pop()
                                    mainView.push("AttendantHome.qml")
                                    break;
                                case "customer":
                                    genericErrorDialog.title = "Unauthorized User"
                                    genericErrorMessage.text = "You're not a ModioBurn official. Please log in at a client machine. Any further attempts to log in here will be reported to the manager."
                                    genericErrorDialog.open()

                                    userManager.session.stop()
                                    loggedIn = userManager.session.loggedIn
                                    role = userManager.session.role
                                    username = userManager.session.username

                                    break;
                                }
                            } else {
                                genericErrorDialog.title = "Wrong Credentials"
                                genericErrorMessage.text = "Please enter the correct credentials to log in"
                                genericErrorDialog.open()
                            }
                        } else {
                            genericErrorDialog.title = "Missing Info"
                            genericErrorMessage.text = "Please fill in both the username and password fields to log in"
                            genericErrorDialog.open()
                        }
                    }
                }
            }

        }
    }

    Dialog {
        id: forgotPasswordDialog
        x: login.x + 20
        y: login.y + 20
        width: login.width - 40
        height: login.height - 40
        modal: true
        focus: true
        title: qsTr("Reset Password")

        Rectangle {
            color: "transparent"
            anchors.fill: parent

            Label {
                id: instructionsLabel1
                width: parent.width
                text: qsTr("Please enter the phone number you used to register an account with us to receive a 4-digit code that you can use to reset your password")
                wrapMode: Label.Wrap
            }

            RowLayout {
                id: phoneInputRow
                width: parent.width
                height: 50
                anchors.top: instructionsLabel1.bottom
                anchors.topMargin: 20

                Label {
                    id: phoneLabel
                    font.pixelSize: 20
                    text: "Phone"
                }

                TextField {
                    id: phoneTextField
                    anchors.left: phoneLabel.right
                    anchors.leftMargin: 20
                    anchors.right: getCodeButton.left
                    anchors.rightMargin: 20
                    placeholderText: "e.g. 0712123456"
                    inputMask: "9999999999"
                    focus: true
                }

                Button {
                    id: getCodeButton
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    text: "Get Code"
                    enabled: phoneTextField.acceptableInput ? true : false
                    onClicked: function() {
                        instructionsLabel2.visible = true;
                        codeInputRow.visible = true;
                        codeTextField.clear();
                        instructionsLabel3.visible = false;
                        codeTextField.focus = true;
                        phoneCodeVerifier.codeRequestMethod = PhoneCodeVerifier.SMS;
                        phoneCodeVerifier.phoneNumber = phoneTextField.text;
                        var codeReqSuccess = phoneCodeVerifier.codeRequest();
                        if (codeReqSuccess)
                        {
                            instructionsLabel3.text = "Code Sent. It might take up to 2 mins to arrive. Click GET CODE to resend it if it doesn't.";
                            instructionsLabel3.visible = true;
                        } else {
                            instructionsLabel3.text = "Code not sent. Please try again.";
                            instructionsLabel3.visible = true;
                        }
                    }
                }

            }

            Label {
                id: instructionsLabel2
                width: parent.width
                anchors.top: phoneInputRow.bottom
                anchors.topMargin: 30
                text: "Enter the 4-digit code you'll receive on your phone shortly"
                wrapMode: Label.Wrap
                visible: false
            }

            RowLayout {
                id: codeInputRow
                width: parent.width
                height: 40
                anchors.top: instructionsLabel2.bottom
                anchors.topMargin: 10
                visible: false

                Label {
                    id: codeLabel
                    font.pixelSize: 15
                    text: "Code"
                }

                TextField {
                    id: codeTextField
                    anchors.left: codeLabel.right
                    anchors.leftMargin: 20
                    placeholderText: "e.g. 1234"
                    inputMask: "9999"
                }

                Button {
                    id: submitCodeButton
                    anchors.left: codeTextField.right
                    anchors.leftMargin: 20
                    text: "Verify"
                    enabled: codeTextField.acceptableInput ? true : false
                    onClicked: function() {
                        newPasswordRow.visible = false;
                        confirmNewPasswordRow.visible = false;
                        confirmNewPasswordButtonRow.visible = false;
                        instructionsLabel3.visible = false;
                        phoneCodeVerifier.code = codeTextField.text;
                        var codeVerificationSuccess = phoneCodeVerifier.codeVerify();
                        if (codeVerificationSuccess)
                        {
                            instructionsLabel3.text = "Code verification successful.";
                            instructionsLabel3.visible = true;
                            newPasswordRow.visible = true;
                            confirmNewPasswordRow.visible = true;
                            confirmNewPasswordButtonRow.visible = true;
                        } else {
                            newPasswordRow.visible = false;
                            confirmNewPasswordRow.visible = false;
                            confirmNewPasswordButtonRow.visible = false;
                            instructionsLabel3.text = "Code verification not successful. Please try again.";
                            instructionsLabel3.visible = true;
                        }
                    }
                }

            }

            Label {
                id: instructionsLabel3
                width: parent.width
                anchors.top: codeInputRow.bottom
                anchors.topMargin: 30
                color: "#a7e3ef"
                wrapMode: Label.Wrap
                visible: false
            }

            RowLayout {
                id: newPasswordRow
                width: parent.width
                height: 40
                anchors.top: instructionsLabel3.bottom
                visible: false

                Label {
                    id: newPasswordLabel
                    font.pixelSize: 15
                    text: "New Password"
                }

                TextField {
                    id: newPasswordTextField
                    anchors.left: newPasswordLabel.right
                    anchors.leftMargin: 78
                    anchors.right: parent.right
                    Layout.fillWidth: true
                    echoMode: TextInput.Password
                    selectByMouse: true
                }

            }

            RowLayout {
                id: confirmNewPasswordRow
                width: parent.width
                height: 40
                anchors.top: newPasswordRow.bottom
                visible: false

                Label {
                    id: confirmNewPasswordLabel
                    font.pixelSize: 15
                    text: "Confirm New Password"
                }

                TextField {
                    id: confirmNewPasswordTextField
                    anchors.left: confirmNewPasswordLabel.right
                    anchors.leftMargin: 20
                    anchors.right: parent.right
                    Layout.fillWidth: true
                    echoMode: TextInput.Password
                    selectByMouse: true
                }

            }



            RowLayout {
                id: confirmNewPasswordButtonRow
                width: parent.width
                height: 40
                anchors.top: confirmNewPasswordRow.bottom
                anchors.topMargin: 10
                visible: false

                Button {
                    anchors.centerIn: parent
                    width: Math.round(parent.width / 2)
                    text: "Change Password"
                }

            }
        }

        PhoneCodeVerifier {
            id: phoneCodeVerifier
        }

        onRejected: function() {
            phoneTextField.clear();
            codeTextField.clear();
            instructionsLabel2.visible = false;
            codeInputRow.visible = false;
            instructionsLabel3.visible = false;
            newPasswordRow.visible = false;
            confirmNewPasswordRow.visible = false;
            confirmNewPasswordButtonRow.visible = false;
        }

        standardButtons: Dialog.Close
    }

    Dialog {
        id: genericErrorDialog
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: Math.round(0.8 * login.width)
        modal: true
        focus: true
        Label {
            id: genericErrorMessage
            width: parent.width
            wrapMode: Label.Wrap
        }
        standardButtons: Dialog.Close
    }
}

