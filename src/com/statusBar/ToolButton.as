
package com.statusBar
{
	import flash.display.Loader;
	import flash.display.Sprite;
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
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		public function ToolButton(data:ToolButtonData)
		{
			super();
			
			name = data.name;
			
			var icon:Loader = new Loader();
			icon.load(new URLRequest(data.url));
			addChild(icon);
			
			graphics.beginFill(0xFF0000, 0.2);
			graphics.drawRect(0, 0, 38, 40);
			graphics.endFill();
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