package
{
	import com.Style.Styles;
	import com.Tools.MouseTool;
	import com.UI.UILoader;
	import com.attacks.Attack;
	import com.attacks.AttackEvent;
	import com.audio.CoreAudioManager;
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
	import flash.events.MouseEvent;
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
		//--------------------------------------
		// CONSTANTS
		//--------------------------------------
		private static var CHROME:String = 'chrome/';
		
		//--------------------------------------
		// VARIABLES
		//--------------------------------------
		
		
		public static var playerData:PlayerData;

		private var _bg:Loader;
		private var _screen:Sprite;
		private var _screenMask:Loader;
		private var _statusBar:StatusBar;
		private var _statusOverlay:StatusOverlay;
		private var _mouseTool:MouseTool;
		private var _audioManager:CoreAudioManager;
		private var _playAgain:Sprite;
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		public function ExtInc()
		{
			trace(">  >  >  >  >  >  >  >  >  >  >  >\n> Ext Inc.\n> Created by TigerStyle\n> © " + new Date().getFullYear() + "\n>  >  >  >  >  >  >  >  >  >  >  >");
			
//			Font.registerFont(com.fonts.Transponder);
			traceFonts();
			_audioManager = new CoreAudioManager('audio/', 'music/');
			_audioManager.backgroundSongs = ['FunkyAssBitch.mp3'];
			_audioManager.playRandomBackground();
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
			playerData = new PlayerData();
			
			// - BG -
			_bg = new Loader();
			_bg.load(new URLRequest(CHROME + 'MainBg.swf'));
			addChild(_bg);
			
			// - SCREEN -
			_screen = new Sprite();
			addChild(_screen);
			
			// - MASK -
			_screenMask = new Loader();
			_screenMask.load(new URLRequest(CHROME + 'gameBoardMask.swf'));
			addChild(_screenMask);
			_screen.mask = _screenMask;
			
			// - GAME BOARD -
			buildGameBoard();
			
			// - OVERLAY -
			_statusOverlay = new StatusOverlay();
			_statusOverlay.x = gameBoard.x;
			_statusOverlay.y = 605;
			_screen.addChild(_statusOverlay);
			
			// - STATUS BAR -
			_statusBar = new StatusBar();
			addChild(_statusBar);
			
			// - STATUS MESSAGE -
			addEventListener(OverlayEvent.SHOW_MESSAGE, onOverlayEvent);
			addEventListener(OverlayEvent.SHOW_ERROR_MESSAGE, onOverlayEvent);
			addEventListener(AttackEvent.PURCHASED, onToolPurchased);
			addEventListener(AttackEvent.DEATH, onDeath);
			dispatchEvent(new OverlayEvent(OverlayEvent.SHOW_MESSAGE, OverlayEvent.KILL_BOX));
			
			// - TOOL LAYER -
			_playAgain = new Sprite();
			addChild(_playAgain);
			_playAgain.filters = [Styles.OVERLAY_DROP];
		}
		
		//--------------------------------------
		// PROTECTED & PRIVATE METHODS
		//--------------------------------------
		private function buildGameBoard():void
		{
			Entity.setMasterTime(Number(getTimer()) / 1000.0);
			gameBoard = new GameBoard( new UILoader("assets/terrain.swf"), AskTony.startingQuantities );//buildGameBoard());
			_screen.addChild(gameBoard);
			
			gameBoard.x = _screenMask.x = 54; 
			gameBoard.y = _screenMask.y = 39;
		}
		
		private function onOverlayEvent(e:OverlayEvent):void
		{
			if(e.type == OverlayEvent.SHOW_MESSAGE)
				_statusOverlay.changeMessage(e.message, Styles.OVERLAY_TF);
			else if (e.type == OverlayEvent.SHOW_ERROR_MESSAGE)
				_statusOverlay.changeMessage(e.message, Styles.OVERLAY_ERROR_TF);
		}
		private function onToolPurchased(e:AttackEvent):void
		{
			gameBoard.setAttackType(e.bombType);
			gameBoard.addEventListener(AttackEvent.IN_FLIGHT, onAttackInFlight);
			
			_mouseTool = new MouseTool(AskTony.toolInfo[e.toolType].url);
			addChild(_mouseTool);
		}
		private function onAttackInFlight(e:AttackEvent):void
		{
//			e.stopImmediatePropagation();
			_mouseTool.destruct();
			removeChild(_mouseTool);
		}
		
		private function onDeath(e:AttackEvent):void
		{
			if(e.bombType != playerData.target)
			{
				playerData.money += AskTony.killIncorrectAward;
			} else {
				playerData.money += AskTony.killCorrectAward;
				playerData.killCount--;
				if(playerData.killCount == 0)
					killGame();
			}
			
			_statusBar.updateCash(playerData.money);
			_statusBar.updateKillCount(playerData.killCount);
		}
		
		private function killGame():void
		{
			removeEventListener(AttackEvent.DEATH, onDeath);
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoaded);
			loader.load(new URLRequest('chrome/playAgain.swf'));
			_playAgain.addChild(loader);
		}
		
		private function onImageLoaded(e:Event):void
		{
			_playAgain.x = (stage.stageWidth - _playAgain.width) * .5;
			_playAgain.y = (stage.stageHeight - _playAgain.height) * .5;
			_playAgain.addEventListener(MouseEvent.CLICK, onPlayAgainClick);
			_playAgain.mouseEnabled = true;
			_playAgain.buttonMode = true;
		}
		
		private function onPlayAgainClick(e:Event):void
		{
			removeChild(_playAgain);
			playerData = new PlayerData();
			_screen.removeChild(gameBoard);
			buildGameBoard();
		}
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		
		//--------------------------------------
		// EVENT HANDLERS
		//--------------------------------------
		
	}
}