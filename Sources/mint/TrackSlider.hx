package mint;

import mint.Button;
import mint.Control;
import mint.Panel;
import mint.types.Types;
import mint.core.Signal;
import mint.types.Types.Helper;
import mint.core.Macros.*;

typedef TrackSliderOptions = {
    > ControlOptions,

    @:optional var vertical : Bool;

    @:optional var minimumValue : Float;
    @:optional var maximumValue : Float;
    @:optional var value : Float;
    @:optional var step : Null<Float>;

	var trackOptions : ButtonOptions;
	var handleOptions : ButtonOptions;
}

@:allow(mint.render.Renderer)
class TrackSlider extends Control {
	// TODO (DK) do we need to handle them changing => implement as setter property?
    public var minimum = 0.0;
    public var maximum = 1.0;
    public var value(get, set) : Float;
    public var step : Null<Float>;
    public var vertical = false;

    public var onchange : Signal<Float->Void> = new Signal();

    var options : TrackSliderOptions;

	var track : Button;
	var handle : Button;

	var _value : Float = 1.0;
	var range(get, never) : Float;
    var dragging = false;
	var dragX = 0;
	var dragY = 0;

    public function new( options : TrackSliderOptions ) {
        this.options = options;

        def(options.name, 'trackslider');
        def(options.mouse_input, true);

        minimum = def(options.minimumValue, 0.0);
        maximum = def(options.maximumValue, 1.0);
        _value = def(options.value, maximum);
        vertical = def(options.vertical, false);
        step = options.step;

        super(options);

		options.trackOptions.parent = this;
		options.trackOptions.name = '${name}.track';
		track = new Button(options.trackOptions);
		track.onmousedown.listen(track_mouseDownHandler);
		track.onmouseup.listen(track_mouseUpHandler);
		track.onmousemove.listen(track_mouseMoveHandler);

		options.handleOptions.parent = this;
		options.handleOptions.name = '${name}.handle';
		handle = new Button(options.handleOptions);
		handle.onmousedown.listen(handle_mouseDownHandler);
		handle.onmouseup.listen(handle_mouseUpHandler);
		handle.onmousemove.listen(handle_mouseMoveHandler);

        renderer = rendering.get(TrackSlider, this);

        oncreate.emit();

        updateValue(value);
    }

	function track_mouseDownHandler( event : MouseEvent, control : Control ) {
	}

	function track_mouseUpHandler( event : MouseEvent, control : Control ) {
	}

	function track_mouseMoveHandler( event : MouseEvent, control : Control ) {
	}

	function handle_mouseDownHandler( event : MouseEvent, control : Control ) {
		if (!dragging) {
			dragging = true;
			dragX = event.x;
			dragY = event.y;
		}

		//handle.focus();
	}

	function handle_mouseUpHandler( event : MouseEvent, control : Control ) {
		if (dragging) {
			dragging = false;
		}

		//handle.unfocus();
	}

	function handle_mouseMoveHandler( event : MouseEvent, control : Control ) {
		if (dragging) {
			updateValueFromMouse(event);
		}
	}

    function updateValue( value : Float ) {
        value = Helper.clamp(value, minimum, maximum);

        if (step != null) {
            value = Math.round(value / step) * step;
        }

		if (vertical) {
			var vrange = h - handle.h;
			handle.y_local = vrange * (value / range);
		} else {
			var hrange = w - handle.w;
			handle.x_local = hrange * (value / range);
		}

		_value = value;
        onchange.emit(value);
		trace(_value);
    }

	inline function get_value() : Float {
		return _value;
	}

    inline function set_value( value : Float ) : Float {
        updateValue(value);
        return _value;
    }

	inline function get_range() : Float {
		return maximum - minimum;
	}

    inline function updateValueFromMouse( event : MouseEvent ) {
        if (vertical) {
            var dy = event.y - y;
            var v = (dy / h) * range + minimum;
            updateValue(v);
        } else {
            var dx = event.x - x;
            var v = (dx / w) * range + minimum;
            updateValue(v);
        }
    }
}
