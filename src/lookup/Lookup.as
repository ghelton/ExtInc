package lookup
{
	public class Lookup
	{
		//Animals
		public static const PANDA:int 				= 100;
		public static const SEAL:int 				= 101;
		public static const TIGER:int 				= 102;
		
		//Units
		public static const COMMANDO:int 			= 200;
		public static const MARINE:int 				= 201;
		
		//Environmental
		public static const FIRE:int 				= 300;
		public static const TREE:int 				= 301;
		
		//BAITS
		public static const PANDA_BAIT_REG 			= 400;
		public static const SEAL_BAIT_REG 			= 401;
		public static const TIGER_BAIT_REG 			= 402;
		
		public static const factionMatrix:Object = 
			{
				PANDA:{ 
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:0, MARINE:0, FIRE:0, TREE:0, PANDA_BAIT_REG:0, SEAL_BAIT_REG:0, TIGER_BAIT_REG:0
				},
				SEAL:{
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:0, MARINE:0, FIRE:0, TREE:0, PANDA_BAIT_REG:0, SEAL_BAIT_REG:0, TIGER_BAIT_REG:0
				},
				TIGER:{
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:0, MARINE:0, FIRE:0, TREE:0, PANDA_BAIT_REG:0, SEAL_BAIT_REG:0, TIGER_BAIT_REG:0
				},
				COMMANDO:{
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:0, MARINE:0, FIRE:0, TREE:0, PANDA_BAIT_REG:0, SEAL_BAIT_REG:0, TIGER_BAIT_REG:0
				},
				MARINE:{
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:0, MARINE:0, FIRE:0, TREE:0, PANDA_BAIT_REG:0, SEAL_BAIT_REG:0, TIGER_BAIT_REG:0
				},
				FIRE:{
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:0, MARINE:0, FIRE:0, TREE:0, PANDA_BAIT_REG:0, SEAL_BAIT_REG:0, TIGER_BAIT_REG:0
				},
				TREE:{
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:0, MARINE:0, FIRE:0, TREE:0, PANDA_BAIT_REG:0, SEAL_BAIT_REG:0, TIGER_BAIT_REG:0
				},
				PANDA_BAIT_REG:{
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:0, MARINE:0, FIRE:0, TREE:0, PANDA_BAIT_REG:0, SEAL_BAIT_REG:0, TIGER_BAIT_REG:0
				},
				SEAL_BAIT_REG:{
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:0, MARINE:0, FIRE:0, TREE:0, PANDA_BAIT_REG:0, SEAL_BAIT_REG:0, TIGER_BAIT_REG:0
				},
				TIGER_BAIT_REG:{
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:0, MARINE:0, FIRE:0, TREE:0, PANDA_BAIT_REG:0, SEAL_BAIT_REG:0, TIGER_BAIT_REG:0
				}
			};
		
		
		public function Lookup()
		{
		}
	}
}