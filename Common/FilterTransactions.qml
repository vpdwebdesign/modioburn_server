import QtQuick 2.9
import QtQuick.Controls 2.2

ComboBox {
    property int comboBoxImplicitWidth
    property var optionsList

    implicitWidth: comboBoxImplicitWidth
    model: optionsList
}




