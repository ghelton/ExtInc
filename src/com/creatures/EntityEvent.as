package com.creatures
{
	import flash.events.Event;
	
	public class EntityEvent extends Event
	{
		public static const KILLED:String = 'KILLED';
		public function EntityEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}