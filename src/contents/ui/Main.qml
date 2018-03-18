/*
 *   Copyright 2018 Dimitris Kardarakos <dimkard@gmail.com>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2 or
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

import QtQuick 2.1
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.0 as Controls
import org.kde.kirigami 2.0 as Kirigami
import "./dictionaries.js" as Dicts

Kirigami.ApplicationWindow {
    id: root

    property int fromIndex: 2
    property int toIndex: 1


    globalDrawer: Kirigami.GlobalDrawer {
        id: drawer

        function addActions() {
           var sub0 = dictionaryAction.createObject(drawer, {text: "From", level:0});
           var sub1 = dictionaryAction.createObject(drawer, {text: "To",level:0});
           var actionsList = [sub0, sub1];
           var fromChildrenList = [];
           var toChildrenList = [];

           for (var i=0; i<Dicts.glosbit.dictionary_amt; ++i) {            
               fromChildrenList[i] = dictionaryAction.createObject(drawer, { type: "from", level: 1, text: Dicts.glosbit.dictionary_list[i].language, action_index: i });
               toChildrenList[i] = dictionaryAction.createObject(drawer, { type: "to", level: 1, text: Dicts.glosbit.dictionary_list[i].language, action_index: i });
           }

           actions = actionsList;
           actions[0].children = fromChildrenList;
           actions[1].children = toChildrenList;
        }

        title: "Glosbit"
//        titleIcon: "qrc:///glosbit.svg"
        contentItem.implicitWidth: Math.min (Kirigami.Units.gridUnit * 15, root.width * 0.8)

        topContent: Column {
            anchors {
                left: parent.left
                right: parent.right
                margins: Kirigami.Units.smallSpacing
            }

            spacing: Kirigami.Units.gridUnit * 2

        }

        Component.onCompleted: drawer.addActions()
    }

    pageStack.initialPage: [searchComponent]

    Component {
        id: dictionaryAction

        Kirigami.Action {
            property string action_index: ""
            property int level: 0
            property string type: "" // from,to

            text: ""

            onTriggered: {
                if(level === 1) {
                    var dictionary = Dicts.glosbit.dictionary_list[action_index];
                    showPassiveNotification(type === "from" ? qsTr("From: ") + dictionary.language : qsTr("To: ") + dictionary.language);
                    if(type === "from") {
                        root.fromIndex = action_index;
                    }
                    else {
                        root.toIndex= action_index;
                    }
                }
            }
        }
    }

    Component {
        id: searchComponent

        Search {
            from: root.fromIndex
            to: root.toIndex
            title: qsTr("Search")


            onGosearch: {
                pageStack.push(translationComponent, {search_string: search_string})
            }

            onGoright: {
                root.pageStack.push(translationComponent)
            }
        }
    }

    Component {
        id: translationComponent
        
        ResultView {
            id: translation

            title: qsTr("Translation")
            type: "translation"
            from: root.fromIndex
            to: root.toIndex

            onGoleft: {
                root.pageStack.pop(translationComponent)
            }

            onGoup: {
                root.pageStack.pop(exampleComponent)
                root.pageStack.pop(translationComponent)
            }

            onGoright: {
                root.pageStack.push(exampleComponent,{search_string: search_string})
            }
        }

    }
    
    Component {
        id: exampleComponent

        ResultView {
            id: example

            type: "example"
            from: root.fromIndex
            to: root.toIndex
            title: qsTr("Example")

            onGoleft: {
                root.pageStack.pop(exampleComponent)
            }

            onGoup: {
                root.pageStack.pop(exampleComponent)
                root.pageStack.pop(translationComponent)
            }
        }
    }
    
    footer: Controls.Label {
            text:  qsTr("Powered by glosbe.com")
            color: Kirigami.Theme.textColor
            horizontalAlignment:  Text.AlignHCenter
            width: parent.width - 10
            font.pixelSize: Kirigami.Units.gridUnit*2/3
    }
}
