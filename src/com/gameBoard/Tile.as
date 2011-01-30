package com.gameBoard
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Tile extends Sprite
	{
		private static const TILE_WIDTH:Number = 30;
		private static const TILE_HEIGHT:Number = 30;
		
		public function Tile()
		{
			super();
			
			with(graphics)
			{
				beginFill((uint(Math.random() * 0xFFFFFF)) | 0x11FF33 + 0x115511, 0.4);
				drawRect(0, 0, TILE_WIDTH, TILE_HEIGHT);
				endFill();
			}
		}
	}
}