// GamerX OS · SDDM greeter
// One QML file: aurora animated background + clock + user picker + password.
// Background mode is chosen via theme.conf:
//   aurora — animated procedural gradient (default)
//   image  — background.png
//   video  — background.mp4
//   gif    — background.gif (treated as image; static frame)

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtMultimedia
import SddmComponents 2.0

Rectangle {
    id: root
    width: 1920
    height: 1080
    color: "#0A0E1A"

    // ---------- Palette (defaults; can be overridden by ConfigFile) -------
    readonly property color cBg:        "#0A0E1A"
    readonly property color cBgAlt:     "#11162A"
    readonly property color cSurface:   "#1B2241"
    readonly property color cFg:        "#E6EAF8"
    readonly property color cFgDim:     "#8A93B8"
    readonly property color cAccent:    "#7C3AED"
    readonly property color cAccentAlt: "#00D9FF"
    readonly property color cHighlight: "#FF2EC4"
    readonly property color cBorder:    "#2A3158"
    readonly property color cError:     "#FF5C7C"

    readonly property string mode: config.backgroundMode || "aurora"

    LayoutMirroring.enabled: Qt.application.layoutDirection === Qt.RightToLeft

    // ===== Background =====================================================
    Loader {
        id: bgLoader
        anchors.fill: parent
        sourceComponent: {
            switch (root.mode) {
            case "video": return videoBg
            case "image": return imageBg
            case "gif":   return imageBg
            default:      return auroraBg
            }
        }
    }

    Component {
        id: imageBg
        Image {
            source: "background.png"
            fillMode: Image.PreserveAspectCrop
            asynchronous: true
        }
    }

    Component {
        id: videoBg
        Item {
            MediaPlayer {
                id: mp
                source: "background.mp4"
                loops: MediaPlayer.Infinite
                autoPlay: true
                muted: true
                videoOutput: vo
            }
            VideoOutput {
                id: vo
                anchors.fill: parent
                fillMode: VideoOutput.PreserveAspectCrop
            }
        }
    }

    // Procedural aurora — three slowly drifting radial gradients.
    Component {
        id: auroraBg
        Item {
            Rectangle { anchors.fill: parent; color: root.cBg }

            Rectangle {
                id: cloud1
                width: parent.width * 1.4
                height: parent.height * 1.4
                anchors.centerIn: parent
                radius: width / 2
                opacity: 0.45
                gradient: Gradient {
                    GradientStop { position: 0.0; color: root.cAccent }
                    GradientStop { position: 1.0; color: "transparent" }
                }
                NumberAnimation on x { from: -width*0.2; to: -width*0.05; duration: 14000; loops: Animation.Infinite; easing.type: Easing.InOutQuad }
            }
            Rectangle {
                width: parent.width
                height: parent.height
                anchors.centerIn: parent
                radius: width / 2
                opacity: 0.35
                gradient: Gradient {
                    GradientStop { position: 0.0; color: root.cHighlight }
                    GradientStop { position: 1.0; color: "transparent" }
                }
                NumberAnimation on y { from: 100; to: -100; duration: 12000; loops: Animation.Infinite; easing.type: Easing.InOutSine }
            }
            Rectangle {
                width: parent.width * 0.8
                height: parent.height * 0.8
                x: parent.width * 0.55
                y: parent.height * 0.10
                radius: width / 2
                opacity: 0.30
                gradient: Gradient {
                    GradientStop { position: 0.0; color: root.cAccentAlt }
                    GradientStop { position: 1.0; color: "transparent" }
                }
                NumberAnimation on opacity { from: 0.20; to: 0.45; duration: 4500; loops: Animation.Infinite; easing.type: Easing.InOutSine }
            }
        }
    }

    // ===== Branding (top center) ==========================================
    ColumnLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 90
        spacing: 4

        Text {
            text: "GamerX OS"
            color: root.cFg
            font.pixelSize: 38
            font.bold: true
            font.letterSpacing: -1
            Layout.alignment: Qt.AlignHCenter
        }
        Text {
            text: "the agentic Arch"
            color: root.cFgDim
            font.pixelSize: 14
            font.letterSpacing: 2
            Layout.alignment: Qt.AlignHCenter
        }
    }

    // ===== Clock (large, top-third) =======================================
    Text {
        id: clock
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.22
        color: root.cFg
        font.pixelSize: 96
        font.bold: true
        font.family: "Inter"
        text: Qt.formatDateTime(new Date(), "HH:mm")
        layer.enabled: true
    }
    Text {
        anchors.horizontalCenter: clock.horizontalCenter
        anchors.top: clock.bottom
        anchors.topMargin: 4
        color: root.cFgDim
        font.pixelSize: 16
        text: Qt.formatDate(new Date(), "dddd, d MMMM")
    }
    Timer {
        interval: 1000; running: true; repeat: true
        onTriggered: clock.text = Qt.formatDateTime(new Date(), "HH:mm")
    }

    // ===== Greet ==========================================================
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.50
        color: root.cAccentAlt
        font.pixelSize: 14
        font.weight: Font.Medium
        text: (config.greetText || "Welcome.") + (userModel.lastUser ? "  " + userModel.lastUser : "")
    }

    // ===== Login form =====================================================
    Rectangle {
        id: card
        width: 380
        height: 260
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.55
        radius: 16
        color: Qt.rgba(root.cBgAlt.r, root.cBgAlt.g, root.cBgAlt.b, 0.78)
        border.color: root.cBorder
        border.width: 1

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 18
            spacing: 12

            ComboBox {
                id: userBox
                Layout.fillWidth: true
                model: userModel
                textRole: "name"
                currentIndex: userModel.lastIndex
                background: Rectangle {
                    radius: 10
                    color: Qt.rgba(root.cSurface.r, root.cSurface.g, root.cSurface.b, 0.85)
                    border.color: root.cBorder
                }
                contentItem: Text {
                    text: userBox.displayText
                    color: root.cFg
                    leftPadding: 12
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 14
                }
            }

            TextField {
                id: passwordField
                Layout.fillWidth: true
                placeholderText: "Password"
                echoMode: TextInput.Password
                color: root.cFg
                placeholderTextColor: root.cFgDim
                font.pixelSize: 14
                background: Rectangle {
                    radius: 10
                    color: Qt.rgba(root.cSurface.r, root.cSurface.g, root.cSurface.b, 0.85)
                    border.color: passwordField.activeFocus ? root.cAccent : root.cBorder
                    border.width: 1
                    Behavior on border.color { ColorAnimation { duration: 180 } }
                }
                onAccepted: sddm.login(userBox.currentText, passwordField.text, sessionBox.currentIndex)
            }

            ComboBox {
                id: sessionBox
                Layout.fillWidth: true
                model: sessionModel
                textRole: "name"
                currentIndex: sessionModel.lastIndex
                background: Rectangle {
                    radius: 10
                    color: Qt.rgba(root.cSurface.r, root.cSurface.g, root.cSurface.b, 0.85)
                    border.color: root.cBorder
                }
                contentItem: Text {
                    text: sessionBox.displayText
                    color: root.cFgDim
                    leftPadding: 12
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 12
                }
            }

            Button {
                id: loginBtn
                text: "Sign in"
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                background: Rectangle {
                    radius: 10
                    color: loginBtn.pressed
                        ? Qt.rgba(root.cAccent.r, root.cAccent.g, root.cAccent.b, 0.7)
                        : root.cAccent
                    Behavior on color { ColorAnimation { duration: 180 } }
                }
                contentItem: Text {
                    text: loginBtn.text
                    color: root.cFg
                    font.pixelSize: 14
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: sddm.login(userBox.currentText, passwordField.text, sessionBox.currentIndex)
            }
        }
    }

    // ===== Power buttons (bottom right) ===================================
    Row {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 28
        spacing: 12

        Repeater {
            model: [
                { glyph: "", action: function() { sddm.suspend()  } },
                { glyph: "", action: function() { sddm.reboot()   } },
                { glyph: "", action: function() { sddm.powerOff() } }
            ]
            Rectangle {
                width: 44; height: 44; radius: 12
                color: Qt.rgba(root.cBgAlt.r, root.cBgAlt.g, root.cBgAlt.b, 0.7)
                border.color: root.cBorder
                Text {
                    anchors.centerIn: parent
                    text: modelData.glyph
                    color: root.cFgDim
                    font.pixelSize: 18
                }
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: modelData.action()
                }
            }
        }
    }

    // Login result handling
    Connections {
        target: sddm
        function onLoginFailed() {
            passwordField.text = ""
            passwordField.placeholderText = "Try again"
        }
    }

    Component.onCompleted: passwordField.forceActiveFocus()
}
