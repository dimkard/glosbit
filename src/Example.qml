/*
 *   Copyright 2018 Dimitris Kardarakos <dimkard@gmail.com>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU Library General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.0
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.0 as Controls
import org.kde.kirigami 2.0 as Kirigami

Kirigami.ScrollablePage {
    id: examplePage

    actions {
        main: Kirigami.Action {
           iconName: "go-up"
           text: qsTr("Home")
         }

        left: Kirigami.Action {
            iconName: "go-previous"
            text: qsTr("Left")
        }

        right: Kirigami.Action {
            iconName: "go-next"
            text: qsTr("Right")
        }
    }


    Column {
        id: exampleColumn

        anchors.centerIn: parent
        spacing: Kirigami.Units.gridUnit * 2

        Controls.Label {
            text: qsTr("Example 1")
        }

        Controls.Label {
            text: qsTr("Example 2")
        }

    }
}
