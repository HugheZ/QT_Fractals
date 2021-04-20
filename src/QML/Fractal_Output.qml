import QtQuick 2.0
import QtQuick3D 1.15

Item {
    id: fractalViewer

    Rectangle {
        color: "#FFFFFF"
        anchors.fill: parent
    MouseArea {
        id: clickableWrapper
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton

        onClicked: {
            console.log("Clicked")
        }

        onPositionChanged: {
            console.log("X: {" + clickableWrapper.mapFromItem(toLocalPmouseX,mouseY) + "}")
        }

        FractalScene {
            id:viewThreeD
            anchors.fill: parent
        }
    }
    }



    Rectangle {
        id: disabledBlocker
        x: 220
        y: 140
        width: 200
        height: 200
        visible: false
        color: "#868686"
        //anchors.fill: parent

        Text {
            id: disabledPrompt
            font.pixelSize: 12
            anchors.fill: parent
            color: "#6b5d5d"
            text: qsTr("No Fractal Selected")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.bold: true
        }
    }

    states: [
        State {
            name: "DISABLED"
            when: !fractalViewer.enabled

            PropertyChanges {
                target: disabledBlocker
                visible: true
            }

            PropertyChanges {
                target: viewThreeD
                visible: false
            }

        },
        State {
            name: "ENABLED"
            when: fractalViewer.enabled

            PropertyChanges {
                target: disabledBlocker
                visible: false
            }

            PropertyChanges {
                target: viewThreeD
                visible: true
            }

        }

    ]

}
