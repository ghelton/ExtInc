package com.creatures
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import com.lookup.AskTony;
	
	public class TigerBait extends Entity
	{
		public function TigerBait($health:Number, $point:Point)
		{
//			var tempGraphic:Sprite = new Sprite();
//			with(tempGraphic.graphics)
//			{
//				beginFill(0xFFA0A0, 0.5);
//				drawCircle(0, 0, Entity.TEMP_ENTITY_SIZE);
//				endFill();
//			}
			super(null, $health, $point, AskTony.TIGER_BAIT);
		}
	}
}