package com.creatures
{
	import com.lookup.Lookup;
	
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	
	public class Entity extends EventDispatcher
	{
		public static var _masterTime:Number;
		
		public static function setMasterTime(masterTime:Number):void
		{
			_masterTime = masterTime;
		}
		
		public function setHitList(list:Vector.<Entity>):void
		{
			_hitList = list;
		}

		public var fearVector:Point = new Point();
		private var _type:String;
		private var _hitList:Vector.<Entity>;
		private var _image:Sprite;
		private var _health:Number; //uint maybe?
		private var _centerPoint:Point;
		
		private static const TEMP_ENTITY_SIZE:Number = 5;
		private var _attackWasBenefitial:Boolean;
		
		private var _lastAttackTime:Number;
		private var _lastMoveTime:Number;
		
		public function Entity($graphic:Sprite, $health:Number, $point:Point, $type:String)
		{
			super();
			
			_lastMoveTime = _masterTime;
			_type = $type;
			_image = $graphic;
			_health = $health;
			_centerPoint = $point;
			_lastAttackTime = _masterTime;
			
			var tempGraphic:Sprite = new Sprite();
			with(tempGraphic.graphics)
			{
				beginFill(0xFF0000, 0.8);
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

		public function setMasterTime(masterTime:Number):void
		{
			_masterTime = masterTime;
		}
		
		public function getHealth():Number
		{
			return _health;
		}
		
		public function get centerPoint():Point
		{
			return _centerPoint.clone();
		}
		
		public function get type():String
		{
			return _type;
		}
		
		
		//HELPERS
		public function canAttack():Boolean
		{
			return _health > 0 && ((Lookup.entityROFArray[_type] + _lastAttackTime) < _masterTime);
		}
		
		public function distanceFromEntity(other:Entity):Number
		{
			return other._centerPoint.subtract(_centerPoint).length;
		}
		
		
		//ACTUAL CODE
		
		public function attackEntity(enemy:Entity, timeDelta:Number):void
		{
			var healthChange:Number = timeDelta * Lookup.entityDamageMatrix[_type][enemy.type];
			if((_health + healthChange) < 0)
			{
				_health = 0;
				enemy.dispatchEvent(new EntityEvent(EntityEvent.KILLED));
			} else {
				_health += timeDelta * Lookup.entityDamageMatrix[_type][enemy.type];	
			}
		}
		
		protected function updatePosition():void
		{
			_image.x = _centerPoint.x - (_image.width * 0.5);
			_image.y = _centerPoint.y - (_image.height * 0.5);	
		}
		
		public function moveTick():void
		{
			trace('moving');
			var deltaTime:Number = _masterTime - _lastMoveTime;
			if(_attackWasBenefitial)
			{
				
			} else {
				_centerPoint.x += fearVector.x * deltaTime * Lookup.entitySpeedArray[_type];
				_centerPoint.y += fearVector.y * deltaTime * Lookup.entitySpeedArray[_type];
				updatePosition();
			}
			_lastMoveTime = _masterTime;
		}
		
<<<<<<< HEAD
		protected function updatePosition():void
		{
			trace('image x ' + _image.x);
			_image.x = _centerPoint.x - (_image.width * 0.5);
			_image.y = _centerPoint.y - (_image.height * 0.5);	
		}
		
=======
>>>>>>> 9d6e5c4e9f75de84083d866cd9f921e7151d3a16
		public function attackTick():void
		{
			var distance:Number = 0;
			var closestDistance:Number = 10000;
			var closestEntity:Entity = null;
			var deltaTime:Number = _masterTime - _lastAttackTime;
			if(!canAttack())
			{
				return;
			}
			for each (var enemy:Entity in _hitList)
			{
				if(enemy === this)
				{
					continue;
				}
				distance = distanceFromEntity(enemy);
				if(!(Lookup.entityFactionMatrix[enemy.type] == Lookup.entityFactionMatrix[_type] == 0) && distance <= closestDistance)
				{
					closestEntity = enemy;
					closestDistance = distance;
				}
			}
			
			if(closestEntity === null)
			{
				return;
			}
			_lastAttackTime = _masterTime;
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
		
		
		
		public function updateFearVector():void
		{
			var scale:Number;
			var newFearFector:Point = new Point();
			for each (var enemy:Entity in _hitList)
			{
				if(enemy === this)
				{					
					continue;
				}
				scale = Lookup.entityFactionMatrix[type][enemy.type] * (enemy.getHealth() / 100) * Math.exp(-distanceFromEntity(enemy) * 1/100);
				newFearFector.x *= scale;
				newFearFector.y *= scale;
				newFearFector = newFearFector.add(enemy._centerPoint.subtract(_centerPoint)); 
			}
			fearVector = (fearVector.add(newFearFector));
			fearVector.x *= 0.5;
			fearVector.y *= 0.5;
		}
	}
}