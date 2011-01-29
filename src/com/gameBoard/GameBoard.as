package com.gameBoard
{
	import com.creatures.Entity;
	
	import flash.display.Sprite;
	import flash.events.Event;
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
			
			stage.addEventListener(Event.ENTER_FRAME, mainLoop);
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
		
		public function tick():void
		{
			var entity:Entity;
			Entity._masterTime = (getTimer() / 1000);
			for each(entity in entities) {
//				entity.updateFearVector(
				entity.attackTick();
			}
			
			for each(entity in entities)
				entity.moveTick();
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
		
		private function mainLoop(e:Event):void
		{
			
			tick();
		}
	}
}