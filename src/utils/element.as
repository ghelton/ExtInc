
package utils
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	/**
	 * [Description]
	 * 
	 * @author #####[YOUR NAME]######
	 * @since  Sep 6, 2010
	 */
	public class Element extends Sprite
	{
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// PUBLIC VARIABLES
		//--------------------------------------		
		//		public var id:String = '';
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function Element()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, initComplete, false, 999, true);
		}
		
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------
		
		protected var _drawn:Boolean = false;
		
		//--------------------------------------
		//  GETTER/SETTERS
		//--------------------------------------
		
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		
		
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		
		private function initComplete(e:Event):void
		{
			//do not override unless you're creating another base UI class
			removeEventListener(Event.ADDED_TO_STAGE, initComplete);
			init(e);
			draw();
			_drawn = true;
		}
		
		//--------------------------------------
		//  SERVER CALLBACKS
		//--------------------------------------
		
		
		//--------------------------------------
		//  PRIVATE & PROTECTED INSTANCE METHODS
		//--------------------------------------
		
		protected function init(e:Event):void
		{
			//initializes children, adds children to stage, instantiates timers
		}
		
		protected function deinit():void
		{
			// calls destruct on children
			// does not remove children from stage
			// destruction of super class happens after calling destruct on children
		}
		
		public final function destruct():void
		{
			//prepares for deinit
			_drawn = false;
			deinit();
			if(parent)
				parent.removeChild(this);
		}
		
		protected final function redraw():void
		{
			if(_drawn)
			{
				clear();
				draw();
			}
		}
		
		protected function clear():void
		{
			graphics.clear();
		}
		
		protected function draw():void
		{
			// positions children, render current state, draws graphics
		}
	}
}