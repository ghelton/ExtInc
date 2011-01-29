package com.creatures
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import com.lookup.AskJon;
	
	public class Panda extends Entity
	{
		public function Panda($health:Number, $point:Point)
		{
			super(null, $health, $point, AskJon.PANDA);
		}
	}
}