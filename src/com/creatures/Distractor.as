package com.creatures
{
	import com.lookup.AskTony;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Distractor extends Entity
	{
		public function Distractor($health:Number, $point:Point)
		{
			super(null, $health, $point, AskTony.DISTRACTOR);
		}
	}
}