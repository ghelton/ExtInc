package creatures
{
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	public class Entity extends EventDispatcher
	{
		public var fearVector:Point;
		private var _hitList:Vector.<Entity>;
		private var _image:Sprite;
		private var _health:Number; //uint maybe?
		private var _centerPoint:Point;
		public function Entity($graphic:Sprite, $health:Number, $point:Point)
		{
			_image = $graphic;
			_health = $health;
			_centerPoint = $point;
		}
		public function updateFearVector(neighboringEntities:Vector.<Entity>)
		{
			
		}
		public function attackEntity(enemy:Entity, timeDelta:Number)
		{
			
		}
		public function distanceFromEntity(other:Entity)
		{
			return other._centerPoint.subtract(_centerPoint).length;
		}
		public function tick(stepTime:Number):void
		{
			_centerPoint.x += fearVector.x * stepTime;
			_centerPoint.y += fearVector.y * stepTime;
			_image.x = _centerPoint.x;
			_image.y = _centerPoint.y;
		}
	}
}