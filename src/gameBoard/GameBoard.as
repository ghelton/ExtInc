package gameBoard
{
	import creatures.Entity;

	public class GameBoard
	{
		private var _grid:Vector.<Vector.<Tile>>;
		internal var entities:Vector.<Entity>;
		public function GameBoard($theGrid:Vector.<Vector.<Tile>>)
		{
			entities = new Vector.<Entity>();
			grid = $theGrid;
		}
		
		public function tick(stepLength:Number):void
		{
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