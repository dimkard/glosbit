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

import QtQuick 2.6
import QtQuick.Controls 2.4 as Controls
import org.kde.kirigami 2.5 as Kirigami

Rectangle {
    id: exampleRect

    property int containerWidth: 0
    property string source_text: ""
    property string target_text: ""
    property string result_type: ""

    width: containerWidth - Kirigami.Units.gridUnit
    height: childrenRect.height //textColumn.height//(first.contentHeight + second.contentHeight + separator.height)
    clip: true
    color: "transparent"

    Column {
        id: textColumn

        width: exampleRect.width
        spacing: Kirigami.Units.gridUnit

        Controls.TextArea {
            id: first

            width: exampleRect.width
            padding: Kirigami.Units.gridUnit
            readOnly: true
            text: source_text
            wrapMode: Text.Wrap
            font.bold: (result_type == "translation") ? true : false
//            color: Kirigami.Theme.textColor
        }

        Controls.TextArea{
            id: second

            width: exampleRect.width
            padding: Kirigami.Units.gridUnit
            readOnly: true
            text: target_text
            wrapMode: Text.Wrap
            font.italic: (result_type == "translation") ? true : false
            //            color: Kirigami.Theme.textColor
        }
    }
}
