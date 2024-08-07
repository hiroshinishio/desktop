import QtQml 2.15
import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts 1.15
import Style 1.0
import com.nextcloud.desktopclient 1.0

Repeater {
    id: root

    property string objectType: ""
    property variant linksForActionButtons: []
    property variant linksContextMenu: []
    property bool displayActions: false

    property color moreActionsButtonColor: palette.base

    property int maxActionButtons: 0

    property Flickable flickable

    property bool talkReplyButtonVisible: true

    signal triggerAction(int actionIndex)
    signal showReplyField()

    model: root.linksForActionButtons

    Button {
        id: activityActionButton

        property string verb: model.modelData.verb
        property bool isTalkReplyButton: verb === "REPLY"

        Layout.alignment: Qt.AlignTop | Qt.AlignRight

        hoverEnabled: true
        padding: Style.smallSpacing
        display: Button.TextOnly

        text: model.modelData.label

        icon.source: model.modelData.imageSource ? model.modelData.imageSource + Style.adjustedCurrentUserHeaderColor : ""
        icon.width: Style.buttonSize
        icon.height: Style.buttonSize

        onClicked: isTalkReplyButton ? root.showReplyField() : root.triggerAction(model.index)

        visible: verb !== "REPLY" || (verb === "REPLY" && root.talkReplyButtonVisible)
    }
}
