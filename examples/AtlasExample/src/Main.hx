package;

import mint.types.Types.InteractState;
import mint.types.Types.MouseButton;
import mint.types.Types.TextAlign;
import mintkha.skin.ColoredLabelSkin;
import mintkha.skin.ColoredRectangleSkin;
import mintkha.support.Offset;
import mintkha.support.StarlingAtlasXmlReader;
import mintkha.ThemeTools;

class AtlasExample {
	var backbuffer : kha.Image;
	var rendering : mintkha.G2Rendering;
	var focusManager : mint.focus.Focus;

	var themeAtlasModel : mintkha.support.TextureAtlas.AtlasModel;
	var themeAtlasTexture : kha.Image;

	var canvas : mint.Canvas;
	var progress : mint.Progress;
	var button1 : mint.Button;
	var button2 : mint.Button;
	var checkbox : mint.Checkbox;
	var hslider : mint.TrackSlider;
	var vslider : mint.TrackSlider;

	var progressValue : Float = 0.0;

	var theme = mintkha.theme.KenneyBasicTheme.blueTheme;

	//var spriterEngine : spriter.engine.SpriterEngine;
	//var spriterLibrary : spriter.library.KhaG2Library;
	//var assetProvider : spriter.library.KhaG2Library.AssetProvider;

	public function new() {
		kha.System.init( { title : 'AtlasExample', width : 512, height : 512 }, kha.Assets.loadEverything.bind(assets_loadedHandler));
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

		//progress.progress = progressValue;

/*		if (spriterEngine != null) {
			spriterEngine.update();
		}
*/	}

    function render( framebuffer : kha.Framebuffer ) {
		var g = backbuffer.g2;

		g.begin(true, kha.Color.fromBytes(0, 64, 64));
			rendering.renderG2(g);
			//spriterLibrary.renderimpl(g);
		g.end();

		g = framebuffer.g2;

		g.begin();
			kha.Scaler.scale(backbuffer, framebuffer, kha.System.screenRotation);
		g.end();
	}

	function setupTheme() {
		var assets = kha.Assets;
		themeAtlasModel = StarlingAtlasXmlReader.read(Xml.parse(assets.blobs.basic_atlas_xml.toString()));
		themeAtlasTexture = assets.images.basic_sheet;

		//assetProvider = new mintkha.support.AtlasImageProvider(themeAtlasTexture, themeAtlasModel);
		//spriterLibrary = new spriter.library.KhaG2Library(assetProvider);
		//spriterEngine = new spriter.engine.SpriterEngine(assets.blobs.basic_spriterSkins_scml.toString(), null, spriterLibrary);
	}

	function hslider_onChangeHandler( value : Float ) {
		button1.w = 128 + value / 100 * 64;
	}

