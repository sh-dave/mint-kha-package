# mint-kha-package
Tests to see how well [mint](https://github.com/snowkit/mint) and [Kha](https://github.com/KTXSoftware/Kha) work together

## progress g2
### mint renderer
* [usable, wip] ButtonRenderer
* [usable, wip] CheckboxRenderer
* [usable, wip] ProgressRenderer
* [usable, wip] LabelRenderer
* [wip] CanvasRenderer
* [] DropdownRenderer
* [] ImageRenderer
* [] ListRenderer
* [] PanelRenderer
* [] ScrollRenderer
* [] SliderRenderer
* [] TextEditRenderer
* [] WindowRenderer

#### todos
* [] event handling (resizing, etc)

### custom mint controls
* [wip] TrackSlider - mint.Slider is more like a clickable ProgressBar, so lets see how easy it is to create something better

### g2 skinning options
* [usable, wip] AtlasTextureSkin
* [usable, wip] ColoredRectSkin
* [usable, wip (needs optimization)] NineSliceAtlasTextureSkin
* [usable, wip (needs refactoring: text, font + fontSize need to be set for the state skins)] LabelSkin

### g4 skinning options
* todo

## other todos
* add Kha <del>and mint (is used as haxelib now)</del> as submodules (but i suck at using git, so the installscript is fine for now)
* <del>set movie size for flash builds to 512x512 for now, otherwise the fonts look distorted b/c of scaling</del>
