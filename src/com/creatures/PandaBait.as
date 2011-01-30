package com.creatures
{
	import com.UI.UILoader;
	import com.lookup.AskTony;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class PandaBait extends Entity
	{
		public function PandaBait($health:Number, $point:Point)
		{
			var cake:UILoader = new UILoader('assets/cake.swf', Entity.TEMP_ENTITY_SIZE, Entity.TEMP_ENTITY_SIZE);

			super(cake, $health, $point, AskTony.PANDA_BAIT);
		}
	}
}