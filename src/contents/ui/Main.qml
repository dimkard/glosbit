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
import org.kde.glosbit 1.0 as Glosbit
import "./dictionaries.js" as Dicts

Kirigami.ApplicationWindow {
    id: root

    property string fromCode:  (glosbitConfig.recentSource) ? glosbitConfig.recentSource : "es"
    property string toCode:  (glosbitConfig.recentTarget) ? glosbitConfig.recentTarget : "en"

    globalDrawer: Kirigami.GlobalDrawer {
        id: drawer

        function addActions() {
           var sub0 = dictionaryAction.createObject(drawer, {text: "From", level:0});
           var sub1 = dictionaryAction.createObject(drawer, {text: "To",level:0});
           var actionsList = [sub0, sub1];
           var fromChildrenList = [];
           var toChildrenList = [];

           for (var i=0; i<Dicts.glosbit.dictionary_amt; ++i) {            
               fromChildrenList[i] = dictionaryAction.createObject(drawer, { type: "from", level: 1, language: Dicts.glosbit.dictionary_list[i].language,  text: Dicts.glosbit.dictionary_list[i].language, languageCode: Dicts.glosbit.dictionary_list[i].code });
               toChildrenList[i] = dictionaryAction.createObject(drawer, { type: "to", level: 1, language: Dicts.glosbit.dictionary_list[i].language, text: Dicts.glosbit.dictionary_list[i].language, languageCode: Dicts.glosbit.dictionary_list[i].code });
           }

           actions = actionsList;
           actions[0].children = fromChildrenList;
           actions[1].children = toChildrenList;
        }

        title: "Glosbit"
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
            property int level: 0
            property string type: "" // from,to
            property string language: ""
            property string languageCode: ""

            text: ""

            onTriggered: {
                if(level === 1) {
                    showPassiveNotification(type === "from" ? qsTr("From: ") + language : qsTr("To: ") + language);
                    if(type === "from") {
                        glosbitConfig.recentSource = languageCode;
                        root.fromCode = languageCode;
                    }
                    else {
                        glosbitConfig.recentTarget = languageCode;
                        root.toCode = languageCode;
                    }
                }
            }
        }
    }

    Component {
        id: searchComponent

        Search {
            fromCode: root.fromCode
            toCode: root.toCode
            title: qsTr("Search")
            anchors.fill: parent
            onGosearch: {
                pageStack.push(translationComponent, {search_string: search_string})
            }

            onGoright: {
                root.pageStack.push(translationComponent)
            }

            onChangedirection:  {
                var swap = root.fromCode;
                root.fromCode = root.toCode;
                glosbitConfig.recentSource =  root.toCode;
                root.toCode = swap;
                glosbitConfig.recentTarget = swap;
            }

            onSetsource: {
                root.fromCode = fromCode;
                glosbitConfig.recentSource = fromCode;
            }

            onSettarget: {
                root.toCode = toCode;
                glosbitConfig.recentTarget = toCode;
            }
        }
    }

    Component {
        id: translationComponent
        
        ResultView {
            id: translation

            title: qsTr("Translation")
            type: "translation"
            fromCode: root.fromCode
            toCode: root.toCode

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
            fromCode: root.fromCode
            toCode: root.toCode
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
            width: parent.width
            font.pixelSize: Kirigami.Units.gridUnit*2/3
    }
    
    Glosbit.Config {
        id: glosbitConfig;
    }
}
