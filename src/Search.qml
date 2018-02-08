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
    id: searchPage
    
    property alias search_string: searchField.text
    signal gosearch
    signal goleft
    signal goright


//    anchors.centerIn: parent
    Connections {
        target: actions.left

        onTriggered: {
            goleft()
        }
    }

    Connections {
        target: actions.right

        onTriggered: {
            goright()
        }
    }

    Connections {
        target: searchRowButton
    
        onClicked: {
            gosearch()
        }        
    }

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

    Row {
        id: searchRow
        
        anchors.centerIn: parent
        spacing: Kirigami.Units.gridUnit * 2

        Controls.TextField {
            id: searchField
            placeholderText: qsTr("Search...")
        }
        Controls.Button {
            id: searchRowButton
            text: qsTr("Go")
        }
    }
}