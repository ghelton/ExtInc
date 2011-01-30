
package com.statusBar
{
	import flash.events.Event;
	
	
	/**
	 * [Description]
	 *
	 * @author G$
	 * @since Jan 30, 2011
	 */
	public class OverlayEvent extends Event
	{
		
		//--------------------------------------
		// CONSTANTS
		//--------------------------------------
		public static const SHOW_MESSAGE:String = "SHOW_MESSAGE";
		public static const SHOW_ERROR_MESSAGE:String = "SHOW_ERROR_MESSAGE";
		
		public static const WELCOME:String = "Welcome";
		public static const BAIT:String = "Bait - Use Bait to attract creatures";
		public static const WEAPONS:String = "Weapons - Use your weapons to kill creatures";
		public static const CASH_MONIES:String = "Money Money Money!!!!!";
		public static const KILL_BOX:String = "Kill the ";
		public static const PURCHASED:String = "purchased!";
		public static const BROKE:String = "You're Broke!";
		public static const PLACE_WEAPON:String = "Place your weapon";
		public static const PLACE_BAIT:String = "Place your bait";
		public static const POINT_A:String = "Napalm - Place starting point";
		public static const POINT_B:String = "Napalm - Place end point";
		
		//--------------------------------------
		// VARIABLES
		//--------------------------------------
		public var message:String;
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		public function OverlayEvent(type:String, $message:String)
		{
			message = $message;
			super(type, true, false);
		}
		
		//--------------------------------------
		// PROTECTED & PRIVATE METHODS
		//--------------------------------------	
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		public static function getRandomCompliment():String
		{
			var compliments:Array = ['cuddly', 'friendly', 'soft', 'fluffy', 'cuddly-wuddly', 'helpless', 'orphaned', 'adorable', 'abandoned', 'baby', 'motherlovin'];
			var compliment:int = Math.random() * (compliments.length);  
			trace('getRandomInsult: ' + compliments[compliment]);
			return compliments[compliment];
		}
		
		public static function getRandomReason():String
		{
			var suffixes:Array = ['for science', 'for king and country', 'for SPARTA!!!', 'for the greater good', 'for no reason', 'for glue', 'so you can sleep', 'for mittens', 'out of spite', 'for Ted Nugent'];
			var suffix:int = Math.random() * (suffixes.length);
			return suffixes[suffix];
		}
		
		
		//--------------------------------------
		// EVENT HANDLERS
		//--------------------------------------							
		
		
	}
}