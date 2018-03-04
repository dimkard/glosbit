import QtQuick 2.0
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.0 as Controls
import org.kde.kirigami 2.0 as Kirigami

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

        Controls.TextArea{
            id: first

            width: exampleRect.width
            padding: Kirigami.Units.gridUnit
            color: Kirigami.Theme.textColor
            readOnly: true

            text: source_text
            wrapMode: Text.Wrap

            font.bold: (result_type == "translation") ? true : false

        }
        Controls.TextArea{
            id: second

            width: exampleRect.width
            padding: Kirigami.Units.gridUnit
            color: Kirigami.Theme.textColor
            readOnly: true

            text: target_text
            wrapMode: Text.Wrap

            font.italic: (result_type == "translation") ? true : false

        }
    }
}
