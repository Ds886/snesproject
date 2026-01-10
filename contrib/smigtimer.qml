import QtQuick 2.0
import USB2Snes 1.0
import "qrc:/extrajs.js" as Helper

Rectangle {
    width: 480
    height: 480
    color: "black"
    id: window

    property var banks: [
        { name: "0x7E", base: 0x7E0000 },
        { name: "0xF5", base: 0xF50000 },
        { name: "0xE0", base: 0xE00000 },
        { name: "0x00", base: 0x000000 }
    ]

    Column {
        anchors.centerIn: parent
        spacing: 20

        Repeater {
            id: bankRepeater        // give it an id for itemAt()
            model: banks

            delegate: Column {
                spacing: 6
                Rectangle { width: parent.width; height: 1; color: "gray" }
                Text { text: "Bank " + modelData.name; color: "orange"; font.bold: true; font.pixelSize: 20 }

                Text { id: hiColor; text: "HI_COLOR: --"; color: "white"; font.pixelSize: 18 }
                Text { id: loColor; text: "LO_COLOR: --"; color: "white"; font.pixelSize: 18 }
                Text { id: countAnim; text: "COUNT_ANIM: --"; color: "white"; font.pixelSize: 18 }

                property alias ref_hi: hiColor
                property alias ref_lo: loColor
                property alias ref_cnt: countAnim
            }
        }
    }

    USB2Snes {
        id: usb2snes
        objectName: "usb2snes"
        windowTitle: "Magic2Usb – Multi Base Symbol Viewer"
        timer: 100

        onTimerTick: {
            for (var i = 0; i < banks.length; i++) {
                var base = banks[i].base;

                var hi_val = memory.readUnsignedWord(base + 0x202) & 0xFF;
                var lo_val = memory.readUnsignedWord(base + 0x201) & 0xFF;
                var count_val = memory.readUnsignedWord(base + 0x200) & 0xFF;

                // Access the delegate for this bank
                var section = bankRepeater.itemAt(i);
                if (!section)
                    continue;

                section.ref_hi.text = "HI_COLOR: 0x" + hi_val;
                section.ref_lo.text = "LO_COLOR: 0x" + lo_val;
                section.ref_cnt.text = "COUNT_ANIM: 0x" + count_val;

                console.log(
                    "Bank " + banks[i].name +
                    " => HI=" + hi_val +
                    " LO=" + lo_val +
                    " CNT=" + count_val
                );
            }
        }
    }
}
