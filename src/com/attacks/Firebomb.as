package com.attacks
{
	import com.creatures.Entity;
	import com.creatures.Fire;
	import com.gameBoard.GameBoard;
	
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.geom.Point;

	public class Firebomb extends EventDispatcher
	{
		private var _start:Point;
		private var _end:Point;
		private var _numFires:uint;
//		private var _fires:Vector.<Fire>;
		
		public function Firebomb($start:Point, $numFires:uint)
		{
			_start = $start;
			_numFires = $numFires;
			
		}
		
		private var _pathOffset:Point;
		public function drop(endPoint:Point):void
		{
			_end = endPoint;
			var flame:Fire;
			var vector:Point = _end.subtract(_start);
			var length:Number = vector.length;
			
			
//			_fires = new Vector.<Fire>(_numFires, true);
			_pathOffset = new Point(vector.x / _numFires, vector.y / _numFires);

			for(var i:int = 0; i < _numFires; i++)
			{
				flame = new Fire(100, new Point(_start.x + _pathOffset.x * i, _start.y + _pathOffset.y * i));
				dispatchEvent(new AttackEvent(AttackEvent.FIRE, flame));
//				_fires[i] = flame;
			}
			dispatchEvent(new AttackEvent(AttackEvent.FINISHED, null, this));
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