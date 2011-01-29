package attacks
{
	import creatures.Fire;
	
	import flash.geom.Point;

	public class Firebomb
	{
		private var _start:Point;
		private var _end:Point;
		private var _numFires:uint;
		private var _fires:Vector.<Fire>;
		
		public function Firebomb($start:Point, $end:Point, $fires:uint)
		{
			_start = $start;
			_end = $end;
			_numFires = $numFires;
		}
	}
}