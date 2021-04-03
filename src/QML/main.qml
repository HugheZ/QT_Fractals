import QtQuick 2.12
import QtQuick.Window 2.12
import Qt3D.Core 2.14
import QtQuick.Dialogs.qml 1.0
import QtQuick.Extras 1.4
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.0

Window {
    id: mainWindow
    width: 640
    height: 480
    visible: true
    title: "QT Fractals"

    Row {
        id: mainSetup
        anchors.fill: parent

        MenuBar {
            id: mainMenu
            height: 40
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 0
            font.pointSize: 8
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            Menu {
                title: qsTr("&File")
                Action { text: qsTr("&Open...") }
                MenuSeparator { }
                Action { text: qsTr("&Quit") }
            }
            Menu {
                title: qsTr("&Controls")
                Action { text: qsTr("&Cut") }
                Action { text: qsTr("&Copy") }
                Action { text: qsTr("&Paste") }
            }
            Menu {
                title: qsTr("&Help")
                Action { text: qsTr("&About") }
            }
        }

        GridView {
            id: mainUI
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: mainMenu.bottom
            anchors.bottom: parent.bottom
            anchors.rightMargin: 2
            anchors.bottomMargin: 2
            anchors.leftMargin: 2
            anchors.topMargin: 2
            cellHeight: 70
            model: ListModel {
                ListElement {
                    name: "Grey"
                    colorCode: "grey"
                }

                ListElement {
                    name: "Red"
                    colorCode: "red"
                }

                ListElement {
                    name: "Blue"
                    colorCode: "blue"
                }

                ListElement {
                    name: "Green"
                    colorCode: "green"
                }
            }
            cellWidth: 70
            delegate: Item {
                x: 5
                height: 50
                Column {
                    Rectangle {
                        width: 40
                        height: 40
                        color: colorCode
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        x: 5
                        text: name
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.bold: true
                    }
                    spacing: 5
                }
            }
        }
    }

}
