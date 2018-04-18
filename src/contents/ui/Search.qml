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

import QtQuick 2.7
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.0 as Controls
import org.kde.kirigami 2.1 as Kirigami
import "./dictionaries.js" as Dicts

Kirigami.ScrollablePage {
    id: searchPage

    property variant palette
    property string fromCode
    property string toCode
    property string fromLanguage
    property string toLanguage
    property alias search_string: searchField.text

    signal gosearch
    signal goleft
    signal goright
    signal shown
    signal setsource
    signal settarget
    signal changedirection

    onFromCodeChanged: {
        var fromDictionary = Dicts.glosbit.dictionary_list.find(function( obj ) {
            return obj.code === fromCode;
        });
        searchPage.fromLanguage = fromDictionary.language;
    }

    onToCodeChanged: {
        var toDictionary = Dicts.glosbit.dictionary_list.find(function( obj ) {
            return obj.code === toCode;
        });
        searchPage.toLanguage = toDictionary.language;
    }

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

//     Connections { //TODO: Fix issue when changing directions
//         target: direction
// 
//         onClicked: {
//             changedirection()
//         }
//     }


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
        property int elements: 3
        spacing: Kirigami.Units.gridUnit
        height: searchPage.height - Kirigami.Units.gridUnit*(elements-1) - Kirigami.Units.iconSizes.large
        topPadding : searchPage.height - childrenRect.height - Kirigami.Units.gridUnit*(elements-1) - Kirigami.Units.iconSizes.large

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            Controls.ToolButton {
                id: fromButton

                text:  searchPage.fromLanguage
                onClicked: bottomDrawer.slideDrawer("from")

            }

            Controls.ToolButton {
                id: direction
 
                text: ">"
            }

            Controls.ToolButton {
                id: toButton

                text:  searchPage.toLanguage
                onClicked: bottomDrawer.slideDrawer("to")

            }
        }

    
        Row {
            id: searchRow

            spacing: Kirigami.Units.gridUnit
            anchors.horizontalCenter: parent.horizontalCenter

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

    Component {
        id: listModel
        
        ListModel {
        }
    }

    Component {
        id: listItem
        
        ListElement {
        }
    }
    
    Kirigami.OverlayDrawer {
        id: bottomDrawer

        property string dictionaryType

        edge: Qt.BottomEdge
        height: searchPage.height / 3


        function slideDrawer(fromTo) {
            bottomDrawer.dictionaryType = fromTo;
            var lmodel = listModel.createObject(dictionaryList);

            for (var i=0; i <Dicts.glosbit.dictionary_amt; ++i) {
                   lmodel.append({type: fromTo,  language: Dicts.glosbit.dictionary_list[i].language,  code: Dicts.glosbit.dictionary_list[i].code });
            }
            dictionaryList.model = lmodel ;
            open();
        }

        contentItem:
            ListView {
                id: dictionaryList

                clip: true
                spacing: Kirigami.Units.gridUnit
                

                delegate: dictionaryDelegate
            }
    }

    Component {
        id: dictionaryDelegate

        Kirigami.BasicListItem {
            text: language
            
            onClicked: {
                if (type === "from") {
                    searchPage.fromCode = code;
                    searchPage.setsource();
                    bottomDrawer.close();
                    
                }
                else {
                    searchPage.toCode = code;
                    searchPage.settarget();
                    bottomDrawer.close();
                }
            }
        }
    }
    
}
