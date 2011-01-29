package com.attacks
{
	import com.creatures.Fire;
	
	import flash.display.Sprite;
	import flash.geom.Point;

	public class Firebomb
	{
		private var _start:Point;
		private var _end:Point;
		private var _numFires:uint;
		private var _fires:Vector.<Fire>;
		
		public function Firebomb($start:Point, $end:Point, $numFires:uint)
		{
			_start = $start;
			_end = $end;
			_numFires = $numFires;
			
			var vector:Point = _end.subtract(_start);
			var length:Number = vector.length;
			var angle:Number = Math.atan2(vector.y, vector.x);
			var spacing:Number = length / $numFires;
			
			_fires = new Vector.<Fire>($numFires, true);
			var flame:Fire;
			var unitX:Number = vector.x / $numFires + $start.x;
			var unitY:Number = vector.y / $numFires + $start.y;
			for(var i:int = 0; i < $numFires; i++)
			{
				flame = new Fire(new Sprite(), 10, new Point(unitX * i, unitY * i));
				_fires[i] = flame;
			}
		}
		
		public function drawFires(drawTo:Sprite):void
		{
			drawTo.graphics.lineStyle(1, 0, 1, true);
			var p:Point;
			for(var i:int = 0; i < _fires.length; i++)
			{
				p = _fires[i].centerPoint;
				drawTo.graphics.drawCircle(p.x, p.y, 1);
			}
		}
	}
}