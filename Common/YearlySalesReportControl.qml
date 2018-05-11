import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.calendar 1.0

Item {


    RowLayout {
        id: controlsRow
        width: parent.width
        height: 150

        Item {
            implicitWidth: dateSelectorLabel.width
            implicitHeight: dateSelectorLabel.height + yearSpinBox.height
            anchors.top: parent.top
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter

            Label {
                id: dateSelectorLabel
                anchors.top: parent.top
                horizontalAlignment: Label.AlignHCenter
                color: "#dbdee0"
                font.pixelSize: 20
                text: "Select Year"
            }

            SpinBox {
                id: yearSpinBox
                anchors.top: dateSelectorLabel.bottom
                anchors.topMargin: 10
                anchors.horizontalCenter: dateSelectorLabel.horizontalCenter
                from: 0
                to: years.length - 1
                value: years.length -1
                onValueChanged: selectedYear.text = yearSpinBox.years[value]

                property var years: ["2015", "2016", "2017"]

                textFromValue: function(value) {
                    return years[value];
                }

                valueFromText: function(text) {
                    for (var i = 0; i < years.length; ++i) {
                        if (years[i].toLowerCase().indexOf(text.toLowerCase()) === 0)
                            return i;
                    }
                    return yearSpinBox.value;
                }
            }

        }
    }

    RowLayout {
        id: selectedYearRow
        width: parent.width
        height: 50
        anchors.top: controlsRow.bottom
        anchors.topMargin: 30

        Item {
            implicitWidth: selectedYearLabel.width + selectedYearRectangle.width + 15
            anchors.centerIn: parent

            Label {
                id: selectedYearLabel
                font.pixelSize: 18
                text: "Selected Year"
                anchors.verticalCenter: selectedYearRectangle.verticalCenter
            }

            Rectangle {
                id: selectedYearRectangle
                height: 40
                width: 200
                anchors.left: selectedYearLabel.right
                anchors.leftMargin: 10
                color: "transparent"
                border.width: 0.5
                border.color: "#6e6e6e"

                Label {
                    id: selectedYear
                    anchors.centerIn: parent
                    font.pixelSize: 16
                    color: "#80cbc4"
                }
            }
        }
    }

    RowLayout {
        id: extraOptionsRow
        width: parent.width
        height: 30
        anchors.top: selectedYearRow.bottom
        anchors.topMargin: 30

        Item {
            implicitWidth: excludeDeletedItems.width + generateGraph.width + 15
            anchors.centerIn: parent

            CheckBox {
                id: excludeDeletedItems
                text: "Exclude deleted items"
            }

            CheckBox {
                id: generateGraph
                anchors.left: excludeDeletedItems.right
                anchors.leftMargin: 10
                text: "Generate graph"
            }
        }
    }

    Button {
        anchors.top: extraOptionsRow.bottom
        anchors.topMargin: 40
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Get Report"
        onClicked: notYet.open()
    }
}
