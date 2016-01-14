package;

import mint.types.Types.InteractState;
import mint.types.Types.MouseButton;
import mint.types.Types.TextAlign;
import mintkha.support.Offset;

typedef MyTheme = mintkha.theme.KenneyBasicTheme;

class SkinnedExample {
	var backbuffer : kha.Image;
	var rendering : mintkha.G2Rendering;
	var focusManager : mint.focus.Focus;

	var themeAtlasModel : mintkha.support.TextureAtlas.AtlasModel;
	var themeAtlasTexture : kha.Image;

	var canvas : mint.Canvas;
	var progress : mint.Progress;
	var pressMeButton : mint.Button;
	var oneSkinButton : mint.Button;
	var checkbox : mint.Checkbox;
	var hslider : mint.TrackSlider;
	var vslider : mint.TrackSlider;

	var progressValue : Float = 0.0;

	var theme = mintkha.theme.KenneyBasicTheme.blueTheme;

	public function new() {
		kha.System.init('mintkha-example-atlas', 512, 512, system_initializedHandler);
	}

	function system_initializedHandler() {
		kha.Assets.loadEverything(assets_loadedHandler);
	}

	function assets_loadedHandler() {
		setupTheme();
		setupUi();
		setupUiEvents();
		kha.System.notifyOnRender(render);
		kha.Scheduler.addTimeTask(update, 0, 1 / 60);
	}

	function update() {
		progressValue += 0.01;

		if (progressValue >= 1.0) {
			progressValue -= 1.0;
		}

		progress.progress = progressValue;
	}

    function render( framebuffer : kha.Framebuffer ) {
		trace('SkinnedExample.render');

		var g = backbuffer.g2;

		g.begin(true, kha.Color.fromBytes(0, 64, 64));
			rendering.renderG2(g);
		g.end();

		g = framebuffer.g2;

		g.begin();
			kha.Scaler.scale(backbuffer, framebuffer, kha.System.screenRotation);
		g.end();
	}

	function setupTheme() {
		themeAtlasModel = mintkha.support.StarlingAtlasXmlReader.read(Xml.parse(kha.Assets.blobs.basic_atlas_xml.toString()));
		themeAtlasTexture = kha.Assets.images.basic_sheet;
	}

	function pressMeButton_onClickHandler( _1, _2 ) {
		checkbox.state = !checkbox.state;

		if (pressMeButton.label.text == 'PRESS ME!') {
			pressMeButton.label.text = 'YAY!';
		} else {
			pressMeButton.label.text = 'PRESS ME!';
		}
	}

