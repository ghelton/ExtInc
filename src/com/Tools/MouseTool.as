
package com.Tools
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.ui.Mouse;
	
	
	/**
	 * [Description]
	 *
	 * @author G$
	 * @since Jan 30, 2011
	 */
	public class MouseTool extends Sprite
	{
		
		//--------------------------------------
		// CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// VARIABLES
		//--------------------------------------
		private var _cursor:Loader;
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		public function MouseTool($url:String)
		{
			super();
			Mouse.hide();
			_cursor = new Loader();
			_cursor.load(new URLRequest($url));
			addChild(_cursor);
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		//--------------------------------------
		// PROTECTED & PRIVATE METHODS
		//--------------------------------------	
		private function onMove(e:MouseEvent):void
		{
			_cursor.x = mouseX;
			_cursor.y = mouseY;
		}
		
		private function onAdded(e:Event):void
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
		}
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		public function destruct():void
		{
			_cursor.unloadAndStop(true);
			_cursor = null;
			Mouse.show();
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
		}
		//--------------------------------------
		// EVENT HANDLERS
		//--------------------------------------							
		
		
	}
}