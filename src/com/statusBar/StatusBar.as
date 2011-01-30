
package com.statusBar
{
	import com.Style.Styles;
	import com.attacks.AttackEvent;
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
	import flash.geom.Point;
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
		public static const BAIT:String = 'BAIT';
		public static const WEAPONS:String = 'WEAPONS';
		public static const CASH_MONIES:String = 'CASH_MONIES';
		public static const KILL_BOX:String = 'KILL_BOX';
		//--------------------------------------
		// VARIABLES
		//--------------------------------------
		private var _cashLabel:TextField;
		private var _animalFace:Loader;
		private var _baitTool:BaitButton;
		private var _weaponTool:WeaponButton;
		
		private static var _currentTab:String = BAIT;
		private static var _currentAnimal:String;
		
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
			cashMoniesBg.name = CASH_MONIES;
			addChild(cashMoniesBg);
			cashMoniesBg.mouseChildren = false;
			cashMoniesBg.addEventListener(MouseEvent.MOUSE_OVER, onIconRollover);
			
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
			killBoxBg.name = KILL_BOX;
			killBoxBg.mouseChildren = false;
			addChild(killBoxBg);
			killBoxBg.addEventListener(MouseEvent.MOUSE_OVER, onIconRollover);
			
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
			addChild(toolBoxBg);
			
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
			
			var icons:Vector.<ToolButtonData> = new Vector.<ToolButtonData>();
			icons.push(new ToolButtonData(AskJon.MINES_TOOL, AskJon.toolInfo[AskJon.MINES_TOOL].iconUrl));
			icons.push(new ToolButtonData(AskJon.FIRE_TOOL, AskJon.toolInfo[AskJon.FIRE_TOOL].iconUrl));
			icons.push(new ToolButtonData(AskJon.BOOMBA_TOOL, AskJon.toolInfo[AskJon.BOOMBA_TOOL].iconUrl));
			
			var icon:ToolButton;
			boxIndent = 45;
			for each(var data:ToolButtonData in icons)
			{
				icon = new ToolButton(data);
				icon.x = boxIndent + icons.indexOf(data) * 74 + toolBoxBg.x;
				icon.y = 30 + toolBoxBg.y;
//				icon.filters = [Styles.SCREEN_GLOW];
				icon.addEventListener(MouseEvent.MOUSE_OVER, onIconRollover);
				icon.addEventListener(MouseEvent.CLICK, onToolClick);
				icon.mouseChildren = false;
				icon.buttonMode = true;
				addChild(icon);
			}
			
			
			
			// - FS BUTTON -
			var fullScreenButton:StatusBox = new StatusBox(25, 25, cornerRadius);
			fullScreenButton.x = 950;
			fullScreenButton.y = 700;
			addChild(fullScreenButton);
			fullScreenButton.addEventListener(MouseEvent.CLICK, onFsClick);
			fullScreenButton.buttonMode = true;
			
			updateTarget(AskJon.PANDA);
			updateTabs(WEAPONS);
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
			_currentAnimal = target;
			_animalFace.load(new URLRequest(AskJon.classInfo[target].url));
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
			showOverlay(e.currentTarget.name);
		}
		
		private function onTabOut(e:MouseEvent):void
		{
			if(_currentTab != e.currentTarget.name)
				e.currentTarget.gotoAndStop(1);
		}
		
		private function onIconRollover(e:MouseEvent):void
		{
			showOverlay(e.currentTarget.name);
		}
		
		private function onToolClick(e:MouseEvent):void
		{
			trace('tool clicked: ' + e.currentTarget.name);
			var tool:String = e.currentTarget.name;
			var message:String;
			if(ExtInc.playerData.money >= AskJon.toolInfo[tool].cost)
			{
				updateCash(-AskJon.toolInfo[tool].cost);
				message = AskJon.toolInfo[tool].name + " " + OverlayEvent.PURCHASED;
				parent.dispatchEvent(new OverlayEvent(OverlayEvent.SHOW_MESSAGE, message));
				parent.dispatchEvent(new AttackEvent(AttackEvent.PURCHASED, tool, new Point(0,0))); 
			} else {
				message = OverlayEvent.BROKE;
				parent.dispatchEvent(new OverlayEvent(OverlayEvent.SHOW_ERROR_MESSAGE, message));
			}
		}
		
		private function updateCash(diff:int):void
		{
			ExtInc.playerData.money += diff;
			_cashLabel.text = ExtInc.playerData.money.toString();
		}
		
		private function showOverlay(name:String):void
		{
			var message:String;
			switch(name)
			{
				case CASH_MONIES :
					message = OverlayEvent.CASH_MONIES;
					break;
				case KILL_BOX :
					message = OverlayEvent.KILL_BOX + OverlayEvent.getRandomCompliment() + " " + AskJon.classInfo[_currentAnimal].name + "s";
					break;
				case BAIT :
					message = OverlayEvent.BAIT;
					break;
				case WEAPONS :
					message = OverlayEvent.WEAPONS;
					break;
				case AskJon.MINES_TOOL :
					message = "$" + AskJon.toolInfo[AskJon.MINES_TOOL].cost + OverlayEvent.MINES_TOOL;
					break;
				case AskJon.MARINES_TOOL :
					message = "$" + AskJon.toolInfo[AskJon.MARINES_TOOL].cost + OverlayEvent.MARINES_TOOL;
					break;
				case AskJon.COMMANDO_TOOL :
					message = "$" + AskJon.toolInfo[AskJon.COMMANDO_TOOL].cost + OverlayEvent.COMMANDO_TOOL;
					break;
				case AskJon.FIRE_TOOL :
					message = "$" + AskJon.toolInfo[AskJon.FIRE_TOOL].cost + OverlayEvent.FIRE_TOOL;
					break;
				case AskJon.BOOMBA_TOOL :
					message = "$" + AskJon.toolInfo[AskJon.BOOMBA_TOOL].cost + OverlayEvent.BOOMBA_TOOL;
					break;
				default :
			}
			parent.dispatchEvent(new OverlayEvent(OverlayEvent.SHOW_MESSAGE, message));
		}
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		
		//--------------------------------------
		// EVENT HANDLERS
		//--------------------------------------							
		
		
	}
}