package mintkha.theme;

import mintkha.support.Offset;
import mintkha.support.Rectangle;

class KenneyBasicTheme {
	public static var redTheme = new KenneyBasicThemeImpl('red', 'yellow', 'blue', 'grey');
	public static var greenTheme = new KenneyBasicThemeImpl('green', 'yellow', 'red', 'grey');
	public static var blueTheme = new KenneyBasicThemeImpl('blue', 'yellow', 'green', 'grey');
	public static var yellowTheme = new KenneyBasicThemeImpl('yellow', 'blue', 'red', 'grey');
}

private class KenneyBasicThemeImpl {
    public var buttonNineSliceGrid : Rectangle = new Rectangle(6, 22, 38, 1);
	public var buttonDownOffset = new Offset(0, 5);
    public var checkNineSliceGrid : Rectangle = new Rectangle(10, 10, 18, 18);

	public var buttonUpSkinId : String;
	public var buttonHoverSkinId : String;
	public var buttonDownSkinId : String;
	public var buttonDisabledSkinId : String;

	public var checkUpSkinId : String;
	public var checkHoverSkinId : String;
	public var checkDownSkinId : String;
	public var checkDisabledSkinId : String;

	public var checkSelectedUpSkinId : String;
	public var checkSelectedHoverSkinId : String;
	public var checkSelectedDownSkinId : String;
	public var checkSelectedDisabledSkinId : String;

	public var horizontalSliderHandleUpSkinId : String;
	public var horizontalSliderHandleHoverSkinId : String;
	public var horizontalSliderHandleDownSkinId : String;
	public var horizontalSliderHandleDisabledSkinId : String;

	public var horizontalSliderTrackDefaultSkinId : String;

	public var verticalSliderHandleUpSkinId : String;
	public var verticalSliderHandleHoverSkinId : String;
	public var verticalSliderHandleDownSkinId : String;
	public var verticalSliderHandleDisabledSkinId : String;

	public var verticalSliderTrackDefaultSkinId : String;

	//public var sliderStartTrackDefaultSkinId = 'grey_sliderEnd';
	//public var sliderEndTrackDefaultSkinId = 'grey_sliderEnd';

	// 49x49 -> 49x45
	//pressed: 5; 22; 39; 1
	//public var buttonUpSkinId = 'button-up-skin';
	//public var buttonHoverSkinId = 'button-up-skin';
	//public var buttonDownSkinId = 'button-down-skin';
	//public var buttonDisabledSkinId = 'button-disabled-skin';

	public function new( def : String, hov : String, down : String, dis : String ) {
		buttonUpSkinId = 'tiles/${def}_button09';
		buttonHoverSkinId = 'tiles/${hov}_button09';
		buttonDownSkinId = 'tiles/${down}_button10';
		buttonDisabledSkinId = 'tiles/${dis}_button11';

		checkUpSkinId = 'tiles/${def}_boxCross';
		checkHoverSkinId = 'tiles/${hov}_boxCross';
		checkDownSkinId = 'tiles/${down}_boxCheckmark';
		checkDisabledSkinId = 'tiles/${dis}_boxCross';

		checkSelectedUpSkinId = 'tiles/${def}_boxCheckmark';
		checkSelectedHoverSkinId = 'tiles/${hov}_boxCheckmark';
		checkSelectedDownSkinId = 'tiles/${down}_boxCross';
		checkSelectedDisabledSkinId = 'tiles/${dis}_boxCheckmark';

		horizontalSliderHandleUpSkinId = 'tiles/${def}_sliderDown';
		horizontalSliderHandleHoverSkinId = 'tiles/${hov}_sliderDown';
		horizontalSliderHandleDownSkinId = 'tiles/${down}_sliderDown';
		horizontalSliderHandleDisabledSkinId = 'tiles/${dis}_sliderDown';

		horizontalSliderTrackDefaultSkinId = 'tiles/grey_sliderHorizontal';

		verticalSliderHandleUpSkinId = 'tiles/${def}_sliderRight';
		verticalSliderHandleHoverSkinId = 'tiles/${hov}_sliderRight';
		verticalSliderHandleDownSkinId = 'tiles/${down}_sliderRight';
		verticalSliderHandleDisabledSkinId = 'tiles/${dis}_sliderRight';

		verticalSliderTrackDefaultSkinId = 'tiles/grey_sliderVertical';
	}
}
