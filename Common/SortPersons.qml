import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

RowLayout {

    property alias comboBoxWidth: sortMenu.implicitWidth
    property var optionsList

    height: parent.height
    spacing: 20

    Label {
        id: sortLabel
        text: "View"
    }

    ComboBox {
        id: sortMenu
        model: optionsList
    }
}


