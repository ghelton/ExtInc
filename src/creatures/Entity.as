package creatures
{
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	public class Entity extends EventDispatcher
	{
		public var fearVector:Point;
		private var _type:int;
		private var _hitList:Vector.<Entity>;
		private var _image:Sprite;
		private var _health:Number; //uint maybe?
		private var _centerPoint:Point;
		
		private static const TEMP_ENTITY_SIZE:Number = 5;
		public function Entity($graphic:Sprite, $health:Number, $point:Point, $type:int)
		{
			_image = $graphic;
			_health = $health;
			_centerPoint = $point;
			
			var tempGraphic:Sprite = new Sprite();
			with(tempGraphic.graphics)
			{
				beginFill(0xABABAB, 0.8);
				drawCircle(0, 0, TEMP_ENTITY_SIZE);
				endFill();
			}
			_image = tempGraphic;
			
			super();
		}
		
		public function get centerPoint():Point
		{
			return _centerPoint.clone();
		}
		
		public function get type():int
		{
			return _type;
		}
		
		public function updateFearVector(neighboringEntities:Vector.<Entity>):void
		{
			
		}
		public function attackEntity(enemy:Entity, timeDelta:Number):void
		{
			
		}
		public function distanceFromEntity(other:Entity):Number
		{
			return other._centerPoint.subtract(_centerPoint).length;
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