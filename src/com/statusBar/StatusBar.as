
package com.statusBar
{
	import flash.display.Sprite;
	
	
	/**
	 * [Description]
	 *
	 * @author G$
	 * @since Jan 29, 2011
	 */
	public class StatusBar extends Sprite
	{
		
		//--------------------------------------
		// CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// VARIABLES
		//--------------------------------------
		private var _cashMoniesBg:StatusBg;
		private var _killBoxBg:StatusBg;
		private var _toolBoxBg:StatusBg;
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		public function StatusBar()
		{
			super();
			
			var cornerRadius:uint = 56;
			
			// - CASH MONIES -
			_cashMoniesBg = new StatusBg(145, 98, cornerRadius);
			_cashMoniesBg.x = 105;
			_cashMoniesBg.y = 662;
			addChild(_cashMoniesBg);
			
			// - KILL BOX -
			_killBoxBg = new StatusBg(165, 98, cornerRadius);
			_killBoxBg.x = 267;
			_killBoxBg.y = 662;
			addChild(_killBoxBg);
			
			// - TOOL BOX -
			_toolBoxBg = new StatusBg(434, 98, cornerRadius);
			_toolBoxBg.x = 495;
			_toolBoxBg.y = 662;
			addChild(_toolBoxBg);
		}
		
		//--------------------------------------
		// PROTECTED & PRIVATE METHODS
		//--------------------------------------	
		
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		
		//--------------------------------------
		// EVENT HANDLERS
		//--------------------------------------							
		
		
	}
}