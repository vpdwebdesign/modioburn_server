import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

RowLayout {
    property string userRole

    Label {
        text: "Switch Role"
    }

    ComboBox {
        id: switchRoleOptions
        implicitWidth: 200
        model: ListModel {
            id: rolesModel
            ListElement { role: "Super Administrator" }
            ListElement { role: "Administrator" }
            ListElement { role: "Manager" }
            ListElement { role: "Attendant" }
            ListElement { role: "Customer" }
        }
        textRole: "role"
        onActivated: {
            userManager.session.switchedRoles = true

            switch (currentText.toLowerCase()) {
                case "administrator":
                    userManager.session.selectedRole = "administrator"
                    mainView.push("../AdministratorHome.qml")
                    break;
                case "manager":
                    userManager.session.selectedRole = "manager"
                    mainView.push("../ManagerHome.qml")
                    break;
                case "attendant":
                    userManager.session.selectedRole = "attendant"
                    mainView.push("../AttendantHome.qml")
                    break;
                case "customer":
                    userManager.session.selectedRole = "customer"
                    mainView.push("../CustomerHome.qml")
                    break;
            }
        }

        Component.onCompleted: {
            switch (userRole.toLowerCase()) {
            case "super-administrator":
                rolesModel.remove(0)
                break;
            case "administrator":
                rolesModel.remove(0, 2)
                break;
            case "manager":
                rolesModel.remove(0, 3)
                break;
            case "attendant":
                rolesModel.remove(0, 4)
                break;
            }
        }
    }
}
