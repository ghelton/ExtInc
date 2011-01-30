package com.player
{
	import com.lookup.AskJon;
	import com.player.tools.Tool;

	public class PlayerData
	{
		private var _jerseyShore:Vector.<Tool>;
		public var money:int;
		
		public function PlayerData($money:int)
		{
			money = $money;
			var ids:Array = [AskJon.PANDA_BAIT_TOOL, AskJon.FIRE_TOOL, AskJon.MARINES_TOOL, AskJon.COMMANDO_TOOL, AskJon.SEAL_BAIT_TOOL, AskJon.TIGER_BAIT_TOOL, AskJon.MINES_TOOL];
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
	}
}