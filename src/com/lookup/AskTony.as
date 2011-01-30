package com.lookup
{
	import com.creatures.Commando;
	import com.creatures.Distractor;
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

	public class AskTony
	{
		public static const HEALTH_NOISE:Number 		= 0.1;
		//Animals
		public static const PANDA:String 				= 'PANDA';
		public static const SEAL:String 				= 'SEAL';
		public static const TIGER:String 				= 'TIGER';
		
		//Units
		public static const COMMANDO:String 			= 'COMMANDO';
		public static const MARINE:String 				= 'MARINE';
		public static const MINE:String					= 'MINE';
		public static const BOOMBA:String				= 'BOOMBA';
		
		//Environmental
		public static const TREE:String 				= 'TREE';
		public static const FIRE:String					= 'FIRE';
		
		//ENTITIES
		public static const PANDA_BAIT:String			= 'PANDA_BAIT';
		public static const SEAL_BAIT:String			= 'SEAL_BAIT';
		public static const TIGER_BAIT:String			= 'TIGER_BAIT';
		public static const DISTRACTOR:String			= 'DISTRACTOR';
		
		
		//TOOLS
		public static const PANDA_BAIT_TOOL:String		= 'PANDA_BAIT_TOOL';
		public static const SEAL_BAIT_TOOL:String		= 'SEAL_BAIT_TOOL';
		public static const TIGER_BAIT_TOOL:String		= 'TIGER_BAIT_TOOL';
		public static const FIRE_TOOL:String			= 'FIRE_TOOL';
		public static const MINES_TOOL:String			= 'MINES_TOOL';
		public static const MARINES_TOOL:String			= 'MARINES_TOOL';
		public static const COMMANDO_TOOL:String		= 'COMMANDO_TOOL';
		public static const BOOMBA_TOOL:String			= 'BOOMBA_TOOL';
		
		public static const startingQuantities:Object =
			{
				PANDA: 			4,//gray
				TIGER: 			1,//orange
				SEAL: 			4,//blue gray
				COMMANDO:		0,//dark green
				MARINE:			0,//pink
				FIRE:			0,//yellow
				TREE:			4,//light green
				PANDA_BAIT:		0,
				SEAL_BAIT:		0,
				TIGER_BAIT:		0,
				MINE:			0,
				DISTRACTOR:		0
			};
		//Inclination for an entity type to move towards or away from another entity type
		public static const entityFearMatrix:Object = 
			{
				PANDA:{ 
					PANDA:-.1, SEAL:0.0, TIGER:-0.2, COMMANDO:-0.3, MARINE:-0.5, FIRE:-0.8, TREE:1.0, PANDA_BAIT:1, SEAL_BAIT:-0.2, TIGER_BAIT:1, MINE:0
				},
				SEAL:{
					PANDA:0.0, SEAL:0.3, TIGER:-0.2, COMMANDO:-0.4, MARINE:-0.4, FIRE:-0.8, TREE:1, PANDA_BAIT:1, SEAL_BAIT:1, TIGER_BAIT:-0.3, MINE:0
				},
				TIGER:{
					PANDA:0.6, SEAL:0.4, TIGER:-0.05, COMMANDO:-0.3, MARINE:-0.5, FIRE:-0.8, TREE:1, PANDA_BAIT:-0.1, SEAL_BAIT:0.2, TIGER_BAIT:0.8, MINE:0
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
					PANDA:0, SEAL:0, TIGER:1, COMMANDO:2, MARINE:0, FIRE:0, TREE:3, PANDA_BAIT:5, SEAL_BAIT:0, TIGER_BAIT:4, MINE:0
				},
				SEAL:{
					PANDA:0, SEAL:0, TIGER:0, COMMANDO:1, MARINE:1, FIRE:0, TREE:2, PANDA_BAIT:3, SEAL_BAIT:5, TIGER_BAIT:0, MINE:0
				},
				TIGER:{
					PANDA:5, SEAL:4, TIGER:0, COMMANDO:3, MARINE:2, FIRE:0, TREE:1, PANDA_BAIT:0, SEAL_BAIT:6, TIGER_BAIT:7, MINE:0
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
					PANDA:0, SEAL:0, TIGER:-50, COMMANDO:-35, MARINE:-20, FIRE:-80, TREE:10, PANDA_BAIT:20, SEAL_BAIT:-5, TIGER_BAIT:8, MINE:-100, DISTRACTOR:0
				},
				SEAL:{
					PANDA:0, SEAL:0, TIGER:-50, COMMANDO:-50, MARINE:-30, FIRE:-100, TREE:10, PANDA_BAIT:10, SEAL_BAIT:20, TIGER_BAIT:0, MINE:-100, DISTRACTOR:0
				},
				TIGER:{
					PANDA:7, SEAL:7, TIGER:0, COMMANDO:-40, MARINE:-25, FIRE:-90, TREE:0, PANDA_BAIT:-5, SEAL_BAIT:3, TIGER_BAIT:8, MINE:-100, DISTRACTOR:0
				},
				COMMANDO:{
					PANDA:-30, SEAL:-10, TIGER:0, COMMANDO:-80, MARINE:0, FIRE:-100, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0, DISTRACTOR:0
				},
				MARINE:{
					PANDA:-35, SEAL:-20, TIGER:-60, COMMANDO:-10, MARINE:0, FIRE:-100, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0, DISTRACTOR:0
				},
				FIRE:{
					PANDA:10, SEAL:10, TIGER:5, COMMANDO:0, MARINE:0, FIRE:0, TREE:20, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0, DISTRACTOR:0
				},
				TREE:{
					PANDA:-8, SEAL:-8, TIGER:0, COMMANDO:0, MARINE:0, FIRE:-30, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0, DISTRACTOR:0
				},
				PANDA_BAIT:{
					PANDA:-25, SEAL:-50, TIGER:0, COMMANDO:0, MARINE:0, FIRE:20, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0, DISTRACTOR:0
				},
				SEAL_BAIT:{
					PANDA:-25, SEAL:-25, TIGER:-25, COMMANDO:0, MARINE:0, FIRE:20, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0, DISTRACTOR:0
				},
				TIGER_BAIT:{
					PANDA:-25, SEAL:-25, TIGER:-100, COMMANDO:0, MARINE:0, FIRE:20, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0, DISTRACTOR:0
				},
				MINE:{
					PANDA:100, SEAL:100, TIGER:100, COMMANDO:0, MARINE:0, FIRE:0, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0, DISTRACTOR:0
				},
				DISTRACTOR:{
					PANDA:100, SEAL:100, TIGER:100, COMMANDO:0, MARINE:0, FIRE:0, TREE:0, PANDA_BAIT:0, SEAL_BAIT:0, TIGER_BAIT:0, MINE:0, DISTRACTOR:0
				}
			};
		
		//range
		public static const entityRangeArray:Object = 
			{
				PANDA:			50,
				SEAL:			50,
				TIGER:			80,
				COMMANDO:		250,
				MARINE:			130,
				FIRE:			150,
				TREE:			50,
				PANDA_BAIT:		50,
				SEAL_BAIT:		50,
				TIGER_BAIT:		50,
				MINE:			200
			};
		
		//rate of fire
		public static const entityROFArray:Object = 
			{
				PANDA:			1,
				SEAL:			1,
				TIGER:			1,
				COMMANDO:		0.5,
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
				PANDA:			80,
				SEAL:			60,
				TIGER:			95,
				COMMANDO:		160,
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
				TIGER:			-3.0,
				COMMANDO:		-10.0,
				MARINE:			-20.0,
				FIRE:			-50.0,
				TREE:			2,
				PANDA_BAIT:		0.0,
				SEAL_BAIT:		0.0,
				TIGER_BAIT:		0.0,
				MINE:			0.0
			};
		
		//Prey agro range
		public static const entityPreyAgroRangeArray:Object = 
			{
				PANDA:			300,
				SEAL:			250,
				TIGER:			500,
				COMMANDO:		0,
				MARINE:			0,
				FIRE:			0,
				TREE:			0,
				PANDA_BAIT:		0,
				SEAL_BAIT:		0,
				TIGER_BAIT:		0,
				MINE:			0
			};
		
		//Predator agro range
		public static const entityPredatorAgroRangeArray:Object = 
			{
				PANDA:			350,
				SEAL:			350,
				TIGER:			300,
				COMMANDO:		500,
				MARINE:			200,
				FIRE:			0,
				TREE:			0,
				PANDA_BAIT:		0,
				SEAL_BAIT:		0,
				TIGER_BAIT:		0,
				MINE:			0
			};
		
		//toolz
		public static const toolInfo:Object =
			{
				PANDA_BAIT_TOOL:	{name: 'Panda Bait', cooldown:5, cost:100, iconUrl:'chrome/tools/icons/cake.swf', url:'chrome/tools/cake.swf', attackType:PANDA_BAIT},
				SEAL_BAIT_TOOL:		{name: 'Seal Bait', cooldown:5, cost:100, iconUrl:'chrome/tools/icons/fish.swf', url:'chrome/tools/fish.swf', attackType:SEAL_BAIT},
				TIGER_BAIT_TOOL:	{name: 'Tiger Bait', cooldown:5, cost:100, iconUrl:'chrome/tools/icons/steak.swf', url:'chrome/tools/steak.swf', attackType:TIGER_BAIT},
				FIRE_TOOL:			{name: 'Napalm', cooldown:5, cost:2000, iconUrl:'chrome/tools/icons/napalm.swf', url:'chrome/tools/napalm.swf', attackType:FIRE},
				MINES_TOOL:			{name: 'Mines', cooldown:5, cost:1000, iconUrl:'chrome/tools/icons/mine.swf', url:'chrome/tools/mine.swf', attackType:MINE},
				MARINES_TOOL:		{name: 'Marines', cooldown:5, cost:3000, iconUrl:'chrome/tools/icons/marines.swf', url:'chrome/tools/marines.swf', attackType:MARINE},
				BOOMBA_TOOL:		{name: 'Boomba', cooldown:5, cost:5000, iconUrl:'chrome/tools/icons/boomba.swf', url:'chrome/tools/boomba.swf', attackType:BOOMBA},
				COMMANDO_TOOL:		{name: 'Commando', cooldown:5, cost:7000, iconUrl:'chrome/tools/icons/commando.swf', url:'chrome/tools/commando.swf', attackType:COMMANDO}
			};
		
		public static const classInfo:Object =
			{
				PANDA:	{name: "Panda", url:'chrome/classes/panda.swf'},
				SEAL:	{name: "Seal", url:'chrome/classes/seal.swf'},
				TIGER:	{name: "Tiger", url:'chrome/classes/tiger.swf'}
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
				MINE:			Mine,
				DISTRACTOR:		Distractor
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
			
		public static const offsets:Object =
			{
				PANDA: 			{x:-23, y:-28},
				TIGER: 			{x:-23, y:-28},
				SEAL: 			{x:-23, y:-28},
				COMMANDO:		{x:0, y:0},
				MARINE:			{x:0, y:0},
				FIRE:			{x:-70, y:-90},
				TREE:			{x:0, y:0},
				PANDA_BAIT:		{x:0, y:0},
				SEAL_BAIT:		{x:0, y:0},
				TIGER_BAIT:		{x:0, y:0},
				MINE:			{x:-10, y:-14},
				DISTRACTOR:		{x:0, y:0}
			}
			
		public static const splitHealth:int = 200;
			
		
		public function AskTony()
		{
			trace('jon doesnt know shit check the static constz');
		}
	}
}