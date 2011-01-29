package creatures
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Entity
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
		public function updateFearVector(neighboringEntities:Vector.<Entity>)
		{
			
		}
		public function attackEntity(enemy:Entity, timeDelta:Number)
		{
			
		}
		public function move(timeDelta:Number)
		{
			
		}
	}
}