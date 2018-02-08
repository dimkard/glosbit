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

Kirigami.ScrollablePage {
    id: root

    property string type: "" // or "example"
    property string search_string

//    anchors.centerIn: parent
    signal goleft
    signal goright

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

    actions {
        main: Kirigami.Action {
           iconName: "go-up"
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

    ListView {
        id: resultsView
        property alias type: root.type

//        anchors { fill: parent }
        spacing: Kirigami.Units.gridUnit * 2
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

      Column {
          id: translationsColumn

          anchors {
//              left: parent.left
//              right: parent.right
              margins: Kirigami.Units.smallSpacing
          }

          spacing: Kirigami.Units.gridUnit * 2

          Text { text: phrase_text }
          Text { text: meaning_text }
      }
    }

    Component {
      id: examplesDelegate
      Column {
          id: examplesColumn

          anchors {

              margins: Kirigami.Units.smallSpacing
          }

          spacing: Kirigami.Units.gridUnit * 4

          Column {
              width: root.width
              Rectangle {
                  clip: false
                  color: "transparent"
                  width: root.width
                  height: (first.contentHeight + second.contentHeight)
                  
                  Column {
                        id: textColumn
                        width: root.width                        

                        TextEdit{
                            id: first
                            text: first_text
                            color: Kirigami.Theme.textColor
                            wrapMode: Text.Wrap
                            width: root.width
                //              font: Kirigami.Theme.defaultFont
//                             font.pointSize: Kirigami.Theme.defaultFont.pointSize * 1.2

                        }
                        TextEdit{
                            id: second
                            text: second_text
                            width: root.width
                            color: Kirigami.Theme.textColor
                            wrapMode: Text.Wrap
                //              font: Kirigami.Theme.defaultFont
//                             font.pointSize: Kirigami.Theme.defaultFont.pointSize * 1.2
                        }
                    }
              }
          }
      }
    }


    Component.onCompleted: {
        Utils.getModelData(root.search_string, root.type, resultsModel);
        console.log (root.type + " onCompleted");
    }
}
