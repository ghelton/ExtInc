package com.creatures
{
	import com.UI.UILoader;
	import com.lookup.AskJon;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Seal extends Creature
	{
		public function Seal($health:Number, $point:Point)
		{
//			var tempGraphic:Sprite = new Sprite();
//			with(tempGraphic.graphics)
//			{
//				beginFill(0xFFA0A0, 0.5);
//				drawCircle(0, 0, Entity.TEMP_ENTITY_SIZE);
//				endFill();
//			}
			var seal:UILoader = new UILoader('../src/assets/Seal.swf', Entity.TEMP_ENTITY_SIZE, Entity.TEMP_ENTITY_SIZE);

			super(seal, $health, $point, AskJon.SEAL);
		}
	}
}