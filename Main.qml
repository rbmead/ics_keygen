// SSH key generator UI

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import com.ics.demo 1.0

ApplicationWindow {
    visible: true
    title: qsTr("SSH Key Generator")

    RowLayout {
        Label {
            id: status
            }
        }


    width: 369
    height: 166

    ColumnLayout {
        x: 10
        y: 10

        // Key type
        RowLayout {
            Label {
                text: qsTr("Key type:")
            }
            ComboBox {
                id: combobox
                Layout.fillWidth: true
                model: keygen.types
                currentIndex: 2
            }
        }

        // Filename
        RowLayout {
            Label {
                text: qsTr("Filename:")
            }
            TextField {
                id: filename
                implicitWidth: 200
                onTextChanged: updateStatusBar()
            }
            Button {
                text: qsTr("&Browse...")
                onClicked: filedialog.visible = true
            }
        }

        // Passphrase
        RowLayout {
            Label {
                text: qsTr("Pass phrase:")
            }
            TextField {
                id: passphrase
                Layout.fillWidth: true
                echoMode: TextInput.Password
                onTextChanged: updateStatusBar()
            }

        }

        // Confirm Passphrase
        RowLayout {
            Label {
                text: qsTr("Confirm pass phrase:")
            }
            TextField {
                id: confirm
                Layout.fillWidth: true
                echoMode: TextInput.Password
                onTextChanged: updateStatusBar()
            }
        }

        // Buttons: Generate, Quit
        RowLayout {
            Button {
                id: generate
                text: qsTr("&Generate")
                onClicked: keygen.generateKey()
            }
            Button {
                text: qsTr("&Quit")
                onClicked: Qt.quit()
            }
        }

    }

    FileDialog {
        id: filedialog
        title: qsTr("Select a file")
        nameFilters: [ "All files (*)" ]
        onAccepted: {
            filename.text = filedialog.fileUrls
        }
    }

    KeyGenerator {
        id: keygen
        filename: filename.text
        passphrase: passphrase.text
        type: combobox.currentText
        onKeyGenerated: {
            if (success) {
                status.text = qsTr('<font color="green">Key generation succeeded.</font>')
            } else {
                status.text = qsTr('<font color="red">Key generation failed</font>')
            }
        }
    }

    function updateStatusBar() {
        if (passphrase.text != confirm.text) {
            status.text = qsTr('<font color="red">Pass phrase does not match.</font>')
            generate.enabled = false
        } else if (passphrase.text.length > 0 && passphrase.text.length < 5) {
            status.text = qsTr('<font color="red">Pass phrase too short.</font>')
            generate.enabled = false
        } else if (filename.text == "") {
            status.text = qsTr('<font color="red">Enter a filename.</font>')
            generate.enabled = false
        } else {
            status.text = ""
            generate.enabled = true
        }
    }

    Component.onCompleted: updateStatusBar()
}
