package com.player.tools
{
	import com.lookup.AskTony;
	
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class Tool extends EventDispatcher
	{
		private var _cooldown:int;
		private var _cost:int;
		private var _type:String;
		
		private var _cooldownTimer:Timer;
		
		public function Tool($type:String)
		{
			var stats:Object = AskTony.toolInfo[$type];
			_cooldown = stats.cooldown;
			_cost = stats.cost;
			_type = $type;
			
			_cooldownTimer = new Timer(_cooldown * 1000, 1);
		}
		
		public function isAvailable():Boolean
		{
			return !_cooldownTimer.running;
		}
		
		public function useTool():void
		{
			_cooldownTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onCoolDown, false, 0, true);
			_cooldownTimer.start();
		}
		
		private function onCoolDown(e:TimerEvent):void
		{
			_cooldownTimer.reset();
			_cooldownTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onCoolDown);
			dispatchEvent(new ToolEvent(_type, ToolEvent.TOOL_AVAILABLE));
		}
		
		public function get type():String
		{
			return _type;
		}
		
		public function get cost():int
		{
			return _cost;
		}
	}
}