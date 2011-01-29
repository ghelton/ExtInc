package com.gameBoard
{
	import com.creatures.Entity;
	import com.lookup.Lookup;
	
	import flash.geom.Point;

	public class EntityController
	{
		public function EntityController()
		{
			
		}
		
		
		public static function updateFearVector(entity:Entity):void
		{
			var fearVector:Point;
			var scale:Number;
			var newFearFector:Point = new Point();
			for each (var enemy:Entity in GameBoard.entities)
			{
				scale = Lookup.entityFactionMatrix[entity.type][enemy.type] * (enemy.getHealth() / 100) * Math.exp(-entity.distanceFromEntity(enemy) * 1/100);
				newFearFector = newFearFector.add(enemy.centerPoint.subtract(entity.centerPoint)); 
				newFearFector.x *= scale;
				newFearFector.y *= scale;
			}
			fearVector = (entity.fearVector.add(newFearFector));
			fearVector.x *= 0.5;
			fearVector.y *= 0.5;
			entity.fearVector = fearVector;
		}
	}
}