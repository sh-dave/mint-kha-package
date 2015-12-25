package;

import mint.types.Types.InteractState;
import mint.types.Types.MouseButton;
import mint.types.Types.TextAlign;
import mintkha.G2Rendering;

class Main {
	public static function main() {
		kha.System.init('mintkha-example-coloronly', 800, 600, system_initializedHandler);
	}

	static function system_initializedHandler() {
		kha.Assets.loadEverything(assets_loadedHandler);
	}

	static function assets_loadedHandler() {
		setupUi();
		setupUiEvents();
		kha.System.notifyOnRender(render);
		kha.Scheduler.addTimeTask(update, 0, 1 / 60);
	}

	static function update() {
		progressValue += 0.01;

		if (progressValue >= 1.0) {
			progressValue -= 1.0;
		}

		progress.progress = progressValue;
	}

    static function render( framebuffer : kha.Framebuffer ) {
		var g = backbuffer.g2;

		g.begin(true, kha.Color.fromBytes(0, 64, 64));
			rendering.renderG2(g);
		g.end();

		g = framebuffer.g2;

		g.begin();
			kha.Scaler.scale(backbuffer, framebuffer, kha.System.screenRotation);
		g.end();
	}

	static function setupUi() {
		backbuffer = kha.Image.createRenderTarget(512, 512);
		rendering = new G2Rendering();

		canvas = new mint.Canvas({
			rendering : rendering,
			mouse_input : true,
			key_input : true,
		});

        focusManager = new mint.focus.Focus(canvas);

		var pressMeButton = new mint.Button({
			parent : canvas,
			x : 128, y : 128, w : 128, h : 32,

			text : 'PRESS ME!',
			align : TextAlign.center,
			align_vertical : TextAlign.center,
			text_size : 16,
			bounds_wrap : true,

			options : {
				defaultSkin : kha.Color.Green,
				highlightSkin : kha.Color.Yellow,
				downSkin : kha.Color.Red,
				disabledSkin : kha.Color.fromBytes(128, 128, 128),

				label : {
					font : kha.Assets.fonts.nokiafc22,
					defaultSkin : kha.Color.Black,
					highlightSkin : kha.Color.Black,
					downSkin : kha.Color.Black,
					disabledSkin : kha.Color.Black,
				}
			}
		});

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

			options : {
				font : kha.Assets.fonts.nokiafc22,
				defaultSkin : kha.Color.Black,
				highlightSkin : kha.Color.Yellow,
				downSkin : kha.Color.Green,
				disabledSkin : kha.Color.fromBytes(128, 128, 128),
			}
		});
	}

	static var fbw(get, never) : Int;
	static var fbh(get, never) : Int;

	inline static function get_fbw() : Int {
		return kha.System.pixelWidth;
	}

	inline static function get_fbh() : Int {
		return kha.System.pixelHeight;
	}

	static function setupUiEvents() {
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

	static var backbuffer : kha.Image;
	static var rendering : G2Rendering;
	static var focusManager : mint.focus.Focus;

	static var canvas : mint.Canvas;
	static var progress : mint.Progress;

	static var progressValue : Float = 0.0;
}
