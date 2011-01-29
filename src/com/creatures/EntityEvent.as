package com.creatures
{
	import flash.events.Event;
	
	public class EntityEvent extends Event
	{
		public static const KILLED:String = 'KILLED';
		public static const SPLIT:String = 'SPLIT';
		
		public var entity:Entity;
		public function EntityEvent(type:String, targetEntity:Entity)
		{
			super(type, false, false);
			entity = targetEntity;
		}
	}
}