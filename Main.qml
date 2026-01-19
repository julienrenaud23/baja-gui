import "Constants.js" as Consts
import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Shapes

Window {
    width: 550
    height: 300
    visible: true
    title: qsTr("Dashbee")
    color: Consts.mainBg

    onHeightChanged: {
        if (Consts.debug) {
            windowSizeLabel.text = `${width}x${height}`
        }
    }

    onWidthChanged: {
        if (Consts.debug) {
            windowSizeLabel.text = `${width}x${height}`
        }
    }

    // layout that contains speedometer, fuel bar, rpm gauge and engine light
    RowLayout {
        y: Window.height * 0.20
        x: Window.width/2 - width
        property real center: y
        id: gaugesLayout
        spacing: 60

        // custom progress bar to be vertical and have ticks inside
        Item {
            Label {
                text: "Fuel"
                y: gaugesLayout.center
                x: parent.x - width - 10
                font.pixelSize: 25
                color: Consts.graphColor
                Layout.alignment: Qt.AlignHCenter
            }

            implicitWidth: Window.width*0.04
            implicitHeight: Window.height*0.45
            objectName: "fuelBar"
            id: fuelBar
            property real from: 0
            property real to: 1
            property real value: 0.45

            // loop to fill the bar
            Repeater {
                model: 100
                Rectangle {
                    height: parent.height/100
                    width: parent.width
                    y: parent.height - index*(parent.height/100)
                    color: index < (fuelBar.value*100) ? Consts.graphColor : Consts.graphBg
                }
            }
            // loop to add the ticks
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
        Item {
            objectName: "speedometer"
            id: speedometer
            property real value: 0
            property real offset: 10 // for some reason the items dont align super well so i needed an offset
            Rectangle {
                width: Window.width * 0.3
                height: Window.height * 0.5
                y: -height/2 + speedLabel.height/2 - parent.offset
                x: -width/2 + speedLabel.width/2
                color: Consts.mainBg
                border.width: 1
                border.color: "black"
            }

            Label {
                id: speedLabel
                y: -parent.offset
                color: Consts.graphColor
                font.pixelSize: 25
                text: parent.value + " km/h"
            }
        }
        Item {
            objectName: "tachometer"
            id: tachometer
            property real value: 150
            property real redline: 3600
            property real offset: 10 // for some reason the items dont align super well so i needed an offset

            Rectangle {
                width: Window.width * 0.3
                height: Window.height * 0.5
                y: -height/2 + tachometerLabel.height/2 - parent.offset
                x: speedometer.x
                color: Consts.mainBg
                border.width: 1
                border.color: "black"
            }

            Label {
                id: tachometerLabel
                y: -parent.offset
                x: speedometer.x + width/3
                color: parent.value < parent.redline ? Consts.graphColor : Consts.redline
                font.pixelSize: 25
                text: parent.value + " RPM"
            }
        }
    }

    // this controls and updates the time
    Item {
        Label {
            id: clockLabel
            objectName: "clockLabel"
            text: "00:00:00pm"
            color: Consts.graphColor
            font.pixelSize: 18
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
        id: odoLabel
        objectName: "odoLabel"
        // value should be changed from c++
        property real value: 0 // just a placeholder value for now
        // function executes on label init
        Component.onCompleted: {
            // add 4 leading zeros
            this.text = value.toString().padStart(4, '0')+"km";
        }
        color: Consts.graphColor
        font.pixelSize: 18
        y: 5
        x: 5
    }

    // debugging purposes
    Label {
        // widthXheight
        id: windowSizeLabel
        visible: Consts.debug
        x: Window.width - width - 5
        y: Window.height - height
        text: `${Window.width}x${Window.height}`
    }
}
