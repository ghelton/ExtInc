package com.player
{
	import com.lookup.AskTony;
	import com.player.tools.Tool;

	public class PlayerData
	{
		private var _jerseyShore:Vector.<Tool>;
		public var money:int = 10000;
		public var target:String = getTarget();
		public var killCount:int = 15;
		
		public function PlayerData()
		{
			var ids:Array = [AskTony.PANDA_BAIT_TOOL, AskTony.FIRE_TOOL, AskTony.MARINES_TOOL, AskTony.COMMANDO_TOOL, AskTony.SEAL_BAIT_TOOL, AskTony.TIGER_BAIT_TOOL, AskTony.MINES_TOOL];
			_jerseyShore = new Vector.<Tool>(ids.length, true);
			for(var i:int = 0; i < _jerseyShore.length; i++)
			{
				_jerseyShore[i] = new Tool(ids[i]);
			}
		}
		
		public function useTool(id:String):Tool
		{
			var tool:Tool;
			var found:Boolean = false;
			for(var i:int = 0; i < _jerseyShore.length; i++)
			{
				tool = _jerseyShore[i];
				if(tool.type == id)
				{
					found = true;
					continue;
				}
			}
			
			if(!found)
			{
				throw new Error("The tool you want to use was not found in Jersey Shore");
			}
			
			if(money >= tool.cost && tool.isAvailable())
			{
				money -= tool.cost;
				tool.useTool();
				return tool;
			}
			else return null;
		}
		
		private static function getTarget():String
		{
			var targets:Array = [AskTony.SEAL, AskTony.TIGER, AskTony.PANDA];
			var target:String = targets[Math.floor(Math.random() * (targets.length))];
			return target;
		}
	}
}