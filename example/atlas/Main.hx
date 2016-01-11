package;

import mint.types.Types.InteractState;
import mint.types.Types.MouseButton;
import mint.types.Types.TextAlign;

import mintkha.skin.NineSliceAtlasTextureSkin;

typedef MyTheme = mintkha.theme.MetalWorksMobileTheme;

class SkinnedExample {
	var backbuffer : kha.Image;
	var rendering : mintkha.G2Rendering;
	var focusManager : mint.focus.Focus;

	var themeAtlasModel : mintkha.support.TextureAtlas.AtlasModel;
	var themeAtlasTexture : kha.Image;

	var canvas : mint.Canvas;
	var progress : mint.Progress;

	var progressValue : Float = 0.0;

	public function new() {
		kha.System.init('mintkha-example-pretty', 512, 512, system_initializedHandler);
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
		themeAtlasModel = mintkha.support.StarlingAtlasXmlReader.read(Xml.parse(kha.Assets.blobs.metalworks_mobile_xml.toString()));
		themeAtlasTexture = kha.Assets.images.metalworks_mobile;
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

		var pressMeButton = new mint.Button({
			parent : canvas,
			x : 128, y : 128, w : 128, h : 64,

			text : 'PRESS ME!',
			align : TextAlign.center,
			align_vertical : TextAlign.center,
			text_size : 9,
			bounds_wrap : true,

			options : {
				defaultSkin : mintkha.ThemeTools.nineSliceSkin(themeAtlasTexture, themeAtlasModel, MyTheme.buttonUpSkinId, MyTheme.buttonNineSliceGrid),
				highlightSkin : mintkha.ThemeTools.nineSliceSkin(themeAtlasTexture, themeAtlasModel, MyTheme.buttonHoverSkinId, MyTheme.buttonNineSliceGrid),
				downSkin : mintkha.ThemeTools.nineSliceSkin(themeAtlasTexture, themeAtlasModel, MyTheme.buttonDownSkinId, MyTheme.buttonNineSliceGrid),
				disabledSkin : mintkha.ThemeTools.nineSliceSkin(themeAtlasTexture, themeAtlasModel, MyTheme.buttonDisabledSkinId, MyTheme.buttonNineSliceGrid),
				depth : 1,

				label : {
//					font : Reflect.field(kha.Assets.fonts, 'Berlin Sans FB Demi Bold'),//.nokiafc22,
					font : Reflect.field(kha.Assets.fonts, 'consola'),//.nokiafc22,
					defaultSkin : kha.Color.fromValue(0xff0b333c),
					highlightSkin : kha.Color.fromValue(0xff0b333c),
					downSkin : kha.Color.fromValue(0xff0b333c),
					disabledSkin : kha.Color.fromValue(0xff5b6770),
					depth : 0,
				}
			}
		});

		//var checkbox = new mint.Checkbox({
			//parent : canvas,
			//x : 384, y : 128, w : 128, h : 16,
		//});

		progress = new mint.Progress({
			parent : canvas,
			x : 128, y : 256, w : 128, h : 16,

			options : {
				backgroundSkin : kha.Color.fromBytes(128, 128, 128),
				fillSkin : kha.Color.Green,

				paddingTop : 4,
				paddingBottom : 4,
				paddingRight : 4,
				paddingLeft : 4,
			}
		});

		var helloLabel = new mint.Label({
			parent : canvas,
			x : 128, y : 304, w : 128, h : 16,

			text : 'Hello World!',
			text_size : 24,

			options : {
				font : kha.Assets.fonts.nokiafc22,
				defaultSkin : kha.Color.Black,
				highlightSkin : kha.Color.Yellow,
				downSkin : kha.Color.Green,
				disabledSkin : kha.Color.fromBytes(128, 128, 128),
			}
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
