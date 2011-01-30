package com.gameBoard
{
	import com.UI.UILoader;
	import com.attacks.Attack;
	import com.attacks.AttackEvent;
	import com.creatures.Entity;
	import com.creatures.EntityEvent;
	import com.lookup.AskTony;
	import com.statusBar.OverlayEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	public class GameBoard extends Sprite
	{
		public static var attackType:String = AskTony.PANDA_BAIT;
		public function setAttackType($type:String):void
		{
			_entityLayer.mouseChildren = _entityLayer.mouseChildren = ($type == null);
			attackType = $type;
		}
		
		private var _masterTimer:Timer;
		private var _grid:Vector.<Vector.<Tile>>;
		private var entities:Vector.<Entity>;
		
		public function explode(target:Point):void
		{
			createEntity(target, AskTony.FIRE);
		}
		
		public function GameBoard(_bg:UILoader, $type:Object) //$theGrid:Vector.<Vector.<Tile>>)
		{
			setAttackType(attackType);
			entities = new Vector.<Entity>();
//			_grid = $theGrid;
//			drawGrid();
			_bg.onComplete = onBgLoadComplete;
			_tileLayer.addChild(_bg);
			addChild(_tileLayer);
//			addChild(_hitArea);
			
			function onBgLoadComplete(e:Event):void {
				
				var count:int;
				var testPoint:Point;
				if($type[AskTony.DISTRACTOR] != null && $type[AskTony.DISTRACTOR] > 0)
				{
					createEntity(new Point(0,0), AskTony.DISTRACTOR);
					createEntity(new Point(_bg.width,0), AskTony.DISTRACTOR);
					createEntity(new Point(_bg.width,_bg.height), AskTony.DISTRACTOR);
					createEntity(new Point(0,_bg.height), AskTony.DISTRACTOR);
					delete $type[$type];
				}
				
				for(var enemyType:String in $type)			
				{
					for(count = int($type[enemyType]); count > 0; count--)
					{
						testPoint = new Point(Math.random() * _bg.width, Math.random() * _bg.height);
						createEntity(testPoint, enemyType);
						//					gameBoard.addEntity(new Entity(null, 100, testPoint, enemyType));
					}
				}
				
				var bound:Rectangle = _tileLayer.getBounds(this);
				_entityLayer.mouseEnabled = _entityLayer.mouseChildren = false;
				Entity.bounds = bound;
				addChild(_entityLayer);
			}
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(MouseEvent.ROLL_OVER, onGameRollOver);
		}
		
		// EVENT LISTENERS
		
		private function onGameRollOver(e:MouseEvent):void
		{
			if(!attackType)
				return;
			
			notifyTool();
		}
		
		private function notifyTool():void
		{
			var message:String;
			
			switch(attackType)
			{
				case AskTony.BOOMBA :
				case AskTony.MINE :
					message = OverlayEvent.PLACE_WEAPON;
					break;
				case AskTony.FIRE:
					message = OverlayEvent.POINT_A;
					break;
				case AskTony.PANDA_BAIT :
				case AskTony.SEAL_BAIT :
				case AskTony.TIGER_BAIT :
					message = OverlayEvent.PLACE_BAIT;
					break;
				default:
					break;
			}
			
			parent.dispatchEvent(new OverlayEvent(OverlayEvent.SHOW_MESSAGE, message));
		}
		
		//_weapons vector to track timing centrally from gameboard
		private var _attacks:Vector.<Attack> = new Vector.<Attack>();
		private var _attack:Attack;
		private var _startPoint:Point;
		private function onAttackClick(e:Event):void 
		{
			if(attackType != null)
			{
				setAttackType(attackType);
				if(_attack == null)
				{
					_attack = new Attack(1, attackType);
					_attacks.push(_attack);
					_attack.addEventListener(AttackEvent.IN_FLIGHT, clearAttack);
					_attack.addEventListener(AttackEvent.FIRE, fireAttack);
					_attack.addEventListener(AttackEvent.FINISHED, finishAttack);
					_attack.drop(new Point(mouseX, mouseY));
				}
				else
				{
					_attack.dropAgain(new Point(mouseX, mouseY));
				}
			}
		}
		
		private function onSplode(e:EntityEvent):void
		{
			explode(e.entity.centerPoint);
		}
		private function onSplit(e:EntityEvent):void
		{
			if(entities.length < 40)
			{
				var entity:Entity = e.entity;
				createEntity(entity.centerPoint.add(new Point(Entity.TEMP_ENTITY_SIZE, Entity.TEMP_ENTITY_SIZE)), entity.type, entity.getHealth());
			}
//			explode(e.entity.centerPoint);
		}
//		private function onAttackUp(e:Event):void
//		{
//			_tileLayer.addEventListener(MouseEvent.MOUSE_DOWN, onAttackClick);
//			stage.removeEventListener(MouseEvent.MOUSE_UP, onAttackUp);
//			
//			_weapon.drop(new Point(mouseX, mouseY));
//		}
		private function clearAttack(attack:AttackEvent):void 
		{
			_attack = null;
			setAttackType(null);
			dispatchEvent(new AttackEvent(attack.type, attack.bombType, attack.bombPosition));
		}
		private function fireAttack($attack:AttackEvent):void 
		{
			createEntity($attack.bombPosition, $attack.bombType);
		}
		private function finishAttack(attack:AttackEvent):void
		{
			var weapon:Attack = attack.weapon;
			if(weapon != null)
			{
				weapon.removeEventListener(AttackEvent.IN_FLIGHT, clearAttack);
				weapon.removeEventListener(AttackEvent.FIRE, fireAttack);
				weapon.removeEventListener(AttackEvent.FINISHED, finishAttack);
				
				var index:int = _attacks.lastIndexOf(weapon);
				if(index >= 0)
					_attacks.splice(index, 1);
			}
			attackType = null;
		}
		private function tangoDown(e:EntityEvent):void
		{
			removeEntity(e.entity);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_tileLayer.addEventListener(MouseEvent.CLICK, onAttackClick);
			
			addEventListener(Event.ENTER_FRAME, mainLoop);
		}
		
		
		
		
		
		
		//UTILITY AND DRAW
		
		private var _tileLayer:Sprite = new Sprite();
		private var _entityLayer:Sprite = new Sprite();		
//		private var _hitArea:Sprite = new Sprite();

		
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
		
		private var _deadList:Vector.<Entity> = new Vector.<Entity>();
		public function tick():void
		{
			var count:int;
			var entity:Entity;
			Entity.setMasterTime(Number(getTimer()) / 1000.0);
			
			for(count = (entities.length - 1); count >= 0; count--)
			{
				if(entities.length > count)
					entities[count].attackTick();
			}
			
			for(count = (_attacks.length - 1); count >= 0; count--) {
				_attacks[count].tick();
			}
			
			var index:int;
			for(count = _deadList.length - 1; count >= 0; count--)
			{
				index = entities.lastIndexOf(_deadList[count]);
				if(index >= 0) 
				{
					dispatchEvent(new AttackEvent(AttackEvent.DEATH, entities[index].type, entities[index].centerPoint));
					entities.splice(index, 1);
				}
			}
			_deadList.length = 0;
			
			for(count = 0; count < entities.length; count++)
				entities[count].moveTick();
		}
		public function createEntity(point:Point, type:String, health:int = 100):void
		{
			var contructor:* = AskTony.classLookup[type];
			if(contructor != null)
			{
				var entity:Entity = new contructor(health, point);
				addEntity(entity);
			}
		}
		private function addEntity(newEntity:Entity):void
		{
			addEntityListeners(newEntity);
			newEntity.setHitList(entities);
			entities.push(newEntity);
			_entityLayer.addChild(newEntity.getGraphic());
		}
		public function removeEntity(deadEntity:Entity):void
		{
			var graphic:Sprite = deadEntity.getGraphic();
////			deadEntity.getGraphic().alpha = 0.1;
//			graphic.scaleX = graphic.scaleY = 0.5;
			var index:int = entities.lastIndexOf(deadEntity);
			deadEntity.removeEventListener(EntityEvent.KILLED, tangoDown);
			
			_deadList.push(deadEntity);
		}
		
		private var _updater:uint = 0;
		private function mainLoop(e:Event):void
		{
			for(var count:uint = 0; count < entities.length; count++)
				entities[count].updateFearVector();
//			var lastCheck:uint = _updater + uint(entities.length / 24);
//			if(lastCheck >= entities.length)
//				lastCheck = entities.length - 1;
//				
//			for(_updater; _updater < lastCheck; _updater++)
//				entities[_updater].updateFearVector();
//			
//			if(_updater >= lastCheck)
//				_updater = 0;
			
			tick();
		}
		
		private function addEntityListeners(entity:Entity):void
		{
			entity.addEventListener(EntityEvent.KILLED, tangoDown);
			entity.addEventListener(EntityEvent.SPLODED, onSplode);
			entity.addEventListener(EntityEvent.SPLIT, onSplit);
		}
		private function removeEntityListeners(entity:Entity):void
		{
			entity.removeEventListener(EntityEvent.KILLED, tangoDown);
			entity.removeEventListener(EntityEvent.SPLODED, onSplode);
			entity.removeEventListener(EntityEvent.SPLIT, onSplit);
		}
	}
}