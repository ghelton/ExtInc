package com.creatures
{
	import com.UI.UILoader;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	public class Creature extends Entity
	{
		private var _movie:MovieClip;
		public function Creature($graphic:Sprite, $health:Number, $point:Point, $type:String)
		{
			super($graphic, $health, $point, $type);
			var loader:UILoader = $graphic as UILoader;
			loader.onComplete = grabMovieClip;
			
			function grabMovieClip(e:Event):void
			{
				if(loader != null)
					_movie = loader.loader.content as MovieClip;
			}
		}
		
		
		protected override function killed():void
		{
			if(_movie != null)
			{
				try
				{
					_movie.gotoAndPlay('explode');
				}
				catch(e:*)
				{
					trace('unable to play explode');
				}
			}
		}
		
		protected override function split():void
		{
			
		}
	}
}