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

Kirigami.ApplicationWindow {
    id: root

    globalDrawer: Kirigami.GlobalDrawer {
        id: drawer
        title: "Glosbit"
        titleIcon: "glosbit"
        contentItem.implicitWidth: Math.min (Kirigami.Units.gridUnit * 15, root.width * 0.8)

        topContent: Column {
            anchors {
                left: parent.left
                right: parent.right
                margins: Kirigami.Units.smallSpacing
            }
            
            spacing: Kirigami.Units.gridUnit * 2

            Kirigami.Heading {
                text: qsTr("Options")
                anchors {
                    left: parent.left
                    margins: Kirigami.Units.smallSpacing
                }
            }

            Controls.Label  {
                width: drawer.width
                text: qsTr("Source")
            }

            Controls.Label  {
                width: drawer.width
                text: qsTr("Destination")
            }
            
            Controls.Label  {
                width: drawer.width
                text: qsTr("Settings")
            }
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
