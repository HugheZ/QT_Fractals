import QtQuick 2.0
import QtQuick3D 1.15

View3D {
    id: viewThreeD
    importScene: rootScene
    camera: camPerspective

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
}
