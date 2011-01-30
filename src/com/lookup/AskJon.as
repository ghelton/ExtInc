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
					PANDA:-0.1, SEAL:0.0, TIGER:0.1, COMMANDO:-0.3, MARINE:-0.5, FIRE:-0.6, TREE:0.2, PANDA_BAIT:0.8, SEAL_BAIT:-0.2, TIGER_BAIT:0.3, MINE:0
				},
				SEAL:{
					PANDA:0.0, SEAL:0.2, TIGER:-0.2, COMMANDO:-0.4, MARINE:-0.4, FIRE:-0.4, TREE:0.1, PANDA_BAIT:0.2, SEAL_BAIT:0.5, TIGER_BAIT:-0.3, MINE:0
				},
				TIGER:{
					PANDA:-0.1, SEAL:0.3, TIGER:-0.2, COMMANDO:-0.3, MARINE:-0.5, FIRE:-0.7, TREE:0.1, PANDA_BAIT:-0.1, SEAL_BAIT:0.2, TIGER_BAIT:1, MINE:0
				},
				COMMANDO:{
					PANDA:0.9, SEAL:0.9, TIGER:0.9, COMMANDO:1, MARINE:0, FIRE:0, TREE:0.2, PANDA_BAIT:0.2, SEAL_BAIT:0.2, TIGER_BAIT:0.2, MINE:0
				},
				MARINE:{
					PANDA:0.0, SEAL:0.0, TIGER:0, COMMANDO:0, MARINE:-0.5, FIRE:0, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0
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
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:0, MARINE:0, FIRE:0, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0
				},
				SEAL:{
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:0, MARINE:0, FIRE:0, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0
				},
				TIGER:{
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:0, MARINE:0, FIRE:0, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0
				},
				COMMANDO:{
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:0, MARINE:0, FIRE:0, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0
				},
				MARINE:{
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:0, MARINE:0, FIRE:0, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0
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
		
		public static const entityDamageMatrix:Object = 
			{
				PANDA:{ 
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:-35, MARINE:-20, FIRE:-80, TREE:10, PANDA_BAIT:15, SEAL_BAIT:-5, TIGER_BAIT:8, MINE:-100
				},
				SEAL:{
					PANDA:0, SEAL:0, TIGER:-5, COMMANDO:-50, MARINE:-30, FIRE:-100, TREE:5, PANDA_BAIT:10, SEAL_BAIT:20, TIGER_BAIT:0, MINE:-100
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
				COMMANDO:		80,
				MARINE:			55,
				FIRE:			10,
				TREE:			10,
				PANDA_BAIT:		10,
				SEAL_BAIT:		10,
				TIGER_BAIT:		10,
				MINE:			20
			};
		
		//rate of fire, attacks per second
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
				PANDA:			2,
				SEAL:			1,
				TIGER:			4,
				COMMANDO:		4,
				MARINE:			3,
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
				PANDA: 			0x8a8a8a,//gray
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