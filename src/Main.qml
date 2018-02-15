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

    globalDrawer: Kirigami.GlobalDrawer {
        id: drawer

        Timer {
            interval: 1
            running: true
            onTriggered: {
                drawer.addActions()
            }
        }


        function addActions() {
           var subc = Qt.createComponent("DictionaryAction.qml");
           var sub0 = subc.createObject(drawer, {text: "From"});
           var sub1 = subc.createObject(drawer, {text: "To"});
           var actionsList = [sub0, sub1];
           var fromChildrenList = [];
           var toChildrenList = [];
           for (var i=0; i<Dicts.glosbit.dictionary_amt; ++i) {
//               sub0_n = subc.createObject(drawer, {text: Dicts.glosbit.dictionaries[i]});
               console.log(Dicts.glosbit.dictionary_list[i]);
               fromChildrenList[i] = subc.createObject(drawer, {text: Dicts.glosbit.dictionary_list[i], checkable: true});
               toChildrenList[i] = subc.createObject(drawer, {text: Dicts.glosbit.dictionary_list[i], checkable: true});

           }

           actions = actionsList;
           actions[0].children = fromChildrenList;
           actions[1].children = toChildrenList;
        }
        title: "Glosbit"
        titleIcon: "glosbit"
        contentItem.implicitWidth: Math.min (Kirigami.Units.gridUnit * 15, root.width * 0.8)
//        actions: [
//            Kirigami.Action {
//                id: fromDictionaries

//                text: "From"
//            },
//            Kirigami.Action {
//                id: toDictionaries

//                text: "To"
//            }
//        ]

        topContent: Column {
            anchors {
                left: parent.left
                right: parent.right
                margins: Kirigami.Units.smallSpacing
            }
            
            spacing: Kirigami.Units.gridUnit * 2

        }

    }

    pageStack.initialPage: [searchComponent]

    Component {
        id: searchComponent

        Search {
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

}
