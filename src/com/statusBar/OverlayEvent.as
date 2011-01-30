
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
		
		public static const WELCOME:String = "Welcome";
		public static const BAIT:String = "Bait - Use Bait to attract creatures";
		public static const WEAPONS:String = "Weapons - Use your weapons to kill creatures";
		public static const CASH_MONIES:String = "Money Money Money!!!!!";
		public static const KILL_BOX:String = "Kill the ";
		public static const MINES_TOOL:String = " - Landmine";
		public static const FIRE_TOOL:String = " - Napalm";
		public static const COMMANDO_TOOL:String = " - Commando";
		public static const MARINES_TOOL:String = " - Marines";
		public static const BOOMBA_TOOL:String = " - Boomba";
		
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
			super(type, false, false);
		}
		
		//--------------------------------------
		// PROTECTED & PRIVATE METHODS
		//--------------------------------------	
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		public static function getRandomCompliment():String
		{
			var compliments:Array = ['cuddly', 'friendly', 'soft', 'fluffy', 'cuddly-wuddly', 'helpless', 'orphaned', 'adorable', 'abandoned'];
			var compliment:int = Math.floor(Math.random() * (compliments.length - 1));  
			trace('getRandomInsult: ' + compliments[compliment]);
			return compliments[compliment];
		}
		
		
		//--------------------------------------
		// EVENT HANDLERS
		//--------------------------------------							
		
		
	}
}