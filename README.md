# mint-kha-package
Tests to see how well [mint](https://github.com/snowkit/mint) and [Kha](https://github.com/KTXSoftware/Kha) work together.

[Html5 Demo](https://sh-dave.github.io/mint-kha-package)

## progress g2
### mint renderer
* [usable, wip] ButtonRenderer
* [usable, wip] CheckboxRenderer
* [usable, wip] ProgressRenderer
* [usable, wip] LabelRenderer
* [wip] CanvasRenderer

### custom mint controls + renderer
* [usable, wip] TrackSlider - mint.Slider is more like a clickable ProgressBar, so lets see how easy it is to create something better

#### todos
* [] DropdownRenderer
* [] ImageRenderer
* [] ListRenderer
* [] PanelRenderer
* [] ScrollRenderer
* [] SliderRenderer
* [] TextEditRenderer
* [] WindowRenderer
* 
* [] event handling (resizing, etc)
* [] real depth sorting
* [] clipping

### g2 skinning options
* [wip] SpriterEntitySkin - animated skins
* [usable, wip] SubImageSkin - single texture
* [usable, wip] NinesliceSubImageSkin - nine slice texture
* [usable, wip] ColoredRectangleSkin - simple colored rectangle as skin
* [usable, wip] ColoredLabelSkin - font + color

### g4 skinning options
* todo

## other todos
* add Kha <del>and mint (is used as haxelib now)</del> as submodules (but i suck at using git, so the installscript is fine for now)
* <del>set movie size for flash builds to 512x512 for now, otherwise the fonts look distorted b/c of scaling</del>