	function pressMeButton_onClickHandler( _1, _2 ) {
		trace('pressMeButton_onClickHandler');

		if (checkbox == null) { // TODO (DK) remove me once all demo controls are active again
			return;
		}

		checkbox.state = !checkbox.state;

		if (button1.label.text == 'PRESS ME!') {
			button1.label.text = 'YAY!';
		} else {
			button1.label.text = 'PRESS ME!';
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

        focusManager = new mint.focus.Focus(canvas);

		setupButton1();
		setupCheckbox();
		createHorizontalTrackSlider();
	}

	function setupButton1() {
		var font = kha.Assets.fonts.kenvector_future_thin;

		var bro : mintkha.renderer.ButtonRendererOptions = {
			defaultSkin : ThemeTools.ninesliceSubImageSkin(themeAtlasTexture, themeAtlasModel, theme.buttonUpSkinId, theme.buttonNineSliceGrid),
			highlightSkin : ThemeTools.ninesliceSubImageSkin(themeAtlasTexture, themeAtlasModel, theme.buttonHoverSkinId, theme.buttonNineSliceGrid),
			downSkin : ThemeTools.ninesliceSubImageSkin(themeAtlasTexture, themeAtlasModel, theme.buttonDownSkinId, theme.buttonNineSliceGrid, theme.buttonDownOffset),
			disabledSkin : ThemeTools.ninesliceSubImageSkin(themeAtlasTexture, themeAtlasModel, theme.buttonDisabledSkinId, theme.buttonNineSliceGrid),
		}

		var lro : mintkha.renderer.LabelRendererOptions = {
			defaultSkin : new ColoredLabelSkin(kha.Color.fromValue(0xff0b333c), font, new Offset(16, 16 + 0)),
			highlightSkin : new ColoredLabelSkin(kha.Color.fromValue(0xff0b333c), font, new Offset(16, 16 + 0)),
			downSkin : new ColoredLabelSkin(kha.Color.fromValue(0xff0b333c), font, new Offset(16, 16 + 5)),
			disabledSkin : new ColoredLabelSkin(kha.Color.fromValue(0xff5b6770), font, new Offset(16, 16 + 0)),
		}

		var bo : mint.Button.ButtonOptions = {
			parent : canvas,
			x : 128, y : 128, w : 128, h : 64,

			label : {
				text : 'PRESS ME!',
				align : TextAlign.center,
				align_vertical : TextAlign.center,
				text_size : 16,
				bounds_wrap : true,

				options : lro,
			},

			onclick : pressMeButton_onClickHandler,
			options : bro,
		};

		button1 = new mint.Button(bo);
	}

/*		var oneSkinButtonFont = kha.Assets.fonts.kenvector_future_thin;

		oneSkinButton = new mint.Button({
			parent : canvas,
			x : 128, y : 16, w : 128, h : 64,

			text : 'ONE SKIN',
			align : TextAlign.center,
			align_vertical : TextAlign.center,
			text_size : 24,
			bounds_wrap : true,

			options : {
				defaultSkin : ThemeTools.ninesliceSubImageSkin(themeAtlasTexture, themeAtlasModel, theme.buttonUpSkinId, theme.buttonNineSliceGrid),

				label : {
					defaultSkin : new ColoredLabelSkin(kha.Color.fromValue(0xff0b333c), oneSkinButtonFont, new Offset(16, 16 + 0)),
				}
			}
		});
*/

	function setupCheckbox() {
		var cbro : mintkha.renderer.CheckboxRendererOptions = {
			defaultSkin : ThemeTools.subImageSkin(themeAtlasTexture, themeAtlasModel, theme.checkUpSkinId),
			highlightSkin : ThemeTools.subImageSkin(themeAtlasTexture, themeAtlasModel, theme.checkHoverSkinId),
			downSkin : ThemeTools.subImageSkin(themeAtlasTexture, themeAtlasModel, theme.checkDownSkinId),
			disabledSkin : ThemeTools.subImageSkin(themeAtlasTexture, themeAtlasModel, theme.checkDisabledSkinId),

			selectedDefaultSkin : ThemeTools.subImageSkin(themeAtlasTexture, themeAtlasModel, theme.checkSelectedUpSkinId),
			selectedHighlightSkin : ThemeTools.subImageSkin(themeAtlasTexture, themeAtlasModel, theme.checkSelectedHoverSkinId),
			selectedDownSkin : ThemeTools.subImageSkin(themeAtlasTexture, themeAtlasModel, theme.checkSelectedDownSkinId),
			selectedDisabledSkin : ThemeTools.subImageSkin(themeAtlasTexture, themeAtlasModel, theme.checkSelectedDisabledSkinId),
		}

		var cbo : mint.Checkbox.CheckboxOptions = {
			parent : canvas,
			x : 384, y : 128, w : 38, h : 36,

			state : true,

			options : cbro,
		}

		checkbox = new mint.Checkbox(cbo);
	}

	function createHorizontalTrackSlider() {
		var tro : mintkha.renderer.ButtonRendererOptions = {
			defaultSkin : ThemeTools.subImageSkin(themeAtlasTexture, themeAtlasModel, theme.horizontalSliderTrackDefaultSkinId),
		}

		var to : mint.Button.ButtonOptions = {
			x : 0, y : 15, w : 256, h : 2,

			options : tro,
			label : { text : null }, // TODO (DK) remove me
		}

		var hro : mintkha.renderer.ButtonRendererOptions = {
			defaultSkin : ThemeTools.subImageSkin(themeAtlasTexture, themeAtlasModel, theme.horizontalSliderHandleUpSkinId),
			highlightSkin : ThemeTools.subImageSkin(themeAtlasTexture, themeAtlasModel, theme.horizontalSliderHandleHoverSkinId),
			downSkin : ThemeTools.subImageSkin(themeAtlasTexture, themeAtlasModel, theme.horizontalSliderHandleDownSkinId),
			disabledSkin : ThemeTools.subImageSkin(themeAtlasTexture, themeAtlasModel, theme.horizontalSliderHandleDisabledSkinId),
		}

		var ho : mint.Button.ButtonOptions = {
			w : 28, h : 42,

			options : hro,
			label : { text : null }, // TODO (DK) remove me
		}

		var tso : mint.TrackSliderOptions = {
			parent : canvas,
			x : 128, y : 384, w : 256, h : 32,

			minimumValue : 0,
			maximumValue : 100,
			value : 0,
			//step : 10,

			trackOptions : to,
			handleOptions : ho,
		}

		hslider = new mint.TrackSlider(tso);
		hslider.onchange.listen(hslider_onChangeHandler);
	}

/*
		progress = new mint.Progress({
			parent : canvas,
			x : 128, y : 256, w : 128, h : 16,

			options : {
				backgroundSkin : new ColoredRectangleSkin(kha.Color.fromBytes(128, 128, 128)),
				fillSkin : new ColoredRectangleSkin(kha.Color.Green),

				paddingTop : 4,
				paddingBottom : 4,
				paddingRight : 4,
				paddingLeft : 4,
			}
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
					defaultSkin : ThemeTools.subImageSkin(themeAtlasTexture, themeAtlasModel, theme.verticalSliderTrackDefaultSkinId),

					//label : {} // TODO (DK) this seems unreasonable to have here
				}
			},

			handleOptions : {
				text : null,
				w : 39, h : 31,

				options : {
					defaultSkin : ThemeTools.subImageSkin(themeAtlasTexture, themeAtlasModel, theme.verticalSliderHandleUpSkinId),
					highlightSkin : ThemeTools.subImageSkin(themeAtlasTexture, themeAtlasModel, theme.verticalSliderHandleHoverSkinId),
					downSkin : ThemeTools.subImageSkin(themeAtlasTexture, themeAtlasModel, theme.verticalSliderHandleDownSkinId),
					disabledSkin : ThemeTools.subImageSkin(themeAtlasTexture, themeAtlasModel, theme.verticalSliderHandleDisabledSkinId),

					//label : {} // TODO (DK) this seems unreasonable to have here
				}
			},
		});
*/
/*		var animatedButton = new mint.Button({
			parent : canvas,
			x : 128, y : 128, w : 128, h : 64,

			text : 'ANIMATED!',
			align : TextAlign.center,
			align_vertical : TextAlign.center,
			text_size : 16,
			bounds_wrap : true,

			//onclick : pressMeButton_onClickHandler,

			options : {
				defaultSkin : ThemeTools.ninesliceSubImageSkin(themeAtlasTexture, themeAtlasModel, theme.buttonUpSkinId, theme.buttonNineSliceGrid),
				highlightSkin : new mintkha.skin.SpriterEntitySkin(spriterEngine, 'blue', 'highlight', new Offset(64, 32)),
				//highlightSkin : ThemeTools.ninesliceSubImageSkin(themeAtlasTexture, themeAtlasModel, theme.buttonHoverSkinId, theme.buttonNineSliceGrid),
				downSkin : ThemeTools.ninesliceSubImageSkin(themeAtlasTexture, themeAtlasModel, theme.buttonDownSkinId, theme.buttonNineSliceGrid, theme.buttonDownOffset),
				disabledSkin : ThemeTools.ninesliceSubImageSkin(themeAtlasTexture, themeAtlasModel, theme.buttonDisabledSkinId, theme.buttonNineSliceGrid),

				label : {
					defaultSkin : new ColoredLabelSkin(kha.Color.fromValue(0xff0b333c), pressMeButtonFont, new Offset(16, 16 + 0)),
					highlightSkin : new ColoredLabelSkin(kha.Color.fromValue(0xff0b333c), pressMeButtonFont, new Offset(16, 16 + 0)),
					downSkin : new ColoredLabelSkin(kha.Color.fromValue(0xff0b333c), pressMeButtonFont, new Offset(16, 16 + 5)),
					disabledSkin : new ColoredLabelSkin(kha.Color.fromValue(0xff5b6770), pressMeButtonFont, new Offset(16, 16 + 0)),
				}
			}
		});
	}
*/
	var fbw(get, never) : Int;
	var fbh(get, never) : Int;

	inline function get_fbw() : Int {
		return kha.System.windowWidth(0);
	}

	inline function get_fbh() : Int {
		return kha.System.windowHeight(0);
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
		new AtlasExample();
	}
}
