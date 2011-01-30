/**
 ##########################################################################################
 UIElement
 
 Copyright (c) 2010 Screamstream Interactive. All rights reserved.
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 ##########################################################################################
 */
package com.UI
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	/**
	 * [Description]
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 10.0
	 * 
	 * @author #####[YOUR NAME]######
	 * @since  Sep 6, 2010
	 */
	public class UIElement extends Sprite
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
		public function UIElement()
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
			//clears graphics
		}
		
		protected function draw():void
		{
			// positions children, render current state, draws graphics
		}
		
	}
}