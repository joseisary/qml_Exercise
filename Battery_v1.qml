import QtQuick
import capgemini.com

Item {
    id: root
    width: 80
    height: 200
    objectName: "root"

    readonly property int c_RECTANGLE_RADIOS: 8

    // Charge value from 0 to 100
    property int charge: bkBattery.charge

    property color color_level_0_5: "red"
    property color color_level_5_20: "orange"
    property color color_level_20_45: "yellow"
    property color color_level_45_100: "green"
    property real m_opacity: 0.5

    // Determines color based on charge
    property color fillColor: {
        if (charge <= 5)
            return color_level_0_5
        else if (charge <= 20)
            return color_level_5_20
        else if (charge <= 45)
            return color_level_20_45
        else
            return color_level_45_100
    }
    Component.onCompleted: {
        root.focus = true;
        bkBattery.installOn(root);
    }

    IOBattery {
        id: bkBattery
        onChargeChanged: {
            console.log("Charge changed to: " + bkBattery.charge);
        }
    }

    Rectangle {
        id: batteryBorder
        width: parent.width
        height: parent.height
        radius: root.c_RECTANGLE_RADIOS
        anchors.centerIn: parent
        color: "transparent"
        border.color: "gray"
        border.width: 2
        opacity: root.m_opacity
        clip: true

        Text {
            id: displayCharge
            text: qsTr(Math.round(root.charge) + " %")
            anchors.centerIn: parent
        }

        Rectangle {
            id: batteryFill
            width: batteryBorder.width
            radius: root.c_RECTANGLE_RADIOS
            anchors.bottom: batteryBorder.bottom
            color: root.fillColor
            border.color: Qt.lighter(color)
            border.width: 2
            // Smooth width animation when charge changes
            Behavior on height {
                NumberAnimation {
                    duration: 100
                    easing.type: Easing.InOutQuad
                }
            }
            height: (root.charge / 100) * root.height
        }
    }

    Rectangle {
        id: positivePole
        width: batteryBorder.width / 2
        height: 10
        radius: root.c_RECTANGLE_RADIOS
        color: "gray"
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: batteryBorder.top
            bottomMargin: 1
        }
    }

}
