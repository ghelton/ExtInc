package com.player.tools
{
	import flash.events.Event;
	
	public class ToolEvent extends Event
	{
		public static const TOOL_AVAILABLE:String = "toolAvailable";
		
		private var _toolType:int;
		
		public function ToolEvent($toolType:int, type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_toolType = $toolType;
			super(type, bubbles, cancelable);
		}
		
		public function get toolType():int
		{
			return _toolType;
		}
	}
}