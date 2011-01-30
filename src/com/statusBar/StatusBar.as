
package com.statusBar
{
	import com.Style.Styles;
	import com.lookup.AskJon;
	
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Timer;
	
	
	/**
	 * [Description]
	 *
	 * @author G$
	 * @since Jan 29, 2011
	 */
	public class StatusBar extends Sprite
	{
		
		//--------------------------------------
		// CONSTANTS
		//--------------------------------------
		public static const BAIT:String = 'Bait';
		public static const WEAPONS:String = 'Weapons';
		//--------------------------------------
		// VARIABLES
		//--------------------------------------
		private var _cashLabel:TextField;
		private var _animalFace:Loader;
		private var _baitTool:BaitButton;
		private var _weaponTool:WeaponButton;
		
		private static var _currentTab:String = BAIT;
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		public function StatusBar()
		{
			super();
			
			var cornerRadius:uint = 56;
			
			// - CASH MONIES -
			var cashMoniesBg:StatusBox = new StatusBox(145, 98, cornerRadius);
			cashMoniesBg.x = 105;
			cashMoniesBg.y = 662;
			addChild(cashMoniesBg);
			
			var cashTitleLabel:TextField = new TextField();
			cashTitleLabel.defaultTextFormat = Styles.PANEL_TF;
			cashTitleLabel.width = 145;
			cashTitleLabel.y = 15;
			cashTitleLabel.text = "Money";
			cashMoniesBg.addChild(cashTitleLabel);
			
			_cashLabel = new TextField();
			_cashLabel.defaultTextFormat = Styles.PANEL_TF;
			_cashLabel.width = 145;
			_cashLabel.y = 50;
			_cashLabel.text = ExtInc.playerData.money.toString();
			cashMoniesBg.addChild(_cashLabel);
			
			// - KILL BOX -
			var killBoxBg:StatusBox = new StatusBox(165, 98, cornerRadius);
			killBoxBg.x = 267;
			killBoxBg.y = 662;
			addChild(killBoxBg);
			
			var killBoxLabel:TextField = new TextField();
			killBoxLabel.defaultTextFormat = Styles.PANEL_TF_L;
			killBoxLabel.multiline = true;
			killBoxLabel.width = 60;
			killBoxLabel.x = 15;
			killBoxLabel.y = 15;
			killBoxLabel.text = "Kill\n100";
			killBoxBg.addChild(killBoxLabel);
			
			_animalFace = new Loader();
			_animalFace.x = 80;
			_animalFace.y = 20;
			killBoxBg.addChild(_animalFace);
			
			// - TOOL BOX -
			_baitTool = new BaitButton();
			_baitTool.name = BAIT;
			_baitTool.addEventListener(MouseEvent.CLICK, onTabClick, false, 0, true);
			_baitTool.addEventListener(MouseEvent.MOUSE_OVER, onTabOver, false, 0, true);
			_baitTool.addEventListener(MouseEvent.MOUSE_OUT, onTabOut, false, 0, true);
			_baitTool.x = 445;
			_baitTool.y = 662;
			_baitTool.buttonMode = true;
			_baitTool.mouseChildren = false;
			addChild(_baitTool);
			
			_weaponTool = new WeaponButton();
			_weaponTool.name = WEAPONS;
			_weaponTool.addEventListener(MouseEvent.CLICK, onTabClick, false, 0, true);
			_weaponTool.addEventListener(MouseEvent.MOUSE_OVER, onTabOver, false, 0, true);
			_weaponTool.addEventListener(MouseEvent.MOUSE_OUT, onTabOut, false, 0, true);
			_weaponTool.x = 445;
			_weaponTool.y = 712;
			_weaponTool.buttonMode = true;
			_weaponTool.mouseChildren = false;
			addChild(_weaponTool);
			
			var toolBoxBg:StatusBox = new StatusBox(434, 98, cornerRadius);
			toolBoxBg.x = 505;
			toolBoxBg.y = 662;
			
			var toolBoxLine:Shape = new Shape();
			toolBoxLine.graphics.beginFill(Styles.REALLY_GREEN);
			toolBoxLine.graphics.drawRect(20, (toolBoxBg.height - .5) / 2, toolBoxBg.width - 40, 1);
			toolBoxLine.graphics.endFill(); 
			toolBoxBg.addChild(toolBoxLine);
			
			var box:Shape;
			var boxIndent:uint = 40;
			for (var i:uint = 0; i < 5; i++)
			{
				box = new Shape();
				box.graphics.lineStyle(1, Styles.REALLY_GREEN, 1, true);
				box.graphics.beginFill(0x000000);
				box.graphics.drawRect(boxIndent + i * 74, 25, 48, 50);
				box.graphics.endFill();
				box.filters = [Styles.SCREEN_GLOW];
				toolBoxBg.addChild(box);
			}
			
//			var box:Shape;
//			var boxIndent:uint = 45;
//			for (var i:uint = 0; i < 5; i++)
//			{
//				box = new Shape();
//				box.graphics.lineStyle(1, Styles.REALLY_GREEN, 1, true);
//				box.graphics.beginFill(0x000000);
//				box.graphics.drawRect(boxIndent + i * 79, 30, 38, 40);
//				box.graphics.endFill();
//				box.filters = [Styles.SCREEN_GLOW];
//				toolBoxBg.addChild(box);
//			}
			
			
			addChild(toolBoxBg);
			
			// - FS BUTTON -
			var fullScreenButton:StatusBox = new StatusBox(25, 25, cornerRadius);
			fullScreenButton.x = 950;
			fullScreenButton.y = 700;
			addChild(fullScreenButton);
			fullScreenButton.addEventListener(MouseEvent.CLICK, onFsClick);
			fullScreenButton.buttonMode = true;
			
			updateTarget(AskJon.PANDA);
			updateTabs(BAIT);
		}
		
		//--------------------------------------
		// PROTECTED & PRIVATE METHODS
		//--------------------------------------	
		private function onFsClick(e:MouseEvent):void
		{
			if(stage.displayState == StageDisplayState.NORMAL)
			{
				stage.displayState = StageDisplayState.FULL_SCREEN;
			} else {
				stage.displayState = StageDisplayState.NORMAL;
			}
		}
		
		private function updateTarget(target:String):void
		{
			switch(target)
			{
				case AskJon.PANDA :
					_animalFace.load(new URLRequest('chrome/panda.swf'));
					break;
			}
		}
		
		private function updateTabs(targetTab:String):void
		{
			_currentTab = targetTab;
			if(_currentTab == BAIT)
			{
				_baitTool.gotoAndStop(2);
				_weaponTool.gotoAndStop(1);
			} else {
				_baitTool.gotoAndStop(1);
				_weaponTool.gotoAndStop(2);
			}
		}
		
		private function onTabClick(e:MouseEvent):void
		{
			updateTabs(e.currentTarget.name);
		}
		
		private function onTabOver(e:MouseEvent):void
		{
			e.currentTarget.gotoAndStop(2);
			var message:String;
			switch(e.currentTarget.name)
			{
				case BAIT :
					message = OverlayEvent.BAIT;
					break;
				case WEAPONS :
					message = OverlayEvent.WEAPONS;
					break;
				default :
			}
			parent.dispatchEvent(new OverlayEvent(OverlayEvent.SHOW_MESSAGE, message));
		}
		
		private function onTabOut(e:MouseEvent):void
		{
			if(_currentTab != e.currentTarget.name)
				e.currentTarget.gotoAndStop(1);
		}
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		
		//--------------------------------------
		// EVENT HANDLERS
		//--------------------------------------							
		
		
	}
}