	function setupUi() {
		backbuffer = kha.Image.createRenderTarget(512, 512);
		rendering = new mintkha.G2Rendering();

		canvas = new mint.Canvas({
			rendering : rendering,
			mouse_input : true,
			key_input : true,
		});

		var a = kha.Assets;

        focusManager = new mint.focus.Focus(canvas);

		var pressMeButtonFont = kha.Assets.fonts.kenvector_future_thin;

		pressMeButton = new mint.Button({
			parent : canvas,
			x : 128, y : 128, w : 128, h : 64,

			text : 'PRESS ME!',
			align : TextAlign.center,
			align_vertical : TextAlign.center,
			text_size : 16,
			bounds_wrap : true,

			onclick : pressMeButton_onClickHandler,

			options : {
				defaultSkin : mintkha.ThemeTools.nineSliceSkin(themeAtlasTexture, themeAtlasModel, theme.buttonUpSkinId, theme.buttonNineSliceGrid),
				highlightSkin : mintkha.ThemeTools.nineSliceSkin(themeAtlasTexture, themeAtlasModel, theme.buttonHoverSkinId, theme.buttonNineSliceGrid),
				downSkin : mintkha.ThemeTools.nineSliceSkin(themeAtlasTexture, themeAtlasModel, theme.buttonDownSkinId, theme.buttonNineSliceGrid, theme.buttonDownOffset),
				disabledSkin : mintkha.ThemeTools.nineSliceSkin(themeAtlasTexture, themeAtlasModel, theme.buttonDisabledSkinId, theme.buttonNineSliceGrid),

				label : {
					defaultSkin : new mintkha.skin.ColoredLabelSkin(kha.Color.fromValue(0xff0b333c), pressMeButtonFont, new Offset(16, 16 + 0)),
					highlightSkin : new mintkha.skin.ColoredLabelSkin(kha.Color.fromValue(0xff0b333c), pressMeButtonFont, new Offset(16, 16 + 0)),
					downSkin : new mintkha.skin.ColoredLabelSkin(kha.Color.fromValue(0xff0b333c), pressMeButtonFont, new Offset(16, 16 + 5)),
					disabledSkin : new mintkha.skin.ColoredLabelSkin(kha.Color.fromValue(0xff5b6770), pressMeButtonFont, new Offset(16, 16 + 0)),
				}
			}
		});

		var oneSkinButtonFont = kha.Assets.fonts.kenvector_future_thin;

		oneSkinButton = new mint.Button({
			parent : canvas,
			x : 128, y : 16, w : 128, h : 64,

			text : 'ONE SKIN',
			align : TextAlign.center,
			align_vertical : TextAlign.center,
			text_size : 24,
			bounds_wrap : true,

			options : {
				defaultSkin : mintkha.ThemeTools.nineSliceSkin(themeAtlasTexture, themeAtlasModel, theme.buttonUpSkinId, theme.buttonNineSliceGrid),

				label : {
					defaultSkin : new mintkha.skin.ColoredLabelSkin(kha.Color.fromValue(0xff0b333c), oneSkinButtonFont, new Offset(16, 16 + 0)),
				}
			}
		});

		checkbox = new mint.Checkbox({
			parent : canvas,
			x : 384, y : 128, w : 38, h : 36,

			state : true,

			options : {
				defaultSkin : mintkha.ThemeTools.textureSkin(themeAtlasTexture, themeAtlasModel, theme.checkUpSkinId),
				highlightSkin : mintkha.ThemeTools.textureSkin(themeAtlasTexture, themeAtlasModel, theme.checkHoverSkinId),
				downSkin : mintkha.ThemeTools.textureSkin(themeAtlasTexture, themeAtlasModel, theme.checkDownSkinId),
				disabledSkin : mintkha.ThemeTools.textureSkin(themeAtlasTexture, themeAtlasModel, theme.checkDisabledSkinId),

				selectedDefaultSkin : mintkha.ThemeTools.textureSkin(themeAtlasTexture, themeAtlasModel, theme.checkSelectedUpSkinId),
				selectedHighlightSkin : mintkha.ThemeTools.textureSkin(themeAtlasTexture, themeAtlasModel, theme.checkSelectedHoverSkinId),
				selectedDownSkin : mintkha.ThemeTools.textureSkin(themeAtlasTexture, themeAtlasModel, theme.checkSelectedDownSkinId),
				selectedDisabledSkin : mintkha.ThemeTools.textureSkin(themeAtlasTexture, themeAtlasModel, theme.checkSelectedDisabledSkinId),
			}
		});

		progress = new mint.Progress({
			parent : canvas,
			x : 128, y : 256, w : 128, h : 16,

			options : {
				backgroundSkin : new mintkha.skin.ColoredRectSkin(kha.Color.fromBytes(128, 128, 128)),
				fillSkin : new mintkha.skin.ColoredRectSkin(kha.Color.Green),

				paddingTop : 4,
				paddingBottom : 4,
				paddingRight : 4,
				paddingLeft : 4,
			}
		});

		hslider = new mint.TrackSlider({
			parent : canvas,
			x : 128, y : 384, w : 256, h : 32,

			minimumValue : 0,
			maximumValue : 100,
			value : 25,
			//step : 10,

			trackOptions : {
				text : null,
				x : 0, y : 15, w : 256, h : 2,

				options : {
					defaultSkin : mintkha.ThemeTools.textureSkin(themeAtlasTexture, themeAtlasModel, theme.horizontalSliderTrackDefaultSkinId),

					//label : {} // TODO (DK) this seems unreasonable to have here
				}
			},

			handleOptions : {
				text : null,
				w : 28, h : 42,

				options : {
					defaultSkin : mintkha.ThemeTools.textureSkin(themeAtlasTexture, themeAtlasModel, theme.horizontalSliderHandleUpSkinId),
					highlightSkin : mintkha.ThemeTools.textureSkin(themeAtlasTexture, themeAtlasModel, theme.horizontalSliderHandleHoverSkinId),
					downSkin : mintkha.ThemeTools.textureSkin(themeAtlasTexture, themeAtlasModel, theme.horizontalSliderHandleDownSkinId),
					disabledSkin : mintkha.ThemeTools.textureSkin(themeAtlasTexture, themeAtlasModel, theme.horizontalSliderHandleDisabledSkinId),

					//label : {} // TODO (DK) this seems unreasonable to have here
				}
			},
		});

		vslider = new mint.TrackSlider({
			parent : canvas,
			x : 16, y : 16, w : 32, h : 256,

			vertical : true,
			minimumValue : 0,
			maximumValue : 100,
			value : 25,
			//step : 10,

			trackOptions : {
				text : null,
				x : 15, y : 0, w : 2, h : 253, // TODO (DK) -3px to compensate for the 3px handle shadow, is there a better way to do this?

				options : {
					defaultSkin : mintkha.ThemeTools.textureSkin(themeAtlasTexture, themeAtlasModel, theme.verticalSliderTrackDefaultSkinId),

					//label : {} // TODO (DK) this seems unreasonable to have here
				}
			},

			handleOptions : {
				text : null,
				w : 39, h : 31,

				options : {
					defaultSkin : mintkha.ThemeTools.textureSkin(themeAtlasTexture, themeAtlasModel, theme.verticalSliderHandleUpSkinId),
					highlightSkin : mintkha.ThemeTools.textureSkin(themeAtlasTexture, themeAtlasModel, theme.verticalSliderHandleHoverSkinId),
					downSkin : mintkha.ThemeTools.textureSkin(themeAtlasTexture, themeAtlasModel, theme.verticalSliderHandleDownSkinId),
					disabledSkin : mintkha.ThemeTools.textureSkin(themeAtlasTexture, themeAtlasModel, theme.verticalSliderHandleDisabledSkinId),

					//label : {} // TODO (DK) this seems unreasonable to have here
				}
			},
		});
	}

