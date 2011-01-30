
package com.statusBar
{
	import com.Style.Styles;
	
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	
	/**
	 * [Description]
	 *
	 * @author G$
	 * @since Jan 30, 2011
	 */
	public class StatusOverlay extends Sprite
	{
		
		//--------------------------------------
		// CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// VARIABLES
		//--------------------------------------
		private var _width:Number = 925;
		private var _height:Number = 603;
		
		private var _message:TextField;
		private var _killTimer:Timer;
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		public function StatusOverlay()
		{
			super();
			
			graphics.lineStyle(2, Styles.REALLY_GREEN, 1, true);
			graphics.beginFill(0x000000, .7);
			graphics.drawRect(0, 0, _width, 40);
			graphics.endFill();
			
			_message = new TextField();
			_message.defaultTextFormat = Styles.PANEL_TF;
			_message.width = _width;
			_message.border = true;
			_message.text = 'Welcome';
			addChild(_message);
			
			_killTimer = new Timer(2000, 1);
			_killTimer.addEventListener(TimerEvent.TIMER, onTimerTick);
			_killTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			
			visible = false;
		}
		
		//--------------------------------------
		// PROTECTED & PRIVATE METHODS
		//--------------------------------------	
		public function changeMessage(newMessage:String):void
		{
			trace('changeMessage: ' + newMessage);
			_message.text = newMessage;
			visible = true;
			_killTimer.reset();
			_killTimer.start();
		}
		
		private function onTimerTick(e:TimerEvent):void
		{
			trace('onTimerTick');
		}
		
		private function onTimerComplete(e:TimerEvent):void
		{
			trace('onTimerComplete');
			_killTimer.stop();
			visible = false;
		}
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		
		//--------------------------------------
		// EVENT HANDLERS
		//--------------------------------------							
		
		
	}
}