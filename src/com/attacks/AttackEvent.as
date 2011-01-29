package com.attacks
{
	import com.creatures.Fire;
	
	import flash.events.Event;
	
	public class AttackEvent extends Event
	{
		public static const FIRE:String = 'FIRE';
		public static const FINISHED:String = 'FINISHED';
		
		
		public var weapon:Firebomb;
		public var bomb:Fire;
		public function AttackEvent(type:String, projectile:Fire = null, launcher:Firebomb = null)
		{
			super(type, false, false);
			bomb = projectile;
			weapon = launcher; 
		}
	}
}