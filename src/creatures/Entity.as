package creatures
{
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	public class Entity extends EventDispatcher
	{
		public var fearVector:Point;
		
		protected var _hitList:Vector.<Entity>;
		protected var _image:Sprite;
		protected var _health:Number; //uint maybe?
		protected var _centerPoint:Point;
		public function Entity($graphic:Sprite, $health:Number, $point:Point)
		{
			_image = $graphic;
			_health = $health;
			_centerPoint = $point;
		}
		
		public function tick(stepTime:Number):void
		{
			_centerPoint.x += fearVector.x * stepTime;
			_centerPoint.y += fearVector.y * stepTime;
			updatePosition();
		}
		
		protected function updatePosition():void
		{
			_image.x = _centerPoint.x - (_image.width * 0.5);
			_image.y = _centerPoint.y - (_image.height * 0.5);
			
		}
		
		
	}
}