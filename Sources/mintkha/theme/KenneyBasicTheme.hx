package mintkha.theme;

import mintkha.support.Offset;
import mintkha.support.Rectangle;

class KenneyBasicTheme {
    public var buttonNineSliceGrid : Rectangle = new Rectangle(6, 22, 38, 1);

	public var buttonUpSkinId = 'blue_button09';
	public var buttonHoverSkinId = 'blue_button07';
	public var buttonDownSkinId = 'blue_button10';
	public var buttonDisabledSkinId = 'grey_button11';

	public var buttonDownOffset = new Offset(0, 5);

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
