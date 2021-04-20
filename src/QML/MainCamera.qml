import QtQuick 2.0
import QtQuick3D 1.15

Node{
    id: cams
    property alias camera: camPerspective

    PerspectiveCamera{
        id: camPerspective
        z: 600
        x: 300
        y: 200
        eulerRotation: Qt.vector3d(-20.0, 20.0, 0.0)
    }
}
