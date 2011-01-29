package creatures
{
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import utils.Element;
	
	public class Entity extends Element
	{
		private var _image:Sprite;
		private var _health:Number; //uint maybe?
		private var _centerPoint:Point;
		public function Entity($graphic:Sprite, $health:Number, $point:Point)
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
	}
}