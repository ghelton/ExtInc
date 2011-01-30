package com.creatures
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import com.lookup.AskJon;
	
	public class PandaBait extends Entity
	{
		public function PandaBait($graphic:Sprite, $health:Number, $point:Point)
		{
			super($graphic, $health, $point, AskJon.PANDA_BAIT);
		}
	}
}