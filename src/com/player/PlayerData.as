package com.player
{
	import com.lookup.Lookup;
	import com.player.tools.Tool;

	public class PlayerData
	{
		private var _tools:Vector.<Tool>;
		public var money:int;
		
		public function PlayerData()
		{
			money = Lookup.playersStartingData.money;
			var ids:Array = [Lookup.PANDA_BAIT_TOOL, Lookup.FIRE_TOOL, Lookup.MARINES_TOOL, Lookup.COMMANDO_TOOL, Lookup.SEAL_BAIT_TOOL, Lookup.TIGER_BAIT_TOOL, Lookup.MINES_TOOL];
			_tools = new Vector.<Tool>(ids.length, true);
			for(var i:int = 0; i < _tools.length; i++)
			{
				_tools[i] = new Tool(ids[i]);
			}
		}
		
		public function getTool(id:String):Tool
		{
			var tool:Tool;
			for(var i:int = 0; i < _tools.length; i++)
			{
				tool = _tools[i];
				if(tool.type == id)
				{
					return tool;
				}
			}
			
			return null;
		}
	}
}