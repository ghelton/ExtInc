package com.creatures
{
	import com.UI.UILoader;
	import com.lookup.AskJon;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class Fire extends AnimatedEntity
	{
		public function Fire($health:Number, $point:Point)
		{
			var fire:UILoader = new UILoader('../src/assets/FireBomb.swf', Entity.TEMP_ENTITY_SIZE, Entity.TEMP_ENTITY_SIZE);

			super(fire, $health, $point, AskJon.FIRE);
		}
	}
}