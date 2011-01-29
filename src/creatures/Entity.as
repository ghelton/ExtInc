package creatures
{
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	public class Entity extends EventDispatcher
	{
		private var _image:Sprite;
		private var _health:Number; //uint maybe?
		private var _centerPoint:Point;
		public function Entity($graphic:Sprite, $health:Number, $point:Point)
		{
			_image = $graphic;
			_health = $health;
			_centerPoint = $point;
		}
		
		public function tick(stepTime:Number):void
		{
			
		}
	}
}