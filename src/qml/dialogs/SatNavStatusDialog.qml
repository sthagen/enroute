/***************************************************************************
 *   Copyright (C) 2019-2020 by Stefan Kebekus                             *
 *   stefan.kebekus@gmail.com                                              *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 3 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
 ***************************************************************************/

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15

import enroute 1.0

Dialog {
    id: satNavStatusDialog

    title: qsTr("Satellite Status")

    // Size is chosen so that the dialog does not cover the parent in full
    width: Math.min(parent.width-Qt.application.font.pixelSize, 40*Qt.application.font.pixelSize)
    height: Math.min(parent.height-Qt.application.font.pixelSize, implicitHeight)

    standardButtons: Dialog.Ok

    ScrollView {
        id: view
        clip: true
        anchors.fill: parent

        // The visibility behavior of the vertical scroll bar is a little complex.
        // The following code guarantees that the scroll bar is shown initially. If it is not used, it is faded out after half a second or so.
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: (height < contentHeight) ? ScrollBar.AlwaysOn : ScrollBar.AsNeeded

        GridLayout {
            id: gl
            columnSpacing: 30
            columns: 2

            Label { text: qsTr("Satellite Status") }
            Label {
                font.weight: Font.Bold
                text: satNav.statusAsString
                color: (satNav.status === SatNav.OK) ? "green" : "red"
                wrapMode: Text.Wrap
            }

            Label { text: qsTr("Last Fix") }
            Label { text: satNav.timestampAsString }

            Label { text: qsTr("Mode") }
            Label { text: satNav.isInFlight ? qsTr("Flight") : qsTr("Ground") }

            Label {
                font.pixelSize: Qt.application.font.pixelSize*0.5
                Layout.columnSpan: 2
            }

            Label {
                text: qsTr("Horizontal")
                font.weight: Font.Bold
                Layout.columnSpan: 2
            }

            Label { text: qsTr("Latitude") }
            Label { text: satNav.latitudeAsString }

            Label { text: qsTr("Longitude") }
            Label { text: satNav.longitudeAsString }

            Label { text: qsTr("Error") }
            Label { text: satNav.horizontalPrecisionInMetersAsString }

            Label { text: qsTr("GS") }
            Label { text: globalSettings.useMetricUnits ? satNav.groundSpeedInKMHAsString : satNav.groundSpeedInKnotsAsString }

            Label { text: qsTr("TT") }
            Label { text: satNav.trackAsString }

            Label {
                font.pixelSize: Qt.application.font.pixelSize*0.5
                Layout.columnSpan: 2
            }

            Label {
                text: qsTr("Vertical")
                font.weight: Font.Bold
                Layout.columnSpan: 2
            }

            Label { text: qsTr("ALT") }
            Label { text: satNav.altitudeInFeetAsString }
        } // GridLayout

    } // Scrollview

    onAccepted: {
        // Give feedback
        mobileAdaptor.vibrateBrief()
        close()
    }
} // Dialog
