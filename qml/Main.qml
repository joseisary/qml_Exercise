import QtQuick.Controls

ApplicationWindow {
    id: root
    color: "#2e2e2e"
    width: 1080
    height: 720
    visible: true
    title: qsTr("Capgemini QML Demo")

     Speedometer_Entry {
        anchors.centerIn: parent
        width: 400
        height: 400
    }
}
