package gameBoard
{
	import creatures.Entity;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.Timer;

	public class GameBoard extends Sprite
	{
		private var _masterTimer:Timer;
		private var _grid:Vector.<Vector.<Tile>>;
		internal var entities:Vector.<Entity>;
		
		
		public function GameBoard($theGrid:Vector.<Vector.<Tile>>)
		{
			entities = new Vector.<Entity>();
			_grid = $theGrid;
		}
		
		private var _tileLayer:Sprite = new Sprite();
		
		private function drawGrid():void
		{
			var drawPoint:Point = new Point();
			var tile:Tile;
			for each(var column:Vector.<Tile> in _grid)
			{
				for each(tile in column)
				{
					_tileLayer.addChild(tile);
					tile.x = drawPoint.x;
					tile.y = drawPoint.y;
					drawPoint.y += tile.height;
				}
				drawPoint.x += tile.width;
				drawPoint.y = 0;
			}
		}
		
		public function tick(stepTime:Number):void
		{
//			Entity.
			for each(var entity:Entity in entities)
				entity.tick(stepTime);
		}
		
		public function addEntity(newEntity:Entity):void
		{
			entities.push(newEntity);
		}
		public function removeEntity(deadEntity:Entity):void
		{
			var index:int = entities.lastIndexOf(deadEntity);
			if(index >= 0)
				entities.splice(index, 1);
		}
	}
}