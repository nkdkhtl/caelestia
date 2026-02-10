import qs.components
import qs.services
import qs.config
import QtQuick
import QtQuick.Shapes

ShapePath {
    id: root

    required property Wrapper wrapper
    readonly property real rounding: Config.border.rounding
    readonly property bool flatten: wrapper.height < rounding * 2
    readonly property real roundingY: flatten ? wrapper.height / 2 : rounding

    strokeWidth: -1
    fillColor: Colours.palette.m3surface

    PathArc {
        relativeX: root.rounding
        relativeY: -root.roundingY // Đảo dấu từ dương thành âm
        radiusX: root.rounding
        radiusY: root.roundingY
        direction: PathArc.Counterclockwise // Đảo hướng để bo lồi khi đi ngược
    }

    // 2. Cạnh dọc bên trái: Đi lên (-Y)
    PathLine {
        relativeX: 0
        relativeY: -(root.wrapper.height - root.roundingY * 2)
    }

    // 3. Góc bo trên bên trái
    PathArc {
        relativeX: root.rounding
        relativeY: -root.roundingY
        radiusX: root.rounding
        radiusY: root.roundingY
        direction: PathArc.Clockwise
    }

    // 4. Cạnh ngang đỉnh: Sang phải (+X)
    PathLine {
        relativeX: root.wrapper.width - root.rounding * 2
        relativeY: 0
    }

    // 5. Góc bo trên bên phải: Bắt đầu đi xuống (+Y)
    PathArc {
        relativeX: root.rounding
        relativeY: root.roundingY
        radiusX: root.rounding
        radiusY: root.roundingY
        direction: PathArc.Clockwise
    }

    // 6. Cạnh dọc bên phải: Đi xuống (+Y)
    PathLine {
        relativeX: 0
        relativeY: root.wrapper.height - root.roundingY * 2
    }

    // 7. Góc bo dưới bên phải: Quay về mặt đáy
    PathArc {
        relativeX: root.rounding
        relativeY: root.roundingY
        radiusX: root.rounding
        radiusY: root.roundingY
        direction: PathArc.Counterclockwise
    }

    Behavior on fillColor {
        CAnim {}
    }
}
