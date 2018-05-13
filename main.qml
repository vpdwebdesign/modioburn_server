import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import ModioBurn.Tools 1.0

import "Common"
import "Common/Dialogs"

ApplicationWindow {
    id: mainAppWindow

    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight
    visible: true

    MbTimer {
        id: mbTimer
    }

    PhoneCodeVerifier {
        id: phoneCodeVerifier
    }

    UserManager {
        id: userManager
    }

    StockItemsPurchasesModel {
        id: stockItemsPurchasesModel
        list: stockItemsPurchasesList

        Component.onCompleted:  {
            stockItemsPurchasesList.session = userManager.session
            stockItemsPurchasesList.stockItemsModel = stockItemsModel
        }
    }

    TransactionsModel {
        id: transactionsModel
        cart: shoppingCart
        onCartItemCountChanged: {
            mainToolBar.shoppingCartItems = cartItemCount
        }

        Component.onCompleted: shoppingCart.session = userManager.session
    }


    // Global property declarations
    property string name: userManager.name
    property string username: userManager.session.username
    property string role: userManager.session.role
    property bool loggedIn: userManager.session.loggedIn
    property bool switchedRoles: userManager.session.switchedRoles
    property bool selectedRole: userManager.session.selectedRole
    property int mainAppWindowX: mainAppWindow.x
    property int mainAppWindowY: mainAppWindow.y

    property Window apWin // audio player window
    property Window vpWin // video player window

    header: MainToolBar {
        id: mainToolBar
        currentPageTitle: mainView.currentItem.pageTitle
    }

    StackView {
        id: mainView
        focus: true
        anchors.fill: parent
        initialItem: OfficialsLogin {}

    }

    NotYet {
        id: notYet
    }

    ShutdownWait {
        id: shutdownWait
    }

    Timer {
        id: shutdownWaitTimer
        interval: 10000
        running: false
        onTriggered: {
            shutdownWait.close()
            Qt.quit()
        }
    }

    Shutdown {
        id: shutdownDialog

        onAccepted: {            
            userManager.session.stop()
            loggedIn = userManager.session.loggedIn
            role = userManager.session.role
            username = userManager.session.username
            switchedRoles = userManager.session.switchedRoles
            selectedRole = userManager.session.selectedRole
            shutdownWait.open()
            shutdownWaitTimer.start()
        }
        onRejected: {
            close()
        }
    }

    Logout {
        id: logoutDialog

        onAccepted: thankYou.open()
    }

    ThankYou {
        id: thankYou

        onClosed: {
            userManager.session.stop()
            loggedIn = userManager.session.loggedIn
            role = userManager.session.role
            username = userManager.session.username
            mainView.pop(null)
        }
    }
}
