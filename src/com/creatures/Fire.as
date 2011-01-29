package com.creatures
{
	import com.lookup.AskJon;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Fire extends Entity
	{
		public function Fire($health:Number, $point:Point)
		{
//			var tempGraphic:Sprite = new Sprite();
//			with(tempGraphic.graphics)
//			{
//				beginFill(0xFFA0A0, 0.5);
//				drawCircle(0, 0, Entity.TEMP_ENTITY_SIZE);
//				endFill();
//			}
			super(null, $health, $point, AskJon.FIRE);
		}
	}
}