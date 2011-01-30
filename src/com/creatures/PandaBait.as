package com.creatures
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import com.lookup.AskTony;
	
	public class PandaBait extends Entity
	{
		public function PandaBait($health:Number, $point:Point)
		{
			super(null, $health, $point, AskTony.PANDA_BAIT);
		}
	}
}