package com.creatures
{
	import com.UI.UILoader;
	
	import flash.display.AVM1Movie;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	public class AnimatedEntity extends Entity
	{
		protected var _defaultAnimation:String = 'walk';
		protected var _loader:UILoader;
		protected var _movie:MovieClip;
		public function AnimatedEntity($graphic:Sprite, $health:Number, $point:Point, $type:String)
		{
			super($graphic, $health, $point, $type);
			_loader = $graphic as UILoader;
			_loader.onComplete = animationLoaded;
		}
		
		protected function animationLoaded(e:Event):void
		{
			if(_loader != null)
				_movie = _loader.loader.content as MovieClip;
			playAnimation(_defaultAnimation);
		}
		
		protected function playAnimation(keyFrame:String):void
		{
			if(_movie != null && _currentAnimation != keyFrame)
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
		
		private var _currentAnimation:String = '';
		protected override function killed():void
		{
			playAnimation('dead');
			super.killed();
		}
		
		protected override function split():void
		{
			playAnimation('split');
			super.split();
		}
		protected override function idle(delta:Number = 0):Number
		{
//			playAnimation('idle');
			return super.idle(delta);
		}
	}
}