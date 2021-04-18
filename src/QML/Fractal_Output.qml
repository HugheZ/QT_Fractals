import QtQuick 2.0
import QtQuick3D 1.15

Item {
    id: fractalViewer

    Node{
        id: rootScene

        //Model, for testing purposes
        Node{
            id: models
            Model {
                source: "#Cube"
                position: Qt.vector3d(0,0,0)
                scale: Qt.vector3d(3,3,3)
                materials: [
                    //FractalMaterial{}
                    PrincipledMaterial{
                        baseColor: "#41cd52"
                        metalness: 0.0
                        roughness: 0.1
                        opacity: 1.0
                    }

                ]
            }
        }

        //Lights
        Node{
            id: lights
            DirectionalLight{
                ambientColor: Qt.rgba(1.0,1.0,1.0,1.0)
                brightness: 1.0
                eulerRotation.x: -25
            }
        }

        //Camera
        Node{
            id: cams
            PerspectiveCamera{
                id: camPerspective
                z: 600
                x: 300
                y: 200
                eulerRotation: Qt.vector3d(-20.0, 20.0, 0.0)
            }
        }

    }

    View3D {
        id: viewThreeD
        anchors.fill: parent
        importScene: rootScene
        camera: camPerspective
    }

    Rectangle {
        id: disabledBlocker
        x: 220
        y: 140
        width: 200
        height: 200
        visible: false
        color: "#868686"
        anchors.fill: parent

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

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
