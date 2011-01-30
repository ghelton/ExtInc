
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
		public static const KILL_BOX:String = "KILL KILL KILL";
		
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
		
		
		//--------------------------------------
		// EVENT HANDLERS
		//--------------------------------------							
		
		
	}
}