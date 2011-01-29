package com.lookup
{
	public class Lookup
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
		
		public static const entityFactionMatrix:Object = 
			{
				PANDA:{ 
					PANDA:-0.1, SEAL:0.0, TIGER:0.1, COMMANDO:-0.3, MARINE:-0.5, FIRE:-0.6, TREE:0.2, PANDA_BAIT:0.8, SEAL_BAIT:-0.2, TIGER_BAIT:0.3, MINE:0
				},
				SEAL:{
					PANDA:0.0, SEAL:0.2, TIGER:-0.2, COMMANDO:-0.4, MARINE:-0.4, FIRE:-0.4, TREE:0.1, PANDA_BAIT:0.2, SEAL_BAIT:0.5, TIGER_BAIT:-0.3, MINE:0
				},
				TIGER:{
					PANDA:-0.1, SEAL:0.3, TIGER:0, COMMANDO:-0.3, MARINE:-0.5, FIRE:-0.7, TREE:0.1, PANDA_BAIT:-0.1, SEAL_BAIT:0.2, TIGER_BAIT:1, MINE:0
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
		
		public static const entityDamageMatrix:Object = 
			{
				PANDA:{ 
					PANDA:5, SEAL:0, TIGER:0, COMMANDO:-35, MARINE:-20, FIRE:-80, TREE:10, PANDA_BAIT:15, SEAL_BAIT:-5, TIGER_BAIT:8, MINE:-100
				},
				SEAL:{
					PANDA:0, SEAL:0, TIGER:-5, COMMANDO:-50, MARINE:-30, FIRE:-100, TREE:5, PANDA_BAIT:10, SEAL_BAIT:20, TIGER_BAIT:0, MINE:-100
				},
				TIGER:{
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:-40, MARINE:-25, FIRE:-90, TREE:0, PANDA_BAIT:-5, SEAL_BAIT:3, TIGER_BAIT:8, MINE:-100
				},
				COMMANDO:{
					PANDA:-30, SEAL:-10, TIGER:-40, COMMANDO:-10, MARINE:0, FIRE:-100, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0
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
		
		public static const entityRangeArray:Object = 
			{
				PANDA:			30,
				SEAL:			30,
				TIGER:			30,
				COMMANDO:		30,
				MARINE:			30,
				FIRE:			30,
				TREE:			30,
				PANDA_BAIT:		30,
				SEAL_BAIT:		30,
				TIGER_BAIT:		30,
				MINE:			30
			};
		
		public static const entityROFArray:Object = 
			{
				PANDA:			1,
				SEAL:			1,
				TIGER:			1,
				COMMANDO:		1,
				MARINE:			1,
				FIRE:			1,
				TREE:			1,
				PANDA_BAIT:		1,
				SEAL_BAIT:		1,
				TIGER_BAIT:		1,
				MINE:			1
			};
		
		public static const entitySpeedArray:Object = 
			{
				PANDA:			1,
				SEAL:			1,
				TIGER:			1,
				COMMANDO:		1,
				MARINE:			1,
				FIRE:			1,
				TREE:			1,
				PANDA_BAIT:		1,
				SEAL_BAIT:		1,
				TIGER_BAIT:		1,
				MINE:			1
			};
		
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
		
		public function Lookup()
		{
			
		}
	}
}