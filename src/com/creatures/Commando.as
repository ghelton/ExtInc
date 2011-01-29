package com.creatures
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import com.lookup.AskJon;
	
	public class Commando extends Entity
	{
		public function Commando($health:Number, $point:Point)
		{
			super(null, $health, $point, AskJon.COMMANDO);
		}
	}
}