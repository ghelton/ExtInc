package com.attacks
{
	import com.creatures.Entity;
	import com.creatures.Fire;
	
	import flash.events.EventDispatcher;
	import flash.geom.Point;

	public class Attack extends EventDispatcher
	{
		private var _start:Point;
		private var _end:Point;
		private var _numFires:uint;
		private var _type:String;
		
		public function Attack($numFires:uint, $type:String, $timeStagger:Number = 0.2 )
		{
			_numFires = $numFires;
			_type = $type;
		}
		
		private var _pathOffset:Point;
		public function drop(point:Point):void
		{
			_start = _end = point;
			var vector:Point = _end.subtract(_start);
			var length:Number = vector.length;
			
			
//			_fires = new Vector.<Fire>(_numFires, true);
			_pathOffset = new Point(vector.x / _numFires, vector.y / _numFires);

			for(var i:int = 0; i < _numFires; i++)
			{
				fire(new Point(_start.x + _pathOffset.x * i, _start.y + _pathOffset.y * i));
			}
			clear();
			finished();
		}
		
		public function dropAgain(point:Point):void {
			
		}
		
		public function tick():void
		{
			
		}
		
		private var _projectile:Entity;
		protected function fire(point:Point):void {
			dispatchEvent(new AttackEvent(AttackEvent.FIRE, _type, point));
		}
		protected function finished():void {
			dispatchEvent(new AttackEvent(AttackEvent.FINISHED, null, null, this));
		}
		protected function clear():void {
			dispatchEvent(new AttackEvent(AttackEvent.IN_FLIGHT, null, null, this));
		}
		
//		public function getSpawn():Vector.<Fire>
//		{
//			return _fires;
//		}
		
		
		
//		public function draw():Sprite
//		{
//			var target:Sprite = new Sprite();
//			target.graphics.beginFill(0xFF0000, 0.4);
//			var p:Point;
//			for(var i:int = 0; i < _fires.length; i++)
//			{
//				p = _fires[i].centerPoint;
//				drawTo.graphics.drawCircle(p.x, p.y, 1);
//			}
//		}
	}
}