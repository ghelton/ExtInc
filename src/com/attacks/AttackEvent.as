package com.attacks
{
	import com.creatures.Fire;
	
	import flash.events.Event;
	import flash.geom.Point;
	
	public class AttackEvent extends Event
	{
		public static const PURCHASED:String = 'PURCHASED';
		public static const FIRE:String = 'FIRE';
		public static const IN_FLIGHT:String = 'IN_FLIGHT';
		public static const FINISHED:String = 'FINISHED';
		
		
		public var bombType:String;
		public var bombPosition:Point;
		public var weapon:Attack;
		public function AttackEvent(type:String, $bombType:String, $bombPosition:Point, launcher:Attack = null)
		{
			super(type, true, false);
			weapon = launcher; 
			bombType = $bombType;
			bombPosition = $bombPosition;
		}
	}
}