import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15

ApplicationWindow {
    id: mainWindow
    width: 640
    height: 480
    visible: true
    title: "QT Fractals"

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

    Fractal_Output {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: mainMenu.bottom
        anchors.bottom: parent.bottom
        enabled: true
    }







}
