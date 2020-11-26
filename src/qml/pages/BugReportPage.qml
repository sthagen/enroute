/***************************************************************************
 *   Copyright (C) 2020 by Stefan Kebekus                                  *
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
import QtQuick.Layouts 1.15

import "../items"

Page {
    id: pg
    title: qsTr("Bug Report")

    header: StandardHeader {}

    ScrollView {
        clip: true
        anchors.fill: parent

        contentHeight: lbl1.height
        contentWidth: pg.width

        // The visibility behavior of the vertical scroll bar is a little complex.
        // The following code guarantees that the scroll bar is shown initially. If it is not used, it is faded out after half a second or so.
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: (height < contentHeight) ? ScrollBar.AlwaysOn : ScrollBar.AsNeeded
        ScrollBar.vertical.interactive: false

        Label {
            id: lbl1
            text: librarian.getStringFromRessource(":text/bugReport.html")
            textFormat: Text.RichText
            width: pg.width
            wrapMode: Text.Wrap
            topPadding: Qt.application.font.pixelSize*1
            leftPadding: Qt.application.font.pixelSize*0.5
            rightPadding: Qt.application.font.pixelSize*0.5
            onLinkActivated: Qt.openUrlExternally(link)
        } // Label

    } // ScrollView
} // Page
