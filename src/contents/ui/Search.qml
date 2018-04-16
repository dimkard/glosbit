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
import org.kde.kirigami 2.1 as Kirigami
import "./dictionaries.js" as Dicts

Kirigami.ScrollablePage {
    id: searchPage

    property variant palette
    property string from
    property string to
    property alias search_string: searchField.text

    signal gosearch
    signal goleft
    signal goright

    signal shown()

    Timer {
        interval: 0
        running: true
        onTriggered: {
            searchPage.shown()
        }
    }

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
            iconName: "qrc:///go-home-large-16.svg"
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


    mainItem: Column {
        spacing: Kirigami.Units.gridUnit
        
        Controls.Label {
            text:  qsTr(Dicts.glosbit.dictionary_list[searchPage.from].language + " > " + Dicts.glosbit.dictionary_list[searchPage.to].language)
            color: Kirigami.Theme.textColor
            font.pixelSize: Kirigami.Units.gridUnit
        }
    
        Row {
            id: searchRow

            spacing: Kirigami.Units.gridUnit

            Controls.TextField {
                id: searchField

                focus: true
                placeholderText: qsTr("Search...")
                Component.onCompleted: forceActiveFocus()

                Keys.onPressed: {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        searchRowButton.clicked();
                    }
                }
                Connections {
                    ignoreUnknownSignals: true
                    target: searchPage
                    onShown: {
                        searchField.forceActiveFocus()
                    }
                }
            }
            
            Controls.Button {
                id: searchRowButton
                text: qsTr("Go")
            }
        }
    }
}
