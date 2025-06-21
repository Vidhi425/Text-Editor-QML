import QtQuick
import QtQuick.Window
import QtQuick.Controls.Basic
import QtQuick.Dialogs
import com.company.backend 1.0

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Backend{
        id: backend
        onPathChanged: console.log("path: ", path)
        onDataChanged: console.log("data: ", data)
    }

    FileDialog {
        id: openDialog
        title: "Please choose a file"
        currentFolder: StandardPaths.standardLocations(StandardPaths.HomeLocation)[0]
        fileMode: FileDialog.OpenFile

        onAccepted: {
            backend.path = openDialog.selectedFile
            editor.text = backend.data
        }
    }

    FileDialog {
        id: saveDialog
        title: "Please choose a file"
        currentFolder: StandardPaths.standardLocations(StandardPaths.HomeLocation)[0]
        fileMode: FileDialog.SaveFile

        onAccepted: {
            backend.path = openDialog.selectedFile
            backend.data = editor.text
        }
    }

    Action {
        id: actionNew
        text:qsTr("New")
        icon.color: "transparent"
        icon.source: "qrc:/images/images/new-document.png"
        onTriggered: editor.clear()
    }

    Action {
        id: actionOpen
        text:qsTr("Open")
        icon.color: "transparent"
        icon.source: "qrc:/images/images/folder.png"
        onTriggered: openDialog.open()
    }

    Action {
        id: actionSave
        text:qsTr("Save")
        icon.color: "transparent"
        icon.source: "qrc:/images/images/save.png"
        onTriggered: saveDialog.open()
    }

    Action {
        id: actionCut
        text:qsTr("Cut")
        icon.color: "transparent"
        icon.source: "qrc:/images/images/file.png"
        onTriggered: editor.cut()
    }

    Action {
        id: actionCopy
        text:qsTr("Copy")
        icon.color: "transparent"
        icon.source: "qrc:/images/copy.png"
        onTriggered: editor.copy()
    }

    Action {
        id: actionPaste
        text:qsTr("Paste")
        icon.color: "transparent"
        icon.source: "qrc:/images/images/paper-stack.png"
        onTriggered: editor.paste()
    }
    menuBar: MenuBar{
        Menu {
            id: menuFile
            title: qsTr("File")
            MenuItem {action: actionNew}
            MenuItem {action: actionOpen}
            MenuItem {action: actionSave}
        }

        Menu {
            id: editFile
            title: qsTr("Edit")
            MenuItem {action: actionCopy}
            MenuItem {action: actionCut}
            MenuItem {action: actionPaste}
        }
    }

    header: ToolBar{
        Row{
            ToolButton {display: AbstractButton.IconOnly; action: actionNew}
            ToolButton {display: AbstractButton.IconOnly; action: actionOpen}
            ToolButton {display: AbstractButton.IconOnly; action: actionSave}
            ToolButton {display: AbstractButton.IconOnly; action: actionCopy}
            ToolButton {display: AbstractButton.IconOnly; action: actionCut}
            ToolButton {display: AbstractButton.IconOnly; action: actionPaste}
        }
    }

    ScrollView{
        anchors.fill: parent
        TextArea{
            id:editor
            focus:true
            text: "hello world"
            selectByMouse: true
            persistentSelection: true
        }
    }
}
