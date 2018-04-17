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
import "./Utils.js" as Utils
import "./dictionaries.js" as Dicts

Kirigami.ScrollablePage {
    id: root

    property string type: "" // or "example"
    property string fromCode
    property string toCode
    property string search_string

    signal goleft
    signal goright
    signal goup

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
        target: actions.main

        onTriggered: {
            goup()
        }
    }

    actions {
        main: Kirigami.Action {
            id: up

            iconName: "qrc:///go-home-large-16.svg"
            text: qsTr("Home")
        }

        left: Kirigami.Action {
            id: prev

            iconName: "go-previous"
            text: qsTr("Left")
        }

        right: Kirigami.Action {
            iconName: "go-next"
            text: qsTr("Right")
        }
    }

    mainItem: ListView {
        id: resultsView

        property alias type: root.type

        spacing: Kirigami.Units.gridUnit*2
        model: resultsModel
        delegate: examplesDelegate//examplesDelegate// //TODO: make conditional by type

        onTypeChanged: {
            if ( type === "translation" ) {
                resultsView.delegate = translationsDelegate;
            }
            else {
                resultsView.delegate = examplesDelegate;
            }
        }

    }

    ListModel {
        id: resultsModel
    }

    Component {
        id: translationsDelegate

        ResultDelegate {
            id: translationsRect

            result_type: "translation"
            containerWidth: root.width
            source_text: phrase_text
            target_text: meaning_text
        }
    }

    Component {
        id: examplesDelegate

        ResultDelegate {
            id: exampleRect

            result_type: "example"
            containerWidth: root.width
            source_text: first_text
            target_text: second_text
        }
    }

    Component.onCompleted: {
        Utils.getModelData(root.search_string, root.type, resultsModel, root.fromCode, root.toCode);
    }
}
