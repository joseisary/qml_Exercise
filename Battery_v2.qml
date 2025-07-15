import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: batteryWidget
    width: 80
    height: 200

    readonly property int c_CHARGE_RATIO: 3
    readonly property int c_CHARGE_FULL: 100
    readonly property int c_CHARGE_BUTTOM: 0
    readonly property int c_RECTANGLE_RADIOS: 8

    // Charge value from 0 to 100
    property int charge: 80

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

    Rectangle {
        id: batteryBorder
        width: parent.width
        height: parent.height
        radius: c_RECTANGLE_RADIOS
        anchors.centerIn: parent
        color: "transparent"
        border.color: "gray"
        border.width: 2
        opacity: m_opacity
        clip: true
        z: 5

        Text {
            id: displayCharge
            text: qsTr(Math.round(charge) + " %")
            anchors.centerIn: parent
        }

        Rectangle {
            id: batteryFill
            width: batteryBorder.width
            radius: c_RECTANGLE_RADIOS
            anchors.bottom: batteryBorder.bottom
            color: fillColor

            // Smooth width animation when charge changes
            Behavior on height {
                NumberAnimation {
                    duration: 100
                    easing.type: Easing.InOutQuad
                }
            }
            height: (batteryWidget.charge / 100) * batteryWidget.height
        }
    }

    Rectangle {
        id: positivePole
        width: batteryBorder.width / 2
        height: 10
        radius: c_RECTANGLE_RADIOS
        color: "gray"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: batteryBorder.top
        anchors.bottomMargin: 1
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Up || event.key === Qt.Key_Plus) {
            if (charge <= c_CHARGE_FULL)
                charge += c_CHARGE_RATIO
            charge = charge > c_CHARGE_FULL ? c_CHARGE_FULL : charge
            displayCharge.text = qsTr(Math.round(charge) + " %")
            event.accepted = true
        }
        if (event.key === Qt.Key_Down || event.key === Qt.Key_Minus) {
            if (charge => c_CHARGE_BUTTOM)
                charge -= c_CHARGE_RATIO
            charge = charge < c_CHARGE_BUTTOM ? c_CHARGE_BUTTOM : charge
            displayCharge.text = qsTr(Math.round(charge) + " %")
            event.accepted = true
        }
    }

    focus: true
}
