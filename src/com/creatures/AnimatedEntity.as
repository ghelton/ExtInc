package com.creatures
{
	import com.UI.UILoader;
	import com.lookup.AskTony;
	
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
		
		protected override function changeHealth(healthDelta:Number, killedBy:String):void
		{
			_image.scaleX = _image.scaleY = (this.getHealth() / 300) + 0.8;
			super.changeHealth(healthDelta, killedBy);
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
		
		public override function attackEntity(attacker:Entity):Number
		{
			var value:Number = super.attackEntity(attacker);
			if(value > 0)
				playAnimation('attack');
			return value;
		}
		
		protected var _currentAnimation:String = '';
		protected override function killed(killedByType:String):void
		{
			var animation:String = null;
			switch(killedByType)
			{
				case AskTony.EXPLOSION:
					animation = 'explode';
				break;
				case AskTony.FIRE:
					animation = 'smolder';
					break;
				default:
					animation = 'dead';
				break;
			}
			playAnimation(animation);
			super.killed(killedByType);
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