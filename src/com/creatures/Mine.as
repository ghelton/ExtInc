package com.creatures
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import com.lookup.AskJon;
	
	public class Mine extends Entity
	{
		public function Mine($health:Number, $point:Point)
		{
			super(null, $health, $point, AskJon.MINE);
		}
	}
}