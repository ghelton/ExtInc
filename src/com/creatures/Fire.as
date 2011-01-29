package com.creatures
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import com.lookup.Lookup;
	
	public class Fire extends Entity
	{
		public function Fire($graphic:Sprite, $health:Number, $point:Point)
		{
			super($graphic, $health, $point, Lookup.FIRE);
		}
	}
}