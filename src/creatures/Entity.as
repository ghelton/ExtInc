package creatures
{
	
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	import utils.Element;
	
	public class Entity extends Element
	{
		public var fearVector:Point;
		private var _type:int;
		private var _hitList:Vector.<Entity>;
		private var _image:Sprite;
		private var _health:Number; //uint maybe?
		private var _centerPoint:Point;
		
		public function Entity($graphic:Sprite, $health:Number, $point:Point, $type:int)
		{
			_image = $graphic;
			_health = $health;
			_centerPoint = $point;
			
			super();
		}
		
		public function get centerPoint():Point
		{
			return _centerPoint.clone();
		}
<<<<<<< HEAD
		
		public function get type():int
		{
			return _type;
		}
		
=======
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
>>>>>>> 8c9bfe54987709a5bf930efc5274f52899d465f0
		public function tick(stepTime:Number):void
		{
			_centerPoint.x += fearVector.x * stepTime;
			_centerPoint.y += fearVector.y * stepTime;
			_image.x = _centerPoint.x;
			_image.y = _centerPoint.y;
		}
	}
}