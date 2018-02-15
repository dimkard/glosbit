import QtQuick 2.1
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.0 as Controls
import org.kde.kirigami 2.0 as Kirigami

Kirigami.Action {
    property string action_index: ""
    property int level: 0

    text: "test"
    checkable: true

    onToggled: { console.log("toggled action " + action_index + " of level " + level); }
}
