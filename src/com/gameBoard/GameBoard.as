package com.gameBoard
{
	import com.creatures.Entity;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	public class GameBoard extends Sprite
	{
		private var _masterTimer:Timer;
		private var _grid:Vector.<Vector.<Tile>>;
		internal var entities:Vector.<Entity>;
		
		
		public function GameBoard($theGrid:Vector.<Vector.<Tile>>)
		{
			entities = new Vector.<Entity>();
			_grid = $theGrid;
			drawGrid();
			addChild(_tileLayer);
			addChild(_entityLayer);
		}
		
		private var _tileLayer:Sprite = new Sprite();
		private var _entityLayer:Sprite = new Sprite();
		
		private static const OVERLAP_BUFFER:Number = 0.25;
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
					drawPoint.y += tile.height - OVERLAP_BUFFER;
				}
				drawPoint.x += tile.width - OVERLAP_BUFFER;
				drawPoint.y = 0;
			}
		}
		
		public function tick(stepTime:Number):void
		{
			Entity._masterTime = (getTimer() / 1000);
			for each(var entity:Entity in entities)
				entity.tick(stepTime);
		}
		
		public function addEntity(newEntity:Entity):void
		{
			entities.push(newEntity);
			_entityLayer.addChild(newEntity.getGraphic());
		}
		public function removeEntity(deadEntity:Entity):void
		{
			var index:int = entities.lastIndexOf(deadEntity);
			if(index >= 0)
				entities.splice(index, 1);
		}
	}
}