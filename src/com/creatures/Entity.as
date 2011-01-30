package com.creatures
{
	import com.UI.UILoader;
	import com.lookup.AskJon;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	
	public class Entity extends EventDispatcher
	{
		public static var _masterTime:Number;
		public static var bounds:Rectangle;
		
		public static function setMasterTime(masterTime:Number):void
		{
			_masterTime = masterTime;
		}
		
		public function setHitList(list:Vector.<Entity>):void
		{
			_hitList = list;
		}

		private var _speed:Number = 0;
		public var fearVector:Point = new Point();
		private var _type:String;
		private var _hitList:Vector.<Entity>;
		private var _image:Sprite;
		private var _health:Number;
		private var _centerPoint:Point;
		private var _rotation:Number;
		
		protected static const TEMP_ENTITY_SIZE:Number = 50;
		protected static const PLACEHOLDER_SIZE:Number = 5;
		private var _attackWasBenefitial:Boolean;
		
		private var _lastAttackTime:Number = 0;
		private var _lastMoveTime:Number = 0;
		private var _lastRegenTime:Number = 0;
		
		public function Entity($graphic:Sprite, $health:Number, $point:Point, $type:String)
		{
			super();
			
			_type = $type;
			_speed = Number(AskJon.entitySpeedArray[_type]);
			_image = $graphic;
			_health = $health;
			_centerPoint = $point;
			
			if(_image == null)
			{
				_image = new Sprite();
				with(_image.graphics)
				{
					beginFill(AskJon.colorOf[type], 0.8);
					drawCircle(0, 0, PLACEHOLDER_SIZE);
					endFill();
				}
			}
			_attackWasBenefitial = false;
			
			if(_image is UILoader)
				(_image as UILoader).onComplete = loaderInit;
			else
				_image.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function loaderInit(e:Event):void
		{
			if(_image.stage)
				init(e);
			else
				_image.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event = null):void
		{
			_lastRegenTime = _lastMoveTime = _masterTime;
//			_image.removeEventListener(Event.REMOVED_FROM_STAGE, init);
			updatePosition();
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
			
			changeHealth(healthChange);
			return healthChange;
		}
		private function changeHealth(healthDelta:Number):void
		{
			_health += healthDelta;	
			if((_health) < 0)
			{
				_health = 0;
				dispatchEvent(new EntityEvent(EntityEvent.KILLED, this));
			} 
			else if(_health >= 200)
				dispatchEvent(new EntityEvent(EntityEvent.SPLIT, this));
		}
		private function regenerate():void
		{
			var deltaTime:Number = _masterTime - _lastRegenTime;
			var deltaHealth:Number = deltaTime * AskJon.entityRegenArray[_type];
			changeHealth(deltaHealth);
			_lastRegenTime = _masterTime;
		}
		
		protected function updatePosition():void
		{
			_centerPoint.x %= bounds.width;
			_centerPoint.y %= bounds.height;
			
			var $bounds:Rectangle = _image.getBounds(_image.parent);
			
			_image.x = (_centerPoint.x);
			_image.y = (_centerPoint.y);	
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
				
				var deltaVector:Point = new Point(fearVector.x * deltaTime * _speed
													, fearVector.y * deltaTime * _speed);
				
				_centerPoint.x += deltaVector.x;
				_centerPoint.y += deltaVector.y;

				
				var targetRotation:Number = ((Math.atan2(deltaVector.y, deltaVector.x) * 180 / Math.PI)) - 90;
				//			_image.rotation += Math.min(Math.max(-15,(targetRotation - _image.rotation) * 0.5), 15);
				_image.rotation = targetRotation;
				
				var vectLength:Number;
				var checkVect:Point;
				var dot:Number;
				for each(var entity:Entity in _hitList)
				{
					if(entity === this)
						continue
					checkVect = entity._centerPoint.subtract(_centerPoint);
					vectLength = checkVect.length;
					if(vectLength < _image.width)
					{
						checkVect.normalize((vectLength - _image.width));
						_centerPoint = _centerPoint.add(checkVect);
					}
				}
				
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
			for each (var enemy:Entity in _hitList)
			{
				if(enemy === this)
				{
					continue;
				}
				distance = distanceFromEntity(enemy);
				if( AskJon.entityFactionMatrix[_type][enemy.type] > 0
					&& (distance <= closestDistance && distance <= AskJon.entityRangeArray[_type])
					&& (bestEntity === null || AskJon.entityFactionMatrix[_type][enemy.type] >= AskJon.entityFactionMatrix[_type][bestEntity.type]))
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
			var bestVector:Point = new Point();
			var newFearVector:Point = new Point();
			var differenceVector:Point;
			for each (var enemy:Entity in _hitList)
			{
				if(enemy === this)
				{					
					continue;
				}
				//trace(AskJon.entityFearMatrix[type][enemy.type] + "    " + (.25 + .75 * (enemy.getHealth() * 1/100)) + "    " + Math.exp(-distanceFromEntity(enemy) * 1/100));
				scale = enemy.getHealth() > 0 ? AskJon.entityFearMatrix[type][enemy.type] * (.25 + .75 * (enemy.getHealth() * 1/100)) * Math.exp(-distanceFromEntity(enemy) * 1/100) : 0;
				
				differenceVector = enemy._centerPoint.subtract(_centerPoint);
				differenceVector.normalize(1);
				differenceVector.x *= scale;
				differenceVector.y *= scale;
				//trace(scale);
				if(scale > 0 && scale > bestVector.length)
				{
					bestVector = differenceVector;
				} else if(scale < 0) {
					newFearVector = newFearVector.add(differenceVector); 				
				}
			}
			fearVector = fearVector.add(newFearVector).add(bestVector);
			fearVector.x *= 0.5;
			fearVector.y *= 0.5;
			
		}
	}
}