/*****************************************************************************************
 UILoader
 
 Copyright (c) 2009 philipbroadway. All rights reserved.
 
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
 ******************************************************************************************
 */
package com.UI
{
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.sampler.getSize;
	import flash.system.LoaderContext;
	
	/**
	 * A homage to the UILoader component of FLASH 8
	 * ..with some features I wish it had like:
	 * + built-in event/error handling (with easily overide-able methods like onComplete, onIOError, & onProgress)
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9
	 * 
	 * @author philipbroadway
	 * @since  12/1/2009 12:35 PM
	 */
	public class UILoader extends UIElement
	{
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		private static const IMAGE_PROXY:String = "imageProxy.php?imageUrl=";
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------		
		public function UILoader($loaderUrl:String = "", $width:Number = -1, $height:Number = -1, $loadViaProxy:Boolean = false)
		{
			super();
			
			_url = $loaderUrl;
			_width = $width;
			_height = $height;
			_loadViaProxy = $loadViaProxy;
			
			visible = false;
		}
		
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------
		
		//used for functionality
		private var _loader:Loader;
		private var _loadComplete:Boolean = false;
		private var _pendingLoad:Boolean = false;
		
		//passed into constructor
		private var _width:Number = 0;
		private var _height:Number = 0;
		private var _url:String;
		private var _loadViaProxy:Boolean;

		//this should be removed, it unnecesarily breaks encapsulation of the loader (which is has a public getter...)
		public var onComplete:Function = null;
		public var onIOError:Function = null;
		
		//--------------------------------------
		//  GETTER/SETTERS
		//--------------------------------------
		
		//read only properties
		public function copy():UILoader
		{
			return ( new UILoader(this._url, this._width, this._height, this._loadViaProxy) );
		}
		public function get loader():Loader
		{
			return _loader;
		}
		
		public function get pendingLoad():Boolean
		{
			return _pendingLoad;
		}
		
		public function get LoadComplete():Boolean
		{
			return _loadComplete;
		}
		
		public function get loadViaProxy():Boolean
		{
			return _loadViaProxy;
		}
		
		//read write properties
		public function set loadViaProxy(value:Boolean):void
		{
			if(_loadViaProxy != value)
			{
				_loadViaProxy = value;
				if(_drawn)
				{
					performLoad();
				}
			}
		}
		
		public function set url(value:String):void
		{
			if(value == null)
				throw new Error('[UILoader set url] url is null');
			
			if(value != '' && value != _url)
			{
				_url = value;
				
				if(_drawn)
				{
					performLoad();
				}
			}
		}
		
		public function get url():String
		{
			return _url;
		}
		public override function set width(value:Number):void
		{
			if(value != _width)
			{
				_width = value;
				redraw();
			}
		}
		
		public override function get width():Number
		{
			if(LoadComplete || _width < 0)
				return super.width;
			return _width;
		}
		
		
		public override function set height(value:Number) : void
		{
			if(value != _height)
			{
				_height = value;
				redraw();
			}
		}
		
		
		public override function get height():Number
		{
			if(LoadComplete || _height < 0)
				return super.height;
			return _height;
		}
		
		public override function get scaleX():Number
		{
			if(_loader != null)
			{
				return _loader.scaleX;
			}
			
			return super.scaleX;
		}
		
		public override function get scaleY():Number
		{
			if(_loader != null)
			{
				return _loader.scaleY;
			}
			
			return super.scaleY;
		}
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		
		//This shit and the function below it should not be in this class. Probably some class extending this class.
		public function playMovie(frame:int = 1):void
		{
			if(_loader.content is MovieClip) (_loader.content as MovieClip).gotoAndPlay(frame);
		}
		
		public function stopMovie(frame:int = 1):void
		{
			if(_loader.content is MovieClip) (_loader.content as MovieClip).gotoAndStop(frame);
		}
		
		override public function destruct():void
		{
			if(_pendingLoad)
			{
				_loader.close();
			}
			
			if(_loader != null)
			{
				cleanupLoad();	
				_loader.unloadAndStop();
				if(contains(_loader)) removeChild(_loader);
				_loader = null;
			}
			
			super.destruct();
		}
		
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		
		private function _onComplete(event:Event):void
		{
			_loadComplete = true;
			cleanupLoad(); //this function is super dirty
			draw();
			
			dispatchEvent(new Event(Event.COMPLETE,false,false));
			
			//this is only for backwards compatibility
			if(onComplete != null)
			{
				onComplete(event);
			}
		}
		
		private function _onIOError(event:IOErrorEvent):void
		{
			cleanupLoad();
			
			dispatchEvent(new Event(IOErrorEvent.IO_ERROR));
			
			//this is also only for backwards compatibility
			if(onIOError != null)
			{
				onIOError(event);
			}
		}
		
		//--------------------------------------
		//  PRIVATE & PROTECTED INSTANCE METHODS
		//--------------------------------------
		override protected function init(event:Event):void
		{
			_loader = new Loader();
			addChild(_loader);
			if(_url != "")
			{
				performLoad();
			}
		}
		
		override protected function draw():void
		{
			visible = true;
			if(LoadComplete)
			{
				super.draw();
				
				if(_width != -1 || _height != -1)
				{
					//check/reset scale
					//I'm pretty sure this was added to fix a bug where, when the loader is re-used, the scale changes relative to the previous scale.
					//This should be fixed now but I'm leaving this in just in case (bad reason)
					_loader.scaleX = 1;
					_loader.scaleY = 1;
					
					//resize
					_loader.width = _width != -1 ? _width : Number.POSITIVE_INFINITY;
					_loader.height = _height != -1 ? _height : Number.POSITIVE_INFINITY;
					
					if(_loader.scaleX > _loader.scaleY)
					{
						_loader.scaleX = _loader.scaleY;
					}
					else
					{
						_loader.scaleY = _loader.scaleX;
					}
					
					
					_loader.cacheAsBitmap = true;
					_loader.cacheAsBitmap = false;
				}
			}
		}
		
		private function performLoad():void
		{
			_loadComplete = false;
			var proxy:String = _loadViaProxy ? IMAGE_PROXY : '';
			var request:URLRequest = new URLRequest(proxy + _url);
			var context:LoaderContext = new LoaderContext(true);
			
			if(_pendingLoad)
			{
				_loader.close();
			}
			else
			{
				_loader.unloadAndStop();
			}
			
			_pendingLoad = true;
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, _onIOError, false, 0, true);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, _onComplete, false, 0, true);
			_loader.load(request, context);
		}
		
		private function cleanupLoad():void
		{
			_pendingLoad = false;
			_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, _onIOError);
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, _onComplete);
		}
	}
}