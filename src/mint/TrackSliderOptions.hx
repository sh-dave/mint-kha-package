package mint;

typedef TrackSliderOptions = {
    > mint.Control.ControlOptions,

    @:optional var vertical : Bool;

    @:optional var minimumValue : Float;
    @:optional var maximumValue : Float;
    @:optional var value : Float;
    @:optional var step : Null<Float>;

	var trackOptions : mint.Button.ButtonOptions;
	var handleOptions : mint.Button.ButtonOptions;
}
