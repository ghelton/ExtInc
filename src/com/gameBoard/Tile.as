package com.gameBoard
{
	import flash.display.Sprite;
	
	public class Tile extends Sprite
	{
		private static const TILE_WIDTH:Number = 30;
		private static const TILE_HEIGHT:Number = 30;
		
		public function Tile()
		{
			super();
			
			with(graphics)
			{
				beginFill(uint(Math.random() * 0x00FFFF) | 0x00FF88, 1.0);
				drawRect(0, 0, TILE_WIDTH, TILE_HEIGHT);
				endFill();
			}
		}
	}
}