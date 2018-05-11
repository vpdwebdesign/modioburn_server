import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.calendar 1.0

Item {

    RowLayout {
        id: controlsRow
        width: parent.width
        height: 210

        Item {
            implicitWidth: dowRow.width + monthSpinBox.width
            implicitHeight: dateSelectorLabel.height + calendarGrid.height
            anchors.top: parent.top
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter

            Label {
                id: dateSelectorLabel
                anchors.top: parent.top
                horizontalAlignment: Label.AlignHCenter
                width: parent.width
                color: "#dbdee0"
                font.pixelSize: 20
                text: "Select date"
            }

            ColumnLayout {
                id: monthYearControls
                anchors.left: parent.left
                anchors.verticalCenter: calendarGrid.verticalCenter

                SpinBox {
                    id: yearSpinBox
                    Layout.fillWidth: true
                    from: 0
                    to: years.length - 1
                    value: years.length -1

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

                SpinBox {
                    id: monthSpinBox
                    Layout.fillWidth: true
                    from: 0
                    to: months.length - 1
                    value: 8

                    property var months: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

    //                     validator: RegExpValidator {
    //                         regExp: new RegExp("(Small|Medium|Large)", "i")
    //                     }

                    textFromValue: function(value) {
                        return months[value];
                    }

                    valueFromText: function(text) {
                        for (var i = 0; i < months.length; ++i) {
                            if (months[i].toLowerCase().indexOf(text.toLowerCase()) === 0)
                                return i
                        }
                        return monthSpinBox.value
                    }
                 }
            }

            ColumnLayout {
                id: calendarGrid
                anchors.top: dateSelectorLabel.bottom
                anchors.topMargin: 10
                anchors.right: parent.right

                DayOfWeekRow {
                    id: dowRow
                    locale: monthGrid.locale
                    Layout.fillWidth: true

                    delegate: Text {
                        color: model.shortName.toLowerCase() === "sun" ? "#80cbc4" : "#eeeeee"
                        text: model.shortName
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                      }
                }

                MonthGrid {
                    id: monthGrid
                    locale: Qt.locale("en_US")
                    year: parseInt(yearSpinBox.years[yearSpinBox.value])
                    month: monthSpinBox.value
                    Layout.fillWidth: true

                    delegate: Text {
                          horizontalAlignment: Text.AlignHCenter
                          verticalAlignment: Text.AlignVCenter
                          opacity: model.month === monthGrid.month ? 1.0 : 0.3
                          font.pixelSize: monthGridMouseArea.containsMouse ? 20: 15
                          text: model.day
                          color: model.today ? "red" : "white"

                          MouseArea {
                              id: monthGridMouseArea
                              anchors.fill: parent
                              hoverEnabled: true
                              onClicked: function() {
                                  var selectedDateString = model.date;
                                  selectedDate.text = selectedDateString.toLocaleString(Qt.locale(), "dd.MM.yyyy");
                              }
                          }
                      }
                }
            }

        }
    }

    RowLayout {
        id: selectedDateRow
        width: parent.width
        height: 50
        anchors.top: controlsRow.bottom
        anchors.topMargin: 50

        Item {
            implicitWidth: selectedDateLabel.width + selectedDateRectangle.width + 15
            anchors.centerIn: parent

            Label {
                id: selectedDateLabel
                font.pixelSize: 18
                text: "Selected Date"
                anchors.verticalCenter: selectedDateRectangle.verticalCenter
            }

            Rectangle {
                id: selectedDateRectangle
                height: 40
                width: 200
                anchors.left: selectedDateLabel.right
                anchors.leftMargin: 10
                color: "transparent"
                border.width: 0.5
                border.color: "#6e6e6e"

                Label {
                    id: selectedDate
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
        anchors.top: selectedDateRow.bottom
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
