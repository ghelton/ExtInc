package com.creatures
{
	import com.UI.UILoader;
	import com.lookup.AskTony;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Panda extends AnimatedEntity
	{
		public function Panda($health:Number, $point:Point)
		{
			var panda:UILoader = new UILoader('../src/assets/Panda.swf', Entity.TEMP_ENTITY_SIZE, Entity.TEMP_ENTITY_SIZE);
			super(panda, $health, $point, AskTony.PANDA);
		}
	}
}