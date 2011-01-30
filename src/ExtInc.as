package
{
	import com.UI.UILoader;
	import com.attacks.Attack;
	import com.creatures.Entity;
	import com.fonts.Transponder;
	import com.gameBoard.GameBoard;
	import com.gameBoard.Tile;
	import com.lookup.AskTony;
	import com.player.PlayerData;
	import com.player.tools.Tool;
	import com.player.tools.ToolEvent;
	import com.statusBar.OverlayEvent;
	import com.statusBar.StatusBar;
	import com.statusBar.StatusOverlay;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.text.Font;
	import flash.text.engine.TabAlignment;
	import flash.utils.getTimer;
	
	
	/**
	 * [Description]
	 *
	 * @author G$
	 * @since Jan 28, 2011
	 */
	[SWF(width="1024", height="768", frameRate="24")]
	
	public class ExtInc extends Sprite
	{
		private var _theGrid:Vector.<Vector.<Tile>>;
		private var gameBoard:GameBoard;
		
		private static const GRID_WIDTH:uint = 32;
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
		
//		private var testTypes:Array = [AskJon.TIGER, AskJon.SEAL, AskJon.PANDA];
		
		public static var playerData:PlayerData;

		private var _bg:Loader;
		private var _screenMask:Loader;
		private var _statusBar:StatusBar;
		private var _statusOverlay:StatusOverlay;
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		public function ExtInc()
		{
			trace(">  >  >  >  >  >  >  >  >  >  >  >\n> Ext Inc.\n> Created by TigerStyle\n> © " + new Date().getFullYear() + "\n>  >  >  >  >  >  >  >  >  >  >  >");
			
//			Font.registerFont(com.fonts.Transponder);
//			traceFonts();
			loadGame();	
		}
		
		private function traceFonts():void
		{
			var allFonts:Array = Font.enumerateFonts(true);
			var font:Font;
			trace("[FontLoader] - Fonts Enumerated: " + allFonts.length);
			for( var i:Number = 0 ; i < allFonts.length ; i++)
			{
				if (allFonts[i].fontType == "embedded"){ 
					trace('[FontLoader.whatFonts] name: '+allFonts[i].fontName +', style: '+allFonts[i].fontStyle+', type: '+allFonts[i].fontType);
				}
			}
		}
		
		private function loadGame():void
		{
			// - PLAYER DATA -
			playerData = new PlayerData(3000);
			
			// - BG -
			_bg = new Loader();
			_bg.load(new URLRequest(CHROME + 'MainBg.png'));
			addChild(_bg);
			
			// - SCREEN -
			var screen:Sprite = new Sprite();
			addChild(screen);
			
			// - MASK -
			_screenMask = new Loader();
			_screenMask.load(new URLRequest(CHROME + 'gameBoardMask.swf'));
			addChild(_screenMask);
			screen.mask = _screenMask;
			
			// - GAME BOARD -
			Entity.setMasterTime(Number(getTimer()) / 1000.0);
			gameBoard = new GameBoard( new UILoader("../src/assets/terrain.swf"), AskTony.startingQuantities );//buildGameBoard());
			screen.addChild(gameBoard);
			
			gameBoard.x = _screenMask.x = 54; 
			gameBoard.y = _screenMask.y = 39;
			
			// - OVERLAY -
			_statusOverlay = new StatusOverlay();
			_statusOverlay.x = gameBoard.x;
			_statusOverlay.y = 605;
			screen.addChild(_statusOverlay);
			
			// - STATUS BAR -
			_statusBar = new StatusBar();
			addChild(_statusBar);
			
			// - STATUS MESSAGE -
			addEventListener(OverlayEvent.SHOW_MESSAGE, onOverlayEvent);
			dispatchEvent(new OverlayEvent(OverlayEvent.SHOW_MESSAGE, OverlayEvent.WELCOME));
			
		}
		
		//--------------------------------------
		// PROTECTED & PRIVATE METHODS
		//--------------------------------------
		private function onOverlayEvent(e:OverlayEvent):void
		{
			if(e.type == OverlayEvent.SHOW_MESSAGE)
				_statusOverlay.changeMessage(e.message);
		}
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		
		//--------------------------------------
		// EVENT HANDLERS
		//--------------------------------------
		
	}
}