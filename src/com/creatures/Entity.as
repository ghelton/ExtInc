package com.creatures
{
	import com.lookup.AskJon;
	
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
		private var _health:Number;
		private var _centerPoint:Point;
		
		protected static const TEMP_ENTITY_SIZE:Number = 5;
		private var _attackWasBenefitial:Boolean;
		
		private var _lastAttackTime:Number = 0;
		private var _lastMoveTime:Number = 0;
		private var _lastRegenTime:Number = 0;
		
		public function Entity($graphic:Sprite, $health:Number, $point:Point, $type:String)
		{
			super();
			
			_lastRegenTime = _lastMoveTime = _masterTime;
			_type = $type;
			_image = $graphic;
			_health = $health;
			_centerPoint = $point;
			
			if(_image == null)
			{
				var tempGraphic:Sprite = new Sprite();
				with(tempGraphic.graphics)
				{
					beginFill(AskJon.colorOf[type], 0.8);
					drawCircle(0, 0, TEMP_ENTITY_SIZE);
					endFill();
				}
				_image = tempGraphic;
			}
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
			if(isNaN(_health))
				trace("what the fuck");
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
			return _health > 0 && ((AskJon.entityROFArray[_type] + _lastAttackTime) < _masterTime);
		}
		
		public function distanceFromEntity(other:Entity):Number
		{
			return other._centerPoint.subtract(_centerPoint).length;
		}
		
		
		//ACTUAL CODE
		
		public function attackEntity(enemy:Entity):Number
		{
			var healthChange:Number = AskJon.entityDamageMatrix[_type][enemy.type];
			
			if(isNaN(healthChange))
				trace("fuck yall");
			if(isNaN(_health))
				trace("fuck yall");
			if((_health + healthChange) < 0)
			{
				_health = 0;
				dispatchEvent(new EntityEvent(EntityEvent.KILLED, this));
			} else {
				_health += healthChange;	
			}
			return healthChange;
		}
		
		private function regenerate():void
		{
			var deltaTime:Number = _masterTime - _lastRegenTime;
			var deltaHealth:Number = deltaTime * AskJon.entityRegenArray[_type];
			_health += deltaHealth;
			_lastRegenTime = _masterTime;
		}
		
		protected function updatePosition():void
		{
			_image.x = _centerPoint.x - (_image.width * 0.5);
			_image.y = _centerPoint.y - (_image.height * 0.5);	
		}
		
		public function moveTick():void
		{
			var deltaTime:Number = _masterTime - _lastMoveTime;
			if(_attackWasBenefitial)
			{
				
			} else {
				if(fearVector.x < 0.01 && fearVector.y < .01)
				{
					_lastMoveTime = _masterTime;
					return;
				}
				
				_centerPoint.x += fearVector.x * deltaTime * AskJon.entitySpeedArray[_type];
				_centerPoint.y += fearVector.y * deltaTime * AskJon.entitySpeedArray[_type];

				updatePosition();
			}
			_lastMoveTime = _masterTime;
		}
		
		public function attackTick():void
		{
			var distance:Number = 0;
			var closestDistance:Number = Number.POSITIVE_INFINITY;
			var bestEntity:Entity = null;
			var deltaTime:Number = _masterTime - _lastAttackTime;
			
			regenerate();
			
			if(!canAttack())
			{
				return;
			}
			
			var sortedHitList:Vector.<Entity> = null;
			for each (var enemy:Entity in _hitList)
			{
				if(enemy === this)
				{
					continue;
				}
				distance = distanceFromEntity(enemy);
				if(!(AskJon.entityDamageMatrix[enemy.type] == AskJon.entityDamageMatrix[_type] == 0)
					&& (distance <= closestDistance && distance <= AskJon.entityRangeArray[_type])
					&& (bestEntity === null || AskJon.entityFactionMatrix[_type][enemy.type] > AskJon.entityFactionMatrix[_type][bestEntity.type]))
				{
					bestEntity = enemy;
					closestDistance = distance;
				}
			}
			
			if(bestEntity === null)
			{
				return;
			}
			_lastAttackTime = _masterTime;
			_attackWasBenefitial = attackEntity(bestEntity) > 0; 
			bestEntity.riposte(this);
		}
		
		public function riposte(attacker:Entity):void
		{
			if(canAttack())
			{
				attackEntity(attacker);
			}	
		}
		
		public function updateFearVector():void
		{
			var scale:Number;
			var newFearVector:Point = new Point();
			var differenceVector:Point;
			for each (var enemy:Entity in _hitList)
			{
				if(enemy === this)
				{					
					continue;
				}
				scale = enemy.getHealth() > 0 ? AskJon.entityFearMatrix[type][enemy.type] * (.25 + .75 * (enemy.getHealth() * 1/100)) * Math.exp(-distanceFromEntity(enemy) * 1/100) : 0;
				
				differenceVector = enemy._centerPoint.subtract(_centerPoint);
				differenceVector.normalize(1);
				differenceVector.x *= scale;
				differenceVector.y *= scale;
				
				newFearVector = newFearVector.add(differenceVector); 
			}
			fearVector = (fearVector.add(newFearVector));
			fearVector.x *= 0.5;
			fearVector.y *= 0.5;
		}
	}
}