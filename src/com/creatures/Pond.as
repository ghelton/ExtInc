package com.creatures
{
	import com.UI.UILoader;
	import com.lookup.AskTony;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Pond extends AnimatedEntity
	{
		public function Pond($health:Number, $point:Point)
		{
			var pond:UILoader = new UILoader('assets/Pond.swf', Entity.TEMP_ENTITY_SIZE, Entity.TEMP_ENTITY_SIZE);

			super(pond, $health, $point, AskTony.POND);
		}
	}
}