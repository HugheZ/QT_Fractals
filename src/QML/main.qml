import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15

ApplicationWindow {
    id: mainWindow
    width: 640
    height: 480
    visible: true
    title: "QT Fractals"
    minimumHeight: 300
    minimumWidth: 600

    MenuBar {
        id: mainMenu
        height: 30
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

    Rectangle{
        id:controls
        color:"#AAAAAA"

        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        width: scaler(.2, 200)
    }

    //container div
    Fractal_Output {
        id:fractalOut

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: scaler(.8, 400)
    }

    function scaler(per, min){
      var w = mainWindow.width * per;
      return w < min ? min : w;
    }



}
