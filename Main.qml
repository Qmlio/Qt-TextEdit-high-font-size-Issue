import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window {
    width: 640
    height: 480
    visible: true
    property real fontZoomRate: 30
    property real zoomFontSize: 300
    title: qsTr("Hello World")
    WheelHandler {

        id: wheal
        target: null
        orientation: Qt.Vertical
        property: "scale"
        rotationScale: 15
        acceptedModifiers: Qt.ControlModifier
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
        onWheel: event => {

                     if (event.angleDelta.y < 0) {

                         zoomFontSize -= fontZoomRate
                     } else {

                         zoomFontSize += fontZoomRate
                     }
                 }
    }
    Row {
        anchors.fill: parent
        spacing: 32
        //// uses pixel size
        Rectangle {
            id: mainId
            width: 300
            color: "red"

            height: parent.height
            Text {
                font.bold: true
                color: "white"
                text: qsTr("Uses Pixel size %1").arg(zoomFontSize)
            }
            Flickable {
                id: flickArea
                anchors.fill: parent
                contentWidth: textArea.contentWidth
                contentHeight: textArea.contentHeight
                anchors.centerIn: parent
                boundsBehavior: Flickable.StopAtBounds
                ScrollBar.vertical: ScrollBar {
                    id: vBar
                }
                ScrollBar.horizontal: ScrollBar {
                    id: hbar
                    active: true
                }
                ScrollIndicator.vertical: ScrollIndicator {}
                ScrollIndicator.horizontal: ScrollIndicator {}

                function ensureVisible(r) {
                    if (contentX >= r.x)
                        contentX = r.x
                    else if (contentX + width <= r.x + r.width)
                        contentX = r.x + r.width - width
                    if (contentY >= r.y)
                        contentY = r.y
                    else if (contentY + height <= r.y + r.height)
                        contentY = r.y + r.height - height
                }

                TextEdit {
                    id: textArea

                    width: flickArea.width
                    font.pixelSize: zoomFontSize
                    text: "  A particular look and feel might use smooth scrolling (eg. using SmoothedAnimation), might have a visible scro"
                    onCursorRectangleChanged: {

                        flickArea.ensureVisible(cursorRectangle)
                    }
                    wrapMode: TextArea.Wrap
                    focus: true
                }
            }
        }

        Rectangle {
            id: mainId2
            width: 300
            color: "green"
            // uses point size
            height: parent.height
            Text {
                font.bold: true
                color: "white"
                text: qsTr("Uses point size %1").arg(zoomFontSize)
            }
            Flickable {
                id: flick

                width: 300
                height: parent.height
                contentWidth: edit.contentWidth
                contentHeight: edit.contentHeight
                ScrollBar.vertical: ScrollBar {
                    id: vBar11
                }
                ScrollBar.horizontal: ScrollBar {
                    id: hbar11
                    active: true
                }
                ScrollIndicator.vertical: ScrollIndicator {}
                ScrollIndicator.horizontal: ScrollIndicator {}

                function ensureVisible(r) {
                    if (contentX >= r.x)
                        contentX = r.x
                    else if (contentX + width <= r.x + r.width)
                        contentX = r.x + r.width - width
                    if (contentY >= r.y)
                        contentY = r.y
                    else if (contentY + height <= r.y + r.height)
                        contentY = r.y + r.height - height
                }

                TextEdit {
                    id: edit
                    width: flick.width
                    focus: true
                    text: "  A particular look and feel might use smooth scrolling (eg. using SmoothedAnimation), might have a visible scro"

                    font.pointSize: zoomFontSize
                    wrapMode: TextEdit.Wrap
                    onCursorRectangleChanged: flick.ensureVisible(
                                                  cursorRectangle)
                }
            }
        }
    }
}
