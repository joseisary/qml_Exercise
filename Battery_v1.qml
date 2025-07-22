import QtQuick
import capgemini.com

Item {
    id: root
    width: 80
    height: 200
    objectName: "root"

    readonly property int  c_RECTANGLE_RADIOS: 8
    readonly property real c_OPACITY: 0.5
    property color color_level_0_5: "red"
    property color color_level_5_20: "orange"
    property color color_level_20_45: "yellow"
    property color color_level_45_100: "green"
    property color color_level_default: color_level_0_5

    property int charge: bkBattery.charge
    property color fillColor: color_level_default

    Component.onCompleted: {
        root.focus = true;
    }

    IOBattery {
        id: bkBattery
        onChargeChanged: {
            console.log("Charge changed to: " + bkBattery.charge);
        }
        onChargeLevelChanged: function (level) {
            if (level === IOBattery.CHARGE_LEVEL_0_5) {
                root.fillColor = root.color_level_0_5;
            } else if (level === IOBattery.CHARGE_LEVEL_5_20) {
                root.fillColor = root.color_level_5_20;
            } else if (level === IOBattery.CHARGE_LEVEL_20_45) {
                root.fillColor = root.color_level_20_45;
            } else if (level === IOBattery.CHARGE_LEVEL_45_100) {
                root.fillColor = root.color_level_45_100;
            }
        }
    }//bkBattery

    Rectangle {
        id: batteryBorder
        width: parent.width
        height: parent.height
        radius: root.c_RECTANGLE_RADIOS
        anchors.centerIn: parent
        color: "transparent"
        border.color: "gray"
        border.width: 2
        opacity: root.c_OPACITY
        clip: true

        Rectangle {
            id: batteryFill
            width: batteryBorder.width
            radius: root.c_RECTANGLE_RADIOS
            anchors.bottom: batteryBorder.bottom
            color: root.fillColor
            border.color: Qt.lighter(color)
            border.width: 2
            opacity: root.c_OPACITY

            // Smooth width animation when charge changes
            Behavior on height {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
            height: (root.charge / 100) * root.height
        }
    }//batteryBorder

    Text {
        id: displayCharge
        text: qsTr(Math.round(root.charge) + " %")
        anchors.centerIn: parent
        color: "gray"
        font.pixelSize: 24 * (3 / 4)
        font.bold: true
    }

    Rectangle {
        id: positivePole
        width: batteryBorder.width / 2
        height: 10
        radius: root.c_RECTANGLE_RADIOS
        color: "transparent"
        border.color: "gray"
        border.width: 2
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: batteryBorder.top
            bottomMargin: 1
        }
    }

//------------------------------------------------------------//
// Keys inputs for battery charge
//------------------------------------------------------------//

    Keys.onUpPressed: {
        let newCharge = root.charge + 10;
        bkBattery.updateCharge(newCharge);
    }

    Keys.onDownPressed: {
        let newCharge = root.charge - 10;
        bkBattery.updateCharge(newCharge);
    }
}
