import QtQuick

Item {
    id: root
    anchors.fill: parent
    focus: true

    readonly property int c_STEP_RATIO: 1

    property bool accelerating: false

    Speedometer {
        id: speedometer
        anchors.centerIn: parent
        width: 400
        height: 400
        focus: true
        value: 0
    }

    Timer {
        id: accelTimer
        interval: 50
        repeat: true
        running: true
        onTriggered: {
            if (root.accelerating && speedometer.value < speedometer.c_MAX_VALUE) {
                speedometer.value += root.c_STEP_RATIO;
            }
        }
    }

    property real decelSpeed: 10
    // Speed at which the speedometer decelerates
    // in units per second. i.e: if speed is 120  and deceSpeed is 1, then
    //it will take 120 seconds to reach 0.
    //if speed is 120 and decelSpeed is 10, then it will take 12 seconds to reach 0
    NumberAnimation {
        id: decelAnim
        target: speedometer
        property: "value"
        duration: {
            const distance = Math.abs(speedometer.value - speedometer.c_MIN_VALUE);
            let duration = Math.abs(distance / (root.decelSpeed / 1000));
            return duration;
        }
        to: speedometer.c_MIN_VALUE
        easing.type: Easing.OutCubic
    }

    Keys.onPressed: function (event) {
        if (event.key === Qt.Key_Up) {
            if (!accelerating) {
                accelerating = true;
                decelAnim.stop();
                root.decelSpeed = 10; // Reset deceleration speed
            }
            event.accepted = true;
        } else if (event.key === Qt.Key_Down) {
            root.decelSpeed = root.decelSpeed + 10; // Increase deceleration speed
            accelerating = false;
            decelAnim.restart();
            console.log("Deceleration speed increased to: " + root.decelSpeed);
            event.accepted = true;
        }
    }

    Keys.onReleased: function (event) {
        if (event.key === Qt.Key_Up) {
            accelerating = false;
            decelAnim.start();
            event.accepted = true;
        }
    }

    //-----------------------------------------------//
    // states and transitions area
    // -----------------------------------------------//
    states: [
        State {
            name: "lOW_SPEED"
            when: speedometer.value < 60
            PropertyChanges {
                target: speedometer
                progressColor: "#50FA7B" // Green for low speed
            }
        },
        State {
            name: "HALF_SPEED"
            when: speedometer.value >= 60 && speedometer.value < 120
            PropertyChanges {
                target: speedometer
                progressColor: "#fb8601" // Orange for half speed
            }
        },
        State {
            name: "HIGH_SPEED"
            when: speedometer.value >= 120 && speedometer.value < 180
            PropertyChanges {
                target: speedometer
                progressColor: "#ff2626" // Red for full speed
            }
        },
        State {
            name: "HIGH_SPEED_CRITICAL"
            when: speedometer.value >= 180
        },
        State {
            name: "STOPPED_SPEED"
            when: speedometer.value === speedometer.c_MIN_VALUE
        }
    ]



    transitions: [
        Transition {
            from: "HIGH_SPEED"
            to: "HIGH_SPEED_CRITICAL"
            SequentialAnimation {
                loops: Animation.Infinite

                PropertyAnimation {
                    target: speedometer
                    property: "progressColor"
                    from: "transparent"
                    to: "#ff1a1a"
                    duration: 300
                    easing.type: Easing.InOutQuad
                }

                PropertyAnimation {
                    target: speedometer
                    property: "progressColor"
                    from: "#ff1a1a"
                    to: "transparent"
                    duration: 300
                    easing.type: Easing.InOutQuad
                }
            }
        }
    ]
}// root

