package com.creatures
{
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	import com.lookup.Lookup;
	
	
	public class Entity extends EventDispatcher
	{
		public static var _masterTime:Number;
		
		public static function setMasterTime(masterTime:Number):void
		{
			_masterTime = masterTime;
		}

		public var fearVector:Point;
		private var _type:int;
		private var _hitList:Vector.<Entity>;
		private var _image:Sprite;
		private var _health:Number; //uint maybe?
		private var _centerPoint:Point;
		
		private static const TEMP_ENTITY_SIZE:Number = 5;
		private var _attackWasBenefitial:Boolean;
		
		private var _lastAttackTime:Number;
		private var _lastMoveTime:Number;
		
		public function Entity($graphic:Sprite, $health:Number, $point:Point, $type:int)
		{
			super();
			
			_image = $graphic;
			_health = $health;
			_centerPoint = $point;
			
			var tempGraphic:Sprite = new Sprite();
			with(tempGraphic.graphics)
			{
				beginFill(0xABABAB, 0.8);
				drawCircle(0, 0, TEMP_ENTITY_SIZE);
				endFill();
			}
			_image = tempGraphic;
			updatePosition();
			
			_attackWasBenefitial = false;
		}
		
		//GETTERS AND SETTERS
		public function getGraphic():Sprite
		{
			return _image;
		}
			
		public function get centerPoint():Point
		{
			return _centerPoint.clone();
		}
		
		public function get type():int
		{
			return _type;
		}
		
		
		//HELPERS
		public function canAttack():Boolean
		{
			return (Lookup.entityROFArray[_type] + _lastAttackTime) < _masterTime;
		}
		
		public function distanceFromEntity(other:Entity):Number
		{
			return other._centerPoint.subtract(_centerPoint).length;
		}
		
		//ACTUAL CODE
		public function updateFearVector(neighboringEntities:Vector.<Entity>):void
		{
			
		}
		public function attackEntity(enemy:Entity, timeDelta:Number):void
		{
			
		}
		
		public function moveTick():void
		{
			var deltaTime:Number = _lastMoveTime - _masterTime;
			if(_attackWasBenefitial)
			{
				
			} else {
				_centerPoint.x += fearVector.x * deltaTime;
				_centerPoint.y += fearVector.y * deltaTime;
				updatePosition();
			}
			_lastMoveTime = _masterTime;
		}
		
		protected function updatePosition():void
		{
			_image.x = _centerPoint.x - (_image.width * 0.5);
			_image.y = _centerPoint.y - (_image.height * 0.5);	
		}
		
		public function attackTick():void
		{
			var distance:Number = 0;
			var closestDistance:Number = 0;
			var closestEntity:Entity = null;
			var deltaTime:Number = _masterTime - _lastAttackTime;
			if(!canAttack())
			{
				return;
			}
			for each (var enemy:Entity in _hitList)
			{
				distance = distanceFromEntity(enemy);
				if(distance <= closestDistance)
				{
					closestEntity = enemy;
					closestDistance = distance;
				}
			}
			
			if(closestEntity === null)
			{
				return;
			}
			
			attackEntity(enemy, deltaTime);
			enemy.riposte(this);
		}
		
		public function riposte(attacker:Entity):void
		{
			if(canAttack())
			{
				attackEntity(attacker, _masterTime - _lastAttackTime);
			}	
		}
	}
}