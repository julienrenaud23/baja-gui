import "Constants.js" as Consts
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Window {
    width: 550
    height: 300
    visible: true
    title: qsTr("Dashbee")
    color: Consts.mainBg

    onHeightChanged: {
        windowSizeLabel.text = `${width}x${height}`
    }

    onWidthChanged: {
        windowSizeLabel.text = `${width}x${height}`
    }

    RowLayout {
        y: parent.height * 0.20
        x: 10
        spacing: 30
        Label {
            text: "Fuel"
            font.pixelSize: 25
            color: Consts.graphColor
            horizontalAlignment: "AlignRight"
        }
        Item {
            implicitWidth: Window.width*0.015
            implicitHeight: Window.height*0.45
            objectName: "fuelBar"
            id: fuelBar
            property real from: 0
            property real to: 1
            property real value: 0.45
            Repeater {
                model: 100
                Rectangle {
                    height: parent.height/100
                    width: parent.width
                    y: parent.height - index*(parent.height/100)
                    color: index < (fuelBar.value*100) ? Consts.graphColor : Consts.graphBg
                }
            }
            Repeater {
                model: 9
                Rectangle {
                    height: 2
                    width: parent.width
                    color: "#3a3a3a"
                    y: (index+1) * (parent.height/10)
                }
            }
        }
    }
    Item {
        Label {
            id: clockLabel
            objectName: "clockLabel"
            text: "00:00:00pm"
            color: Consts.graphColor
            font.pixelSize: 24
            y: 5
            x: Window.width - this.width - 5
        }
        Timer {
            interval: 1000 // Trigger every 1000 milliseconds (1 second)
            repeat: true   // Make the timer trigger repeatedly
            running: true

            onTriggered: {
                // This code block will execute every 'interval' milliseconds
                var now = new Date();
                var time = {
                    h: now.getHours(),
                    m: now.getMinutes(),
                    s: now.getSeconds()
                };
                var pm = (time.h > 12);
                time.h = time.h - (pm ? 12 : 0); // convert military time to standard
                clockLabel.text = `${time.h < 10 ? "0" : ""}${time.h}:${time.m < 10 ? "0" : ""}${time.m}:${time.s < 10 ? "0" : ""}${time.s}${pm ? "pm" : "am"}`
            }
        }
    }
    Label {
        // widthXheight
        id: windowSizeLabel
        x: Window.width - this.width - 5
        y: Window.height - this.height
        text: `${Window.width}x${Window.height}`
    }
}
