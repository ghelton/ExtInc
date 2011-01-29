package
{
	import attacks.Firebomb;
	
	import flash.display.Sprite;
	import flash.text.engine.TabAlignment;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Point;
	
	import gameBoard.GameBoard;
	import gameBoard.Tile;
	import player.PlayerData;
	
	
	/**
	 * [Description]
	 *
	 * @author G$
	 * @since Jan 28, 2011
	 */
	//[SWF(width="1024", height="768", version_major="10", frameRate="24")]
	
	public class ExtInc extends Sprite
	{
		private var _theGrid:Vector.<Vector.<Tile>>;
		private var gameBoard:GameBoard;
		
		private static const GRID_WIDTH:uint = 10;
		private static const GRID_HEIGHT:uint = 10;
		private function buildGameBoard():Vector.<Vector.<Tile>>
		{
			var widthCount:uint;
			var grid:Vector.<Vector.<Tile>> = new Vector.<Vector.<Tile>>(GRID_WIDTH, true);
			var active:Vector.<Tile>;
			for(var column:uint = 0; column < GRID_WIDTH; column++)
			{
				active = grid[column] = new Vector.<Tile>(GRID_HEIGHT, true);
				for(widthCount = 0; widthCount < GRID_HEIGHT; widthCount++)
				{
					active[widthCount] = new Tile();
				}
			}
			return grid;
		}
		//--------------------------------------
		// CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// VARIABLES
		//--------------------------------------
		
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		public function ExtInc()
		{
			gameBoard = new GameBoard(buildGameBoard());
			
			addChild(gameBoard);
//			gameBoard.addEntity(
			/*stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;*/
			
			var player:PlayerData = new PlayerData();
		}
		
		//--------------------------------------
		// PROTECTED & PRIVATE METHODS
		//--------------------------------------	
		
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		
		//--------------------------------------
		// EVENT HANDLERS
		//--------------------------------------							
		
		
	}
}