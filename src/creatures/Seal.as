package creatures
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import lookup.Lookup;
	
	public class Seal
	{
		public function Seal($graphic:Sprite, $health:Number, $point:Point)
		{
			super($graphic, $health, $point, Lookup.SEAL);
		}
	}
}