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
			_tools = new Vector.<Tool>(6, true);
			
			var tool:Tool;
			for(var i:int = 0; i < _tools.length; i++)
			{
				tool = new Tool(i + 300);
				_tools[i] = tool;
			}
		}
		
		public function getTool(id:int):Tool
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