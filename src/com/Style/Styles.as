
package com.Style
{
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * [Description]
	 *
	 * @author G$
	 * @since Jan 29, 2011
	 */
	public class Styles
	{
		public function Styles()
		{
		}						
		
		//--------------------------------------
		// COLORS
		//--------------------------------------
		public static const ALMOST_BLACK:uint = 0x231F20;
		public static const DARK_GRAY:uint = 0x333333;
		public static const LIGHTER_THAN_DARK_GRAY:uint = 0x433E3B;
		public static const ALMOST_GREEN:uint = 0x4B5044;
		public static const REALLY_GREEN:uint = 0x36B454;
		public static const REALLY_RED:uint = 0xC63D36;
		
		//--------------------------------------
		// FONTS
		//--------------------------------------
		public static const TRANSPONDER:String = 'TransponderAOE';
		
		//--------------------------------------
		// TEXT FORMAT
		//--------------------------------------
		public static const PANEL_TF:TextFormat = new TextFormat(TRANSPONDER, 28, REALLY_GREEN, null, null, null, null, null, TextFormatAlign.CENTER);
		public static const PANEL_TF_L:TextFormat = new TextFormat(TRANSPONDER, 28, REALLY_GREEN, null, null, null, null, null, TextFormatAlign.LEFT);
		public static const OVERLAY_TF:TextFormat = new TextFormat(TRANSPONDER, 20, REALLY_GREEN, null, null, null, null, null, TextFormatAlign.CENTER);
		public static const OVERLAY_ERROR_TF:TextFormat = new TextFormat(TRANSPONDER, 20, REALLY_RED, null, null, null, null, null, TextFormatAlign.CENTER);
		
		//--------------------------------------
		// FILTERS
		//--------------------------------------
		public static const SCREEN_INNER_GLOW:GlowFilter = new GlowFilter(REALLY_GREEN, 1, 10, 10, 1, 5, true);
		public static const SCREEN_GLOW:GlowFilter = new GlowFilter(REALLY_GREEN, .5, 5, 5, 2, 5);
		public static const OVERLAY_DROP:DropShadowFilter = new DropShadowFilter(2, 0, 0, .7, 4, 4);
	}
}