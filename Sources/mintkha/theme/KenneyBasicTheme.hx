package mintkha.theme;

import mintkha.support.Offset;
import mintkha.support.Rectangle;

class KenneyBasicTheme {
    public var buttonNineSliceGrid : Rectangle = new Rectangle(6, 22, 38, 1);

	public var buttonUpSkinId = 'blue_button09';
	public var buttonHoverSkinId = 'yellow_button09';
	public var buttonDownSkinId = 'green_button10';
	public var buttonDisabledSkinId = 'grey_button11';

	public var buttonDownOffset = new Offset(0, 5);

    public var checkNineSliceGrid : Rectangle = new Rectangle(10, 10, 18, 18);

	public var checkUpSkinId = 'blue_boxCross';
	public var checkHoverSkinId = 'yellow_boxCross';
	public var checkDownSkinId = 'green_boxCheckmark';
	public var checkDisabledSkinId = 'grey_boxCross';

	public var checkSelectedUpSkinId = 'blue_boxCheckmark';
	public var checkSelectedHoverSkinId = 'yellow_boxCheckmark';
	public var checkSelectedDownSkinId = 'green_boxCross';
	public var checkSelectedDisabledSkinId = 'grey_boxCheckmark';

	public var sliderHandleUpSkinId = 'blue_sliderDown';
	public var sliderHandleHoverSkinId = 'yellow_sliderDown';
	public var sliderHandleDownSkinId = 'green_sliderDown';
	public var sliderHandleDisabledSkinId = 'grey_sliderDown';

	public var sliderTrackDefaultSkinId = 'grey_sliderHorizontal';
	//public var sliderStartTrackDefaultSkinId = 'grey_sliderEnd';
	//public var sliderEndTrackDefaultSkinId = 'grey_sliderEnd';

	// 49x49 -> 49x45
	//pressed: 5; 22; 39; 1
	//public var buttonUpSkinId = 'button-up-skin';
	//public var buttonHoverSkinId = 'button-up-skin';
	//public var buttonDownSkinId = 'button-down-skin';
	//public var buttonDisabledSkinId = 'button-disabled-skin';

	public function new( color : String ) {

	}

	public static var redTheme = new KenneyBasicTheme('red');
	public static var greenTheme = new KenneyBasicTheme('green');
	public static var blueTheme = new KenneyBasicTheme('blue');
	public static var yellowTheme = new KenneyBasicTheme('yellow');
	//public static var greyTheme = new KenneyBasicTheme('grey');
}
