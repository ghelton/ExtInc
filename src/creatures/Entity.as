package creatures
{
	
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	import lookup.Lookup;
	
	import utils.Element;
	
	public class Entity extends Element
	{
		public static var _masterTime:Number;

		public var fearVector:Point;
		private var _type:int;
		private var _hitList:Vector.<Entity>;
		private var _image:Sprite;
		private var _health:Number; //uint maybe?
		private var _centerPoint:Point;
		
		private var _attackWasBenefitial:Boolean;
		
		private var _lastAttackTime:int;
		private var _lastMoveTime:int;
		
		public function Entity($graphic:Sprite, $health:Number, $point:Point, $type:int)
		{
			_image = $graphic;
			_health = $health;
			_centerPoint = $point;
			_attackWasBenefitial = false;
			super();
		}
		
		//GETTERS AND SETTERS
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
		public function updateFearVector():void
		{
			var newFearFector:Point = null;
			for each (var enemy in _hitList)
			{
				newFearFector += enemy.centerPoint().subtract(_centerPoint) * Lookup.entityFactionMatrix[_type][enemy.type()] * (enemy.getHealth / 100) * Math.exp(distanceFromEntity(enemy) / 100); 
			}
			fearVector = (fearVector + newFearFector) * 1/2;
		}
		public function attackEntity(enemy:Entity, timeDelta:Number):void
		{
			
		}
		
		public function moveTick():void
		{
			if(_attackWasBenefitial)
			{
				
			} else {
				_centerPoint.x += fearVector.x * _lastMoveTime;
				_centerPoint.y += fearVector.y * _lastMoveTime;
				_image.x = _centerPoint.x;
				_image.y = _centerPoint.y;	
			}
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