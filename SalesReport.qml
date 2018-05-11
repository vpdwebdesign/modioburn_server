import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.calendar 1.0

import "Common"
import "Common/Dialogs"

Pane {

    property string pageTitle: "Sales Report"

    RowLayout {
        id: reportTypeRow
        width: parent.width
        height: 60
        anchors.top: parent.top

        SortReportType {
            anchors.centerIn: parent
            sortLabelText: "Type"
            comboBoxWidth: 120
            optionsList: ["Movies", "Series", "Music", "Games", "Others"]
        }
    }

    RowLayout {
        id: durationTypeRow
        width: parent.width
        height: 30
        anchors.top: reportTypeRow.bottom

        Item {
            width: Math.round(parent.width / 2.5)
            anchors.centerIn: parent

            RadioButton {
                id: dailyOptionButton
                anchors.left: parent.left
                checked: true
                text: "Daily"
            }

            RadioButton {
                id: weeklyOptionButton
                anchors.left: dailyOptionButton.right
                anchors.leftMargin: 10
                text: "Weekly"
            }

            RadioButton {
                id: monthlyOptionButton
                anchors.left: weeklyOptionButton.right
                anchors.leftMargin: 10
                text: "Monthly"
            }

            RadioButton {
                id: yearlyOptionButton
                anchors.left: monthlyOptionButton.right
                anchors.leftMargin: 10
                text: "Yearly"
            }

            RadioButton {
                id: customPeriodOptionButton
                anchors.left: yearlyOptionButton.right
                anchors.leftMargin: 10
                text: "Custom Period"
                onClicked: notYet.open()
            }
        }
    }

    DailySalesReportControl {
        width: parent.width
        height: 450
        anchors.top: durationTypeRow.bottom
        anchors.topMargin: 30
        visible: dailyOptionButton.checked
    }

    WeeklySalesReportControl {
        width: parent.width
        height: 450
        anchors.top: durationTypeRow.bottom
        anchors.topMargin: 30
        visible: weeklyOptionButton.checked
    }

    MonthlySalesReportControl {
        width: parent.width
        height: 450
        anchors.top: durationTypeRow.bottom
        anchors.topMargin: 30
        visible: monthlyOptionButton.checked
    }

    YearlySalesReportControl {
        width: parent.width
        height: 450
        anchors.top: durationTypeRow.bottom
        anchors.topMargin: 30
        visible: yearlyOptionButton.checked
    }
}
