package com.creatures
{
	import com.UI.UILoader;
	import com.lookup.AskTony;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Tree extends Entity
	{
		public function Tree($health:Number, $point:Point)
		{
//			treeeees
//			var tempGraphic:Sprite = new Sprite();
//			with(tempGraphic.graphics)
//			{
//				beginFill(0x00CCA0, 0.5);
//				drawCircle(0, 0, Entity.TEMP_ENTITY_SIZE);
//				endFill();
//			}
			var tree:UILoader = new UILoader('assets/treeeees.swf', Entity.TEMP_ENTITY_SIZE, Entity.TEMP_ENTITY_SIZE);

			super(tree, $health, $point, AskTony.TREE);
		}
		
		
		
		protected override function changeHealth(healthDelta:Number):void
		{
			_image.scaleX = _image.scaleY = (this.getHealth() / 200) + 0.5;
			super.changeHealth(healthDelta);
		}
	}
}