	var fbw(get, never) : Int;
	var fbh(get, never) : Int;

	inline function get_fbw() : Int {
		return kha.System.pixelWidth;
	}

	inline function get_fbh() : Int {
		return kha.System.pixelHeight;
	}

	function setupUiEvents() {
		var bbw = backbuffer.width;
		var bbh = backbuffer.height;

		kha.input.Mouse.get(0).notify(
			// down
			function( button : Int, x : Int, y : Int ) {
				//trace('${kha.System.time} down $button $x $y');

				canvas.mousedown({
					timestamp : kha.System.time,
					state : InteractState.down,
					button : MouseButton.left,
					x : kha.Scaler.transformXDirectly(x, y, fbw, fbh, bbw, bbh, kha.System.screenRotation),
					y : kha.Scaler.transformYDirectly(x, y, fbw, fbh, bbw, bbh, kha.System.screenRotation),
					yrel : 0,
					xrel : 0,
					bubble : true,
				});
			},

			// up
			function( button : Int, x : Int, y : Int ) {
				//trace('${kha.System.time} up $button $x $y');

				canvas.mouseup({
					timestamp : kha.System.time,
					state : InteractState.up,
					button : MouseButton.left,
					x : kha.Scaler.transformXDirectly(x, y, fbw, fbh, bbw, bbh, kha.System.screenRotation),
					y : kha.Scaler.transformYDirectly(x, y, fbw, fbh, bbw, bbh, kha.System.screenRotation),
					yrel : 0,
					xrel : 0,
					bubble : true,
				});
			},

			// move
			function( x : Int, y : Int, movementX : Int, movementY : Int ) {
				//trace('${kha.System.time} | move | $x $y | $movementX $movementY | $tx $ty');

				canvas.mousemove({
					timestamp : kha.System.time,
					state : InteractState.move,
					button : MouseButton.none,
					x : kha.Scaler.transformXDirectly(x, y, bbw, bbh, fbw, fbh, kha.System.screenRotation),
					y : kha.Scaler.transformYDirectly(x, y, bbw, bbh, fbw, fbh, kha.System.screenRotation),
					yrel : movementX,
					xrel : movementY,
					bubble : true,
				});
			},

			// wheel
			function( delta : Int ) {
			}
		);
	}
}

class Main {
	public static function main() {
		new SkinnedExample();
	}
}
