import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.XmlListModel 2.0
import ModioBurn.Tools 1.0

import "Common"
import "Common/Dialogs"

Pane {

    property string pageTitle: qsTr("Sell Shop Items")
    property int itemDisplayRectWidth: 170
    property int purchasesDisplayRectWidth: Math.round(itemDisplayRectWidth / 1.5)
    property color serialNoTextColor: "#90a4ae"
    property int stockItemsViewWidth: Math.round(width / 1.6)
    property int stockItemsLeftMargin: 10
    property int stockItemsFontSize: 14

    property string selectedStockItemCategory
    property string selectedStockItemName
    property string selectedStockItemSize
    property int selectedStockItemTotalQuantity
    property int selectedStockItemPPU
    property int selectedStockItemTotalCost
    property int selectedStockItemQuantity
    property int selectedItemRemaining
    property int purchasesListTotalCost: 0

    function resetControls()
    {
        availableStockItemCategories.currentIndex = 0
        availableStockItemNames.currentIndex = -1
        availableStockItemSizes.currentIndex = -1
        quantityTextField.clear()
        totalQuantityLabel.text = "0"
        selectedItemTotalCostLabel.text = ""
    }

    function resetPurchasesListModel()
    {
        purchasesListTotalCost = 0
        purchasesTotalCost.text = "Ksh 0"
    }

    ParentModel {
        id: parentStockItemsModel
    }

    RowLayout {
        id: controlsRow
        anchors.top: parent.top
        anchors.topMargin: 20
        width: parent.width
        height: 80

        Label {
            id: selectItemCategoriesComboBoxLabel
            color: "#90a4ae"
            font.pixelSize: 15
            text: "Category"
        }

        ComboBox {
            id: availableStockItemCategories
            anchors.left: selectItemCategoriesComboBoxLabel.right
            anchors.leftMargin: 5
            implicitWidth: 180
            enabled: (currentIndex > -1)
            model: parentStockItemsModel.stockItemCategoriesModel
            onActivated: {
                selectedStockItemCategory = availableStockItemCategories.currentText

                parentStockItemsModel.initStockItemNamesModel(selectedStockItemCategory)
                availableStockItemNames.model = parentStockItemsModel.stockItemNamesModel
                availableStockItemNames.focus = true

                console.log("Category: ", selectedStockItemCategory)
            }

        }

        Label {
            id: stockItemNamesComboBoxLabel
            anchors.left: availableStockItemCategories.right
            anchors.leftMargin: 20
            color: "#90a4ae"
            font.pixelSize: 15
            text: "Items"
        }

        ComboBox {
            id: availableStockItemNames
            anchors.left: stockItemNamesComboBoxLabel.right
            anchors.leftMargin: 5
            implicitWidth: 180
            enabled: (currentIndex > -1)
            onActivated: {
                selectedStockItemName = availableStockItemNames.currentText

                parentStockItemsModel.initStockItemSizesModel(selectedStockItemName)
                availableStockItemSizes.model = parentStockItemsModel.stockItemSizesModel
                availableStockItemSizes.focus = true

                console.log("Item: ", selectedStockItemName)
            }

        }

        Label {
            id: sizeAmountComboBoxLabel
            anchors.left: availableStockItemNames.right
            anchors.leftMargin: 20
            color: "#90a4ae"
            font.pixelSize: 15
            text: "Size/Amount"
        }

        ComboBox {
            id: availableStockItemSizes
            anchors.left: sizeAmountComboBoxLabel.right
            anchors.leftMargin: 5
            implicitWidth: 150
            enabled: (currentIndex > -1)
            onActivated: {
                selectedStockItemSize = availableStockItemSizes.currentText

                selectedStockItemTotalQuantity = parentStockItemsModel.stockItemQuantity(availableStockItemNames.currentText,
                                                                                         availableStockItemSizes.currentText)
                selectedStockItemPPU = parentStockItemsModel.stockItemUnitPrice(availableStockItemNames.currentText,
                                                                                availableStockItemSizes.currentText)

                quantityTextField.clear()
                quantityTextField.focus = true
                totalQuantityLabel.text = ""
                selectedItemTotalCostLabel.text = ""
                totalQuantityLabel.text = String(selectedStockItemTotalQuantity)

                console.log("Item size/value: ", selectedStockItemSize)
            }

        }

        Label {
            id: quantityTextFieldLabel
            anchors.left: availableStockItemSizes.right
            anchors.leftMargin: 20
            color: "#90a4ae"
            font.pixelSize: 15
            text: "Quantity"
        }

        TextField {
            id: quantityTextField
            implicitWidth: 30
            anchors.left: quantityTextFieldLabel.right
            anchors.leftMargin: 5
            placeholderText: "0"
            validator: IntValidator {
                bottom: 0
                top: selectedStockItemTotalQuantity
            }
            onTextChanged: {
                selectedStockItemTotalCost = parseInt(quantityTextField.text) * selectedStockItemPPU
                if ( quantityTextField.text.length > 0 )  {
                    selectedItemTotalCostLabel.text = "Ksh " + selectedStockItemTotalCost
                } else {
                    selectedItemTotalCostLabel.text = "Ksh 0"
                }
                selectedStockItemQuantity = parseInt(quantityTextField.text)
            }
            onAccepted: {
                selectedStockItemTotalCost = parseInt(quantityTextField.text) * selectedStockItemPPU
                selectedStockItemQuantity = parseInt(quantityTextField.text)
            }

        }

        Label {
            id: quantitySeparatorLabel
            anchors.left: quantityTextField.right
            anchors.leftMargin: 5
            color: "#90a4ae"
            font.pixelSize: 15
            text: "/"
        }

        Label {
            id: totalQuantityLabel
            anchors.left: quantitySeparatorLabel.right
            anchors.leftMargin: 5
            font.pixelSize: 15
            text: "0"
        }

        Label {
            id: totalCostLabel
            anchors.left: totalQuantityLabel.right
            anchors.leftMargin: 20
            font.pixelSize: 12
            text: "TOTAL"
        }

        Rectangle {
            id: totalCostRectangle
            anchors.left: totalCostLabel.right
            anchors.leftMargin: 5
            height: 30
            width: 100
            color: "transparent"
            border.width: 1
            border.color: "#90a4ae"
            Label {
                id: selectedItemTotalCostLabel
                anchors.centerIn: parent
                font.pixelSize: 15
            }
        }

        Button {
            id: sellButton
            anchors.left: totalCostRectangle.right
            anchors.leftMargin: 20
            text: "Add to purchases"
            enabled: (parseInt(quantityTextField.text) > 0)
            onClicked: {
                purchasesListTotalCost += selectedStockItemTotalCost

                var purchasesArray = [
                            selectedStockItemName,
                            selectedStockItemSize,
                            selectedStockItemQuantity,
                            selectedStockItemPPU,
                            selectedStockItemTotalCost
                ]

                stockItemsPurchasesList.addNewItem(purchasesArray)
                purchasesTotalCost.text = "Ksh " + purchasesListTotalCost.toString()

                resetControls()
            }
        }
    }

    RowLayout {
        id: titleRow
        anchors.left: parent.left
        anchors.top: controlsRow.bottom
        anchors.topMargin: 30
        width: stockItemsViewWidth
        height: 60

        Label {
            anchors.centerIn: parent
            color: "#f3f3f4"
            font.pixelSize: 25
            text: "Current Stock"
        }
    }

    SellToolBar {
        id: sellToolBarRow
        headerRectWidth: itemDisplayRectWidth
        width: stockItemsViewWidth
        height: 20
        anchors.left: parent.left
        anchors.top: titleRow.bottom
        anchors.topMargin: 20

    }

    ListView {
        id: stockItemsView
        clip: true
        width: stockItemsViewWidth
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.top: sellToolBarRow.bottom
        anchors.topMargin: 20
        anchors.left: parent.left
        model: stockItemsModel
        delegate: stockItemsDelegate
        ScrollBar.vertical: ScrollBar {
            active: true
        }
    }

    Component {
        id: stockItemsDelegate

        Item {
            width: parent.width
            height: 60
            RowLayout {
                height: parent.height - 2
                width: parent.width

                Rectangle {
                    id: itemSerialNoDisplayRect
                    height: parent.height
                    width: Math.round(itemDisplayRectWidth / 5)
                    color: "transparent"
                    anchors.left: parent.left
                    anchors.leftMargin: stockItemsLeftMargin
                    Rectangle {
                        anchors.centerIn: parent
                        height: numberText.font.pixelSize + 10
                        width: numberText.font.pixelSize + 10
                        color: "transparent"
                        border.width: 1
                        border.color: serialNoTextColor
                        Text {
                            id: numberText
                            anchors.centerIn: parent
                            font.pixelSize: stockItemsFontSize
                            color: serialNoTextColor
                            text: String(model.index + 1)
                            wrapMode: Text.WordWrap
                        }
                    }
                }

                Rectangle {
                    id: itemNameDisplayRect
                    height: parent.height
                    width: itemDisplayRectWidth
                    color: "transparent"
                    anchors.left: itemSerialNoDisplayRect.right
                    anchors.leftMargin: Math.round(stockItemsLeftMargin / 2)
                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: stockItemsFontSize
                        color: "#f3f3f4"
                        text: name
                        width: parent.width - stockItemsLeftMargin
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: itemSizeDisplayRect
                    height: parent.height
                    width: Math.round(itemDisplayRectWidth / 2)
                    color: "transparent"
                    anchors.left: itemNameDisplayRect.right
                    anchors.leftMargin: stockItemsLeftMargin
                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: stockItemsFontSize
                        color: "#f3f3f4"
                        text: size
                        width: parent.width - stockItemsLeftMargin
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: itemDescDisplayRect
                    height: parent.height
                    width: itemDisplayRectWidth
                    color: "transparent"
                    anchors.left: itemSizeDisplayRect.right
                    anchors.leftMargin: stockItemsLeftMargin
                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: stockItemsFontSize
                        color: "#f3f3f4"
                        text: description
                        width: parent.width - stockItemsLeftMargin
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: itemBrandDisplayRect
                    height: parent.height
                    width: Math.round(itemDisplayRectWidth / 2)
                    color: "transparent"
                    anchors.left: itemDescDisplayRect.right
                    anchors.leftMargin: stockItemsLeftMargin
                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: stockItemsFontSize
                        color: "#f3f3f4"
                        text: brand
                        width: parent.width - stockItemsLeftMargin
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: itemQtyDisplayRect
                    height: parent.height
                    width: Math.round(itemDisplayRectWidth / 2)
                    color: "transparent"
                    anchors.left: itemBrandDisplayRect.right
                    anchors.leftMargin: stockItemsLeftMargin
                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: stockItemsFontSize
                        color: "#f3f3f4"
                        text: quantity
                        width: parent.width - stockItemsLeftMargin
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: itemCostDisplayRect
                    height: parent.height
                    width: Math.round(itemDisplayRectWidth / 2)
                    color: "transparent"
                    anchors.left: itemQtyDisplayRect.right
                    anchors.leftMargin: stockItemsLeftMargin
                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: stockItemsFontSize
                        color: "#f3f3f4"
                        text: price_per_unit + ".00"
                        width: parent.width - stockItemsLeftMargin
                        wrapMode: Text.WordWrap
                    }
                }
            }

            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: stockItemsLeftMargin
                anchors.rightMargin: 20
                height: 1
                color: "white"
                opacity: 0.5
            }
        }
    }

    RowLayout {
        id: purchasesListRowTitle
        anchors.right: parent.right
        anchors.top: controlsRow.bottom
        anchors.topMargin: 50
        width: parent.width - (stockItemsViewWidth + 20)
        height: 40

        Label {
            id: shoppingCartLabel
            anchors.centerIn: parent
            color: "#f3f3f4"
            font.pixelSize: 20
            text: "Purchases"
        }

        NotificationIcon {
            id: purchasesCount
            x: shoppingCartLabel.x + (shoppingCartLabel.width + 2)
            y: shoppingCartLabel.y
            z: 1
            runTimer: false
            iconSize: 20
            iconBgColor: "#41cd52"
            visible: (stockItemsPurchasesModel.listItemCount > 0)
            notificationNum: String(stockItemsPurchasesModel.listItemCount)
        }

    }

    Rectangle {
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.top: purchasesListRowTitle.bottom
        anchors.topMargin: 20
        width: parent.width - (stockItemsViewWidth + 40)
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        color: Qt.rgba(0, 0, 0, 0.5)

        PurchasesListToolBar {
            id: purchasesListToolBarRow
            headerRectWidth: purchasesDisplayRectWidth
            width: parent.width
            height: 20
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter

        }

        ListView {
            id: purchasesListView
            visible: (stockItemsPurchasesModel.listItemCount > 0)
            width: parent.width
            anchors.top: purchasesListToolBarRow.bottom
            anchors.topMargin: 20
            anchors.bottom: purchasesTotalCostDisplayRect.top
            anchors.bottomMargin: 20
            clip: true
            model: stockItemsPurchasesModel
            delegate: purchasesListDelegate
            ScrollIndicator.vertical: ScrollIndicator {}
        }

//        ListModel {
//            id: purchasesListModel
//        }

        Component {
            id: purchasesListDelegate

            Item {
                width: parent.width
                height: 60

                RowLayout {
                    height: parent.height - 2
                    width: parent.width

                    Rectangle {
                        id: itemNoDisplayRect
                        height: parent.height
                        width: Math.round(purchasesDisplayRectWidth / 5)
                        color: "transparent"
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        Rectangle {
                            anchors.centerIn: parent
                            height: numberText.font.pixelSize + 10
                            width: numberText.font.pixelSize + 10
                            color: "transparent"
                            border.width: 1
                            border.color: serialNoTextColor
                            Text {
                                id: numberText
                                anchors.centerIn: parent
                                font.pixelSize: 14
                                color: serialNoTextColor
                                text: String(index + 1)
                                wrapMode: Text.WordWrap
                            }
                        }
                    }

                    Rectangle {
                        id: itemDisplayRect
                        height: parent.height
                        width: purchasesDisplayRectWidth
                        color: "transparent"
                        anchors.left: itemNoDisplayRect.right
                        anchors.leftMargin: 20
                        Text {
                            anchors.centerIn: parent
                            font.pixelSize: 14
                            color: "#f3f3f4"
                            text: model.itemName + " (" + model.itemSize + ")"
                            width: parent.width - 20
                            wrapMode: Text.WordWrap
                        }
                    }

                    Rectangle {
                        id: itemQDisplayRect
                        height: parent.height
                        width: Math.round(purchasesDisplayRectWidth / 2)
                        color: "transparent"
                        anchors.left: itemDisplayRect.right
                        anchors.leftMargin: 20
                        Text {
                            anchors.centerIn: parent
                            font.pixelSize: 14
                            color: "#f3f3f4"
                            text: model.quantity
                            width: parent.width - 20
                            wrapMode: Text.WordWrap
                        }
                    }

                    Rectangle {
                        id: itemPPUDisplayRect
                        height: parent.height
                        width: Math.round(purchasesDisplayRectWidth / 2)
                        color: "transparent"
                        anchors.left: itemQDisplayRect.right
                        anchors.leftMargin: 20
                        Text {
                            anchors.centerIn: parent
                            font.pixelSize: 14
                            color: "#f3f3f4"
                            text: model.pricePerUnit
                            width: parent.width - 20
                            wrapMode: Text.WordWrap
                        }
                    }

                    Button {
                        id: removePurchasedItemButton
                        text: "Remove"
                        onClicked: {
                            purchasesListTotalCost = purchasesListTotalCost - (stockItemsPurchasesList.getTotalCostAt(index))
                            stockItemsPurchasesList.removeItemAt(index)
                            purchasesTotalCost.text = "Ksh " + purchasesListTotalCost.toString()
                        }
                    }

                }

                Rectangle {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: 20
                    anchors.rightMargin: 20
                    height: 1
                    color: "yellow"
                    opacity: 0.5
                }
            }
        }


        Rectangle {
            id: purchasesTotalCostDisplayRect
            height: 30
            width: parent.width - 40
            anchors.bottom: purchasesListButtons.top
            anchors.bottomMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            color: Qt.rgba(255, 0, 0, 0.3)

            Label {
                id: purchasesTotalCostLabel
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                color: "#f3f3f3"
                text: "TOTAL"
            }

            Label {
                id: purchasesTotalCost
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                color: "#90a4ae"
                text: "Ksh " + purchasesListTotalCost.toString()
            }
        }

        RowLayout {
            id: purchasesListButtons
            spacing: 10
            width: parent.width - 20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom

            Button {
                id: cancelPurchasesButton
                Layout.fillWidth: true
                text: "Cancel"
                onClicked: {
                    if (stockItemsPurchasesModel.listItemCount > 0) {
                        cancelPurchasesDialog.open()
                    } else {
                        console.log("No purchases. Doing nothing.")
                    }
                }
            }

            Button {
                id: okPurchasesButton
                Layout.fillWidth: true
                text: "OK"
                onClicked: {
                    if (stockItemsPurchasesModel.listItemCount > 0)
                    {
                        paymentOptionPopup.open()
                    } else {
                        console.log("No purchases. Doing nothing.")
                    }
                }
            }
        }
    }

    Dialog {
        id: cancelPurchasesDialog
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        width: Math.round(parent.width / 3)
        parent: ApplicationWindow.overlay
        modal: true
        focus: true
        title: "CANCEL PURCHASES?"

        standardButtons: Dialog.No | Dialog.Yes

        Label {
            width: parent.width
            text: qsTr("Are you sure you want to cancel these purchases?\n\n")
                + qsTr("NB: This attempt will still be recorded.")
            wrapMode: Label.Wrap
        }

        onAccepted: {
            resetControls()
            resetPurchasesListModel()
        }
        onRejected: {
            cancelPurchasesDialog.close()
        }
    }

    Dialog {
        id: okPurchasesDialog
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        width: Math.round(parent.width / 3)
        parent: ApplicationWindow.overlay

        modal: true
        title: "TRANSACTION COMPLETED"
        standardButtons: Dialog.Close

        onClosed:  {
            resetControls()
            resetPurchasesListModel()
        }

        Column {
            id: column
            spacing: 20
            width: parent.width

            Image {
                id: logo
                width: parent.width / 2
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
                source: "qrc:/assets/icons/logo2.png"
            }

            Label {
                width: parent.width
                text: "You have sold Ksh " + purchasesListTotalCost.toString()
                    + " worth of items."
                wrapMode: Label.Wrap
            }

            Label {
                width: parent.width
                color: "#90a4ae"
                text: "Thank you for choosing Modio Burn to manage your "
                    + "entertainment business."
                wrapMode: Label.Wrap
            }
        }
    }

    Popup {
        id: paymentOptionPopup
        x: Math.round((mainAppWindow.width / 2) - (width / 2))
        y: Math.round((mainAppWindow.height / 2) - (height / 2))
        closePolicy: "NoAutoClose"

        ColumnLayout {
            spacing: 20

            Label {
                Layout.fillWidth: true
                font.bold: true
                font.pixelSize: 16
                text: "Please select a payment option"
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 20
                Label {
                    text: "Payment Option"
                }
                ComboBox {
                    id: paymentOptionSelector
                    implicitWidth: 200
                    model: parentStockItemsModel.paymentMethodsModel
                }
            }

            RowLayout {
                Layout.fillWidth: true

                Button {
                    Layout.fillWidth: true
                    text: "Close"
                    onClicked: paymentOptionPopup.close()
                }
                Button {
                    Layout.fillWidth: true
                    text: "OK"
                    onClicked: {
                        stockItemsPurchasesList.paymentMethod = paymentOptionSelector.currentText
                        stockItemsPurchasesList.checkoutItems()
                        okPurchasesDialog.open()
                        paymentOptionPopup.close()
                    }
                }
            }
        }
    }
}
