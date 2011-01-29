package player
{
	import lookup.Lookup;
	
	import player.tools.Tool;

	public class PlayerData
	{
		private var tools:Vector.<Tool>;
		public var money:int;
		
		public function PlayerData($startingMoney:int)
		{
			money = $startingMoney;
			tools = new Vector.<Tool>(3, true);
		}
	}
}