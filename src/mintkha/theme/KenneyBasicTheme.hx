package mintkha.theme;

import mintkha.support.Offset;
import mintkha.support.Rectangle;

class KenneyBasicTheme {
    public var buttonNineSliceGrid : Rectangle = new Rectangle(6, 22, 38, 1);

	public var buttonUpSkinId = 'tiles/blue_button09';
	public var buttonHoverSkinId = 'tiles/yellow_button09';
	public var buttonDownSkinId = 'tiles/green_button10';
	public var buttonDisabledSkinId = 'tiles/grey_button11';

	public var buttonDownOffset = new Offset(0, 5);

    public var checkNineSliceGrid : Rectangle = new Rectangle(10, 10, 18, 18);

	public var checkUpSkinId = 'tiles/blue_boxCross';
	public var checkHoverSkinId = 'tiles/yellow_boxCross';
	public var checkDownSkinId = 'tiles/green_boxCheckmark';
	public var checkDisabledSkinId = 'tiles/grey_boxCross';

	public var checkSelectedUpSkinId = 'tiles/blue_boxCheckmark';
	public var checkSelectedHoverSkinId = 'tiles/yellow_boxCheckmark';
	public var checkSelectedDownSkinId = 'tiles/green_boxCross';
	public var checkSelectedDisabledSkinId = 'tiles/grey_boxCheckmark';

	public var horizontalSliderHandleUpSkinId = 'tiles/blue_sliderDown';
	public var horizontalSliderHandleHoverSkinId = 'tiles/yellow_sliderDown';
	public var horizontalSliderHandleDownSkinId = 'tiles/green_sliderDown';
	public var horizontalSliderHandleDisabledSkinId = 'tiles/grey_sliderDown';

	public var horizontalSliderTrackDefaultSkinId = 'tiles/grey_sliderHorizontal';

	public var verticalSliderHandleUpSkinId = 'tiles/blue_sliderRight';
	public var verticalSliderHandleHoverSkinId = 'tiles/yellow_sliderRight';
	public var verticalSliderHandleDownSkinId = 'tiles/green_sliderRight';
	public var verticalSliderHandleDisabledSkinId = 'tiles/grey_sliderRight';

	public var verticalSliderTrackDefaultSkinId = 'tiles/grey_sliderVertical';

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
