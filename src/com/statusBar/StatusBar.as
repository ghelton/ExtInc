
package com.statusBar
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	
	
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
		private var _fullScreenButton:StatusBg;
		
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
			
			// - FS BUTTON -
			_fullScreenButton = new StatusBg(25, 25, cornerRadius);
			_fullScreenButton.x = 950;
			_fullScreenButton.y = 700;
			addChild(_fullScreenButton);
			_fullScreenButton.addEventListener(MouseEvent.CLICK, onFsClick);
			_fullScreenButton.buttonMode = true;
			
		}
		
		//--------------------------------------
		// PROTECTED & PRIVATE METHODS
		//--------------------------------------	
		private function onFsClick(e:MouseEvent):void
		{
			if(stage.displayState == StageDisplayState.NORMAL)
			{
				stage.displayState = StageDisplayState.FULL_SCREEN;
			} else {
				stage.displayState = StageDisplayState.NORMAL;
			}
		}
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		
		//--------------------------------------
		// EVENT HANDLERS
		//--------------------------------------							
		
		
	}
}