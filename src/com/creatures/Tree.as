package com.creatures
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import com.lookup.Lookup;
	
	public class Tree
	{
		public function Tree($graphic:Sprite, $health:Number, $point:Point)
		{
			super($graphic, $health, $point, Lookup.TREE);
		}
	}
}