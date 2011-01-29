package com.creatures
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import com.lookup.Lookup;
	
	public class TigerBait
	{
		public function TigerBait($graphic:Sprite, $health:Number, $point:Point)
		{
			super($graphic, $health, $point, Lookup.TIGER_BAIT);
		}
	}
}