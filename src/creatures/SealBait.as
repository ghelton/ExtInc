package creatures
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import lookup.Lookup;
	
	public class SealBait
	{
		public function SealBait($graphic:Sprite, $health:Number, $point:Point)
		{
			super($graphic, $health, $point, Lookup.SEAL_BAIT_REG);
		}
	}
}