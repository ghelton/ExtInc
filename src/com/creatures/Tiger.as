package com.creatures
{
	import com.UI.UILoader;
	import com.lookup.AskTony;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Tiger extends AnimatedEntity
	{
		public function Tiger($health:Number, $point:Point)
		{
//			var tempGraphic:Sprite = new Sprite();
//			with(tempGraphic.graphics)
//			{
//				beginFill(0xFFA0A0, 0.5);
//				drawCircle(0, 0, Entity.TEMP_ENTITY_SIZE);
//				endFill();
//			}
			var tiger:UILoader = new UILoader('../src/assets/Tiger.swf', Entity.TEMP_ENTITY_SIZE, Entity.TEMP_ENTITY_SIZE);

			super(tiger, $health, $point, AskTony.TIGER);
		}
	}
}