package com.creatures
{
	import com.UI.UILoader;
	import com.lookup.AskJon;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Panda extends Entity
	{
		public function Panda($health:Number, $point:Point)
		{
			var panda:UILoader = new UILoader('../src/assets/Panda.swf', Entity.TEMP_ENTITY_SIZE, Entity.TEMP_ENTITY_SIZE);
			super(panda, $health, $point, AskJon.PANDA);
		}
	}
}