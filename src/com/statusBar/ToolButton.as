
package com.statusBar
{
	import com.Style.Styles;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	
	/**
	 * [Description]
	 *
	 * @author G$
	 * @since Jan 30, 2011
	 */
	public class ToolButton extends Sprite
	{
		
		//--------------------------------------
		// CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// VARIABLES
		//--------------------------------------
		public var url:String;
		
		private var _icon:Loader;
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		public function ToolButton(data:ToolButtonData)
		{
			super();
			
			name = data.name;
			
			_icon = new Loader();
			_icon.load(new URLRequest(data.url));
			_icon.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete, false, 0, true);
			_icon.filters = [Styles.SCREEN_GLOW];
			addChild(_icon);
			
			graphics.beginFill(0xFF0000, 0);
			graphics.drawRect(0, 0, 38, 40);
			graphics.endFill();
		}
		
		//--------------------------------------
		// PROTECTED & PRIVATE METHODS
		//--------------------------------------	
		private function onComplete(e:Event):void
		{
			_icon.y = (40 - _icon.height) * .5;
		}
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		
		//--------------------------------------
		// EVENT HANDLERS
		//--------------------------------------							
		
		
	}
}