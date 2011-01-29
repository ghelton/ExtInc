package com.creatures
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import com.lookup.AskJon;
	
	public class Marine extends Entity
	{
		public function Marine($health:Number, $point:Point)
		{
			super(null, $health, $point, AskJon.MARINE);
		}
	}
}