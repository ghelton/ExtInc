package
{
	import com.UI.UILoader;
	import com.attacks.Firebomb;
	import com.creatures.Entity;
	import com.gameBoard.GameBoard;
	import com.gameBoard.Tile;
	import com.lookup.AskJon;
	import com.player.PlayerData;
	import com.player.tools.Tool;
	import com.player.tools.ToolEvent;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.text.engine.TabAlignment;
	import flash.utils.getTimer;
	
	
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
		
		private static const GRID_WIDTH:uint = 31;
		private static const GRID_HEIGHT:uint = 21;
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
		private static var CHROME:String = 'chrome/';
		
		
		//--------------------------------------
		// VARIABLES
		//--------------------------------------
		
		private var testTypes:Array = [AskJon.TIGER];
		
		private var _player:PlayerData;

		private var _bg:Loader;
		private var _gameBoardMask:Loader;
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		public function ExtInc()
		{
			// - BG -
			_bg = new Loader();
			_bg.load(new URLRequest(CHROME + 'MainBg.png'));
			addChild(_bg);
			
			// - MASK -
			_gameBoardMask = new Loader();
			_gameBoardMask.load(new URLRequest(CHROME + 'gameBoardMask.swf'));
			addChild(_gameBoardMask);
			
			Entity.setMasterTime(Number(getTimer()) / 1000.0);
			gameBoard = new GameBoard( new UILoader("../src/assets/terrain.swf"), testTypes );//buildGameBoard());
			gameBoard.mask = _gameBoardMask;
			addChild(gameBoard);
			
			gameBoard.x = _gameBoardMask.x = 55; 
			gameBoard.y = _gameBoardMask.y = 40;
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
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