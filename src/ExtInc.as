package
{
	import com.attacks.Firebomb;
	import com.creatures.Entity;
	import com.gameBoard.GameBoard;
	import com.gameBoard.Tile;
	import com.lookup.Lookup;
	import com.player.PlayerData;
	import com.player.tools.Tool;
	import com.player.tools.ToolEvent;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Point;
	import flash.text.engine.TabAlignment;
	
	
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
			
			/*var testPoint:Point;
			for(var count:int = 10; count >= 0; count--)
			{
				testPoint = new Point(Math.random() * gameBoard.width, Math.random() * gameBoard.height);
				gameBoard.addEntity(new Entity(null, 100, testPoint, count));
			}*/
			
			/*stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;*/
			
			/*var player:PlayerData = new PlayerData();
			var tool:Tool = player.getTool(Lookup.MINES);
			tool.addEventListener(ToolEvent.TOOL_AVAILABLE, onTool, false, 0, true);
			tool.useTool();*/
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
		
		private function onTool(e:ToolEvent):void
		{
			trace("yay tools!");
		}
		
	}
}