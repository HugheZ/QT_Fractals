import QtQuick 2.0
import QtQuick3D

Item {
    id: fractal_component

    View3D{
        id: view_three_d
    }

    Rectangle {
        id: disabledblocker
        x: 220
        y: 140
        width: 200
        height: 200
        visible: false
        color: "#868686"
        anchors.fill: parent

        Text {
            id: disabledprompt
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
            when: !fractal_component.enabled

            PropertyChanges {
                target: disabledblocker
                visible: true
            }

            PropertyChanges {
                target: view_three_d
                visible: false
            }

        },
        State {
            name: "ENABLED"
            when: fractal_component.enabled

            PropertyChanges {
                target: disabledblocker
                visible: false
            }

            PropertyChanges {
                target: view_three_d
                visible: true
            }

        }

    ]

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
