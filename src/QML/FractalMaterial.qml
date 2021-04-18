import QtQuick 2.0
import QtQuick3D 1.15

Item {
    id:fractalMat

    CustomMaterial{
        //Example properties, here for reference. Throw uniforms for controls like so
        //property real time: 0.0
        //property real amplitude: 5.0

        vertexShader: "src/QML/fractal.vert"
        fragmentShader: "src/QML/fractal.frag"
    }
}
