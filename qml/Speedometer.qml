pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

Item {
    id: root
    readonly property int c_MIN_VALUE: 0
    readonly property int c_MAX_VALUE: 220
    property alias value: cirSlider.value
    property alias progressColor: cirSlider.progressColor

    Rectangle {
        anchors.fill: parent
        radius: 10
        antialiasing: true
        color: "#2e2e2e"
        Speedometer_CirSlider {
            id: cirSlider
            anchors.centerIn: parent
            width: 300
            height: 300
            startAngle: 40
            endAngle: 320
            rotation: 180
            trackWidth: 5
            progressWidth: 20
            progressColor: "#50FA7B"
            minValue: root.c_MIN_VALUE
            maxValue: root.c_MAX_VALUE
            opacity_progress: 0.3
            capStyle: Qt.FlatCap

            handle: Rectangle {
                id: handleRect
                transform: Translate {
                    id: handleTranslate
                    x: (cirSlider.handleWidth - handleRect.width) / 2
                    y: cirSlider.handleHeight / 2
                }

                width: 6
                height: cirSlider.height / 4
                color: "#FFac89"
                radius: width / 2
                antialiasing: true
            }

            Label {
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -40
                rotation: 180
                font.pointSize: 26
                color: "#FEFEFE"
                text: Number(cirSlider.value).toFixed()
            }
        }// Speedometer_CirSlider

        Label {
            anchors.top: cirSlider.bottom
            anchors.topMargin: -75
            x: cirSlider.x + cirSlider.width / 2 - width / 2
            color: "white"
            font.pixelSize: 20
            font.bold: true
            property bool isMph: true

            text: isMph ? "km/h" : "mph"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (parent.isMph) parent.isMph = false;
                    else              parent.isMph = true;
                }
            }
        }

        /// Numbers
        Label {
            text: "110"
            color: "#fefefe"
            font.pointSize: 16
            anchors.bottom: cirSlider.top
            anchors.bottomMargin: 10
            x: cirSlider.x + cirSlider.width / 2 - width / 2
        }

        Label {
            text: "180"
            color: "#fefefe"
            font.pointSize: 16
            anchors.left: cirSlider.right
            anchors.leftMargin: 10
            y: cirSlider.y + cirSlider.height / 2 - height / 2
        }

        Label {
            text: "40"
            color: "#fefefe"
            font.pointSize: 16
            anchors.right: cirSlider.left
            anchors.rightMargin: 10
            y: cirSlider.y + cirSlider.height / 2 - height / 2
        }
    }
}
