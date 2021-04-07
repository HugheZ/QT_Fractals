import QtQuick 2.0


Item {
    id: view_three_d

    Rectangle {
        id: disabledblocker
        x: 220
        y: 140
        width: 200
        height: 200
        visible: false
        color: "#ffffff"
        anchors.top: parent.top;
        anchors.left: parent.left;
        anchors.right: parent.right;
        anchors.bottom: parent.bottom;

        Text {
            id: disabledprompt
            text: qsTr("Text")
            font.pixelSize: 12
            anchors.top: parent.top;
            anchors.left: parent.left;
            anchors.right: parent.right;
            anchors.bottom: parent.bottom;
        }
    }
    states: [
        State {
            name: "DISABLED"
            when: !view_three_d.enabled

            PropertyChanges {
                target: disabledblocker
                x: 0
                y: 0
                width: 640
                height: 480
                visible: true
                color: "#8e8686"
                clip: false
            }

            PropertyChanges {
                target: disabledprompt
                x: 252
                y: 195
                width: 136
                height: 90
                visible: true
                color: "#6b5d5d"
                text: qsTr("No Fractal Selected")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: "true"
            }
        }
    ]

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
