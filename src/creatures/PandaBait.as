package creatures
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import lookup.Lookup;
	
	public class PandaBait
	{
		public function PandaBait($graphic:Sprite, $health:Number, $point:Point)
		{
			super($graphic, $health, $point, Lookup.PANDA_BAIT);
		}
	}
}