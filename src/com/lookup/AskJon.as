package com.lookup
{
	import com.creatures.Commando;
	import com.creatures.Fire;
	import com.creatures.Marine;
	import com.creatures.Mine;
	import com.creatures.Panda;
	import com.creatures.PandaBait;
	import com.creatures.Seal;
	import com.creatures.SealBait;
	import com.creatures.Tiger;
	import com.creatures.TigerBait;
	import com.creatures.Tree;

	public class AskJon
	{
		//Animals
		public static const PANDA:String 				= 'PANDA';
		public static const SEAL:String 				= 'SEAL';
		public static const TIGER:String 				= 'TIGER';
		
		//Units
		public static const COMMANDO:String 			= 'COMMANDO';
		public static const MARINE:String 				= 'MARINE';
		public static const MINE:String					= 'MINE';
		
		//Environmental
		public static const TREE:String 				= 'TREE';
		public static const FIRE:String					= 'FIRE';
		
		//ENTITIES
		public static const PANDA_BAIT:String			= 'PANDA_BAIT';
		public static const SEAL_BAIT:String			= 'SEAL_BAIT';
		public static const TIGER_BAIT:String			= 'TIGER_BAIT';
		
		
		//TOOLS
		public static const PANDA_BAIT_TOOL:String		= 'PANDA_BAIT_TOOL';
		public static const SEAL_BAIT_TOOL:String		= 'SEAL_BAIT_TOOL';
		public static const TIGER_BAIT_TOOL:String		= 'TIGER_BAIT_TOOL';
		public static const FIRE_TOOL:String			= 'FIRE_TOOL';
		public static const MINES_TOOL:String			= 'MINES_TOOL';
		public static const MARINES_TOOL:String			= 'MARINES_TOOL';
		public static const COMMANDO_TOOL:String		= 'COMMANDO_TOOL';
		
		//Inclination for an entity type to move towards or away from another entity type
		public static const entityFearMatrix:Object = 
			{
				PANDA:{ 
					PANDA:-0.05, SEAL:0.0, TIGER:0, COMMANDO:-0.3, MARINE:-0.5, FIRE:-0.3, TREE:0.2, PANDA_BAIT:0.5, SEAL_BAIT:-0.2, TIGER_BAIT:0.3, MINE:0
				},
				SEAL:{
					PANDA:0.0, SEAL:0.3, TIGER:-0.05, COMMANDO:-0.4, MARINE:-0.4, FIRE:-0.2, TREE:0.1, PANDA_BAIT:0.2, SEAL_BAIT:0.5, TIGER_BAIT:-0.3, MINE:0
				},
				TIGER:{
					PANDA:-0.1, SEAL:1, TIGER:-0.05, COMMANDO:-0.3, MARINE:-0.5, FIRE:-0.4, TREE:0.1, PANDA_BAIT:-0.1, SEAL_BAIT:0.2, TIGER_BAIT:0.5, MINE:0
				},
				COMMANDO:{
					PANDA:0.4, SEAL:0.4, TIGER:0.4, COMMANDO:0.4, MARINE:0, FIRE:0, TREE:0.1, PANDA_BAIT:0.1, SEAL_BAIT:0.1, TIGER_BAIT:0.1, MINE:0
				},
				MARINE:{
					PANDA:0.0, SEAL:0.0, TIGER:0, COMMANDO:0, MARINE:-0.2, FIRE:0, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0
				},
				FIRE:{
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:0, MARINE:0, FIRE:0, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0
				},
				TREE:{
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:0, MARINE:0, FIRE:0, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0
				},
				PANDA_BAIT:{
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:0, MARINE:0, FIRE:0, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0
				},
				SEAL_BAIT:{
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:0, MARINE:0, FIRE:0, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0
				},
				TIGER_BAIT:{
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:0, MARINE:0, FIRE:0, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0
				},
				MINE:{
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:0, MARINE:0, FIRE:0, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0
				}
			};
		
		//Ranking of agression order for one entity. Values used to determine attack priority. A value of zero indicates an entity will not attack another entity.
		public static const entityFactionMatrix:Object = 
			{
				PANDA:{ 
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:1, MARINE:1, FIRE:0, TREE:2, PANDA_BAIT:4, SEAL_BAIT:3, TIGER_BAIT:0, MINE:0
				},
				SEAL:{
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:1, MARINE:1, FIRE:0, TREE:2, PANDA_BAIT:3, SEAL_BAIT:4, TIGER_BAIT:0, MINE:0
				},
				TIGER:{
					PANDA:0, SEAL:1, TIGER:0, COMMANDO:2, MARINE:2, FIRE:0, TREE:0, PANDA_BAIT:0, SEAL_BAIT:2, TIGER_BAIT:3, MINE:0
				},
				COMMANDO:{
					PANDA:1, SEAL:1, TIGER:1, COMMANDO:1, MARINE:1, FIRE:0, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0
				},
				MARINE:{
					PANDA:1, SEAL:1, TIGER:1, COMMANDO:0, MARINE:0, FIRE:0, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0
				},
				FIRE:{
					PANDA:1, SEAL:1, TIGER:1, COMMANDO:0, MARINE:0, FIRE:0, TREE:1, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0
				},
				TREE:{
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:0, MARINE:0, FIRE:0, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0
				},
				PANDA_BAIT:{
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:0, MARINE:0, FIRE:0, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0
				},
				SEAL_BAIT:{
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:0, MARINE:0, FIRE:0, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0
				},
				TIGER_BAIT:{
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:0, MARINE:0, FIRE:0, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0
				},
				MINE:{
					PANDA:1, SEAL:1, TIGER:1, COMMANDO:0, MARINE:0, FIRE:0, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0
				}
			};
		
		public static const entityDamageMatrix:Object = 
			{
				PANDA:{ 
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:-35, MARINE:-20, FIRE:-80, TREE:10, PANDA_BAIT:15, SEAL_BAIT:-5, TIGER_BAIT:8, MINE:-100
				},
				SEAL:{
					PANDA:0, SEAL:0, TIGER:-20, COMMANDO:-50, MARINE:-30, FIRE:-100, TREE:5, PANDA_BAIT:10, SEAL_BAIT:20, TIGER_BAIT:0, MINE:-100
				},
				TIGER:{
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:-40, MARINE:-25, FIRE:-90, TREE:0, PANDA_BAIT:-5, SEAL_BAIT:3, TIGER_BAIT:8, MINE:-100
				},
				COMMANDO:{
					PANDA:-30, SEAL:-10, TIGER:-40, COMMANDO:-80, MARINE:0, FIRE:-100, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0
				},
				MARINE:{
					PANDA:-35, SEAL:-20, TIGER:-60, COMMANDO:-10, MARINE:0, FIRE:-100, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0
				},
				FIRE:{
					PANDA:10, SEAL:10, TIGER:5, COMMANDO:0, MARINE:0, FIRE:0, TREE:20, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0
				},
				TREE:{
					PANDA:-5, SEAL:-10, TIGER:0, COMMANDO:0, MARINE:0, FIRE:-30, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0
				},
				PANDA_BAIT:{
					PANDA:25, SEAL:25, TIGER:25, COMMANDO:0, MARINE:0, FIRE:20, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0
				},
				SEAL_BAIT:{
					PANDA:25, SEAL:25, TIGER:25, COMMANDO:0, MARINE:0, FIRE:20, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0
				},
				TIGER_BAIT:{
					PANDA:25, SEAL:25, TIGER:25, COMMANDO:0, MARINE:0, FIRE:20, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0
				},
				MINE:{
					PANDA:100, SEAL:100, TIGER:100, COMMANDO:0, MARINE:0, FIRE:0, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0
				}
			};
		
		//range
		public static const entityRangeArray:Object = 
			{
				PANDA:			30,
				SEAL:			10,
				TIGER:			35,
				COMMANDO:		25,
				MARINE:			80,
				FIRE:			60,
				TREE:			10,
				PANDA_BAIT:		10,
				SEAL_BAIT:		10,
				TIGER_BAIT:		10,
				MINE:			20
			};
		
		//rate of fire
		public static const entityROFArray:Object = 
			{
				PANDA:			1,
				SEAL:			1,
				TIGER:			1,
				COMMANDO:		1,
				MARINE:			1,
				FIRE:			1,
				TREE:			0,
				PANDA_BAIT:		0,
				SEAL_BAIT:		0,
				TIGER_BAIT:		0,
				MINE:			1
			};
		
		//
		public static const entitySpeedArray:Object = 
			{
				PANDA:			20,
				SEAL:			10,
				TIGER:			100,
				COMMANDO:		40,
				MARINE:			30,
				FIRE:			0,
				TREE:			0,
				PANDA_BAIT:		0,
				SEAL_BAIT:		0,
				TIGER_BAIT:		0,
				MINE:			0
			};
		
		//Health regen per second
		public static const entityRegenArray:Object = 
			{
				PANDA:			-1.0,
				SEAL:			-1.0,
				TIGER:			-1.0,
				COMMANDO:		-10.0,
				MARINE:			-20.0,
				FIRE:			-10.0,
				TREE:			5.0,
				PANDA_BAIT:		0.0,
				SEAL_BAIT:		0.0,
				TIGER_BAIT:		0.0,
				MINE:			0.0
			};
		
		//Prey agro range
		public static const entityPreyAgroRangeArray:Object = 
			{
				PANDA:			500,
				SEAL:			500,
				TIGER:			500,
				COMMANDO:		500,
				MARINE:			500,
				FIRE:			500,
				TREE:			500,
				PANDA_BAIT:		500,
				SEAL_BAIT:		500,
				TIGER_BAIT:		500,
				MINE:			500
			};
		
		//Predator agro range
		public static const entityPredatorAgroRangeArray:Object = 
			{
				PANDA:			200,
				SEAL:			200,
				TIGER:			200,
				COMMANDO:		200,
				MARINE:			200,
				FIRE:			200,
				TREE:			200,
				PANDA_BAIT:		200,
				SEAL_BAIT:		200,
				TIGER_BAIT:		200,
				MINE:			200
			};
		
		//toolz
		public static const toolStats:Object =
			{
				PANDA_BAIT_TOOL:	{cooldown:5, cost:100},
				SEAL_BAIT_TOOL:		{cooldown:5, cost:100},
				TIGER_BAIT_TOOL:	{cooldown:5, cost:100},
				FIRE_TOOL:			{cooldown:5, cost:100},
				MINES_TOOL:			{cooldown:5, cost:100},
				MARINES_TOOL:		{cooldown:5, cost:100},
				COMMANDO_TOOL:		{cooldown:5, cost:100}
			};
		
		public static const classLookup:Object =
			{
				PANDA: 			Panda,
				TIGER: 			Tiger,
				SEAL: 			Seal,
				COMMANDO:		Commando,
				MARINE:			Marine,
				FIRE:			Fire,
				TREE:			Tree,
				PANDA_BAIT:		PandaBait,
				SEAL_BAIT:		SealBait,
				TIGER_BAIT:		TigerBait,
				MINE:			Mine
			}
		
		public static const colorOf:Object =
			{
				PANDA: 			0x000000,//gray
				TIGER: 			0xff6c00,//orange
				SEAL: 			0x696cb3,//blue gray
				COMMANDO:		0x00690a,//dark green
				MARINE:			0xff00d8,//pink
				FIRE:			0xfffc00,//yellow
				TREE:			0x00ff12,//light green
				PANDA_BAIT:		0x00AABB,
				SEAL_BAIT:		0x0AABB0,
				TIGER_BAIT:		0xAABB00,
				MINE:			0xCC00DD
			}
		public function AskJon()
		{
			
		}
	}
}