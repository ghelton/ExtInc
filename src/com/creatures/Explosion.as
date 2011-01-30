package com.creatures
{
	import com.UI.UILoader;
	import com.lookup.AskTony;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Explosion extends AnimatedEntity
	{
		public function Explosion($health:Number, $point:Point)
		{
			var fire:UILoader = new UILoader('assets/FireBomb.swf', Entity.TEMP_ENTITY_SIZE, Entity.TEMP_ENTITY_SIZE);

			super(fire, $health, $point, AskTony.EXPLOSION);
		}
		
		
		protected override function playAnimation(keyFrame:String):void
		{
			if(_movie != null && _currentAnimation != keyFrame && keyFrame != 'explode')
			{
				try
				{
					_movie.gotoAndPlay(keyFrame);
				}
				catch(e:*)
				{
					trace('unable to play ' + keyFrame);
				}
			}
			_currentAnimation = keyFrame;
		}
	}
}