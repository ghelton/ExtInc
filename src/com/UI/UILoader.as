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
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------		
		public function UILoader(loaderUrl:String = "", width:Number = 0, height:Number = 0)
		{
			super();
			
			_loaderUrl = loaderUrl;
			
			_width = width;
			_height = height;
			
			
			
		}
		
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------
		public var LoadComplete:Boolean 		= false;
		internal var _checkWidth:Boolean		= false;
		internal var _checkHeight:Boolean		= false;
		internal var _width:Number 				= 0;
		internal var _height:Number 			= 0;
		private var _loaderScale:Number			= 1;
		public var base:Sprite 					= null;
		public var loader:Loader				= null;
		internal var _loaderUrl:String 			= "";
		internal var _request:URLRequest		= null;
		public var resizeMethod:String			= ResizeMethod.MAINTAIN_ASPECT_RATIO;
		public var onComplete:Function			= nullFunc;
		//public var onProgress:Function		= nullFunc;
		public var onIOError:Function			= nullFunc;
		internal var _resized:Boolean			= false;
		public var smoothing:Boolean			= false;
		public var loadViaProxy:Boolean 		= false;
		
		//--------------------------------------
		//  GETTER/SETTERS
		//--------------------------------------
		
		
		public function set url(value:String):void
		{
			if(value == null)
				throw new Error('[UILoader set url] url is null');
			
			if(value == '')
			{
//				if(_onComplete != null) _onComplete(null);
				return;
			}
			
			_loaderUrl = value;
			
			if(!stage)
				return;
			
			//trace("loadViaProxy: " + loadViaProxy);
			var urlProxyPrepend:String = loadViaProxy? 'imageProxy.php?imageUrl=':'';
			
			var context:LoaderContext = new LoaderContext(true);//, null, SecurityDomain.currentDomain
			LoadComplete = false;
			_request = new URLRequest(urlProxyPrepend + _loaderUrl);
			//trace(" --------------- >> " + (urlProxyPrepend + value));
			if (loader == null)
				loader = new Loader();
			loader.load(_request, context);

			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,_onComplete,false,0,true);
		}
		
		public function get url():String
		{
			return _loaderUrl;
		}
		
		public function get loaderScale():Number
		{
			if (loader !=null)
				_loaderScale = loader.scaleX;
			return _loaderScale;
		}
		
		public function set loaderScale(value:Number):void
		{
			_loaderScale = value;
			loader.scaleX = loader.scaleY = value;
		}
		
		//--------------------------------------
		//  PUBLIC METHODS -(to override)
		//--------------------------------------
		public function playMovie(frame:int = 1):void {
			if(loader.content is MovieClip) (loader.content as MovieClip).gotoAndPlay(frame);
		}
		public function stopMovie(frame:int = 1):void {
			if(loader.content is MovieClip) (loader.content as MovieClip).gotoAndStop(frame);
		}
		public function resized():void
		{
			var maxScaleX:Number = 1;
			var maxScaleY:Number = 1;
			var newScale:Number = 1;
			try
			{
				switch (resizeMethod)
				{
					case ResizeMethod.MAINTAIN_ASPECT_RATIO:
						maxScaleX = _width / loader.width;
						maxScaleY = _height / loader.height;
						maxScaleX = maxScaleX == 0 ? maxScaleY : maxScaleX;
						maxScaleY = maxScaleY == 0 ? maxScaleX : maxScaleY;
						newScale = ScaleUtil.scaleLow(maxScaleX, maxScaleY);
						
						loader.scaleX = newScale;
						loader.scaleY = newScale;
						_width = loader.width;
						_height = loader.height;
						break;
					
					case ResizeMethod.STRETCH:
						loader.width = _width;
						loader.height = _height;
						break;
					
					case ResizeMethod.FILL:
						maxScaleX = _width / loader.width;
						maxScaleY = _height / loader.height;
						
						newScale = ScaleUtil.scaleHeigh(maxScaleX, maxScaleY);
						//trace("newScale: " + newScale);
						
						loader.scaleX = newScale;
						loader.scaleY = newScale;
						_width = loader.width;
						_height = loader.height;
						break;
					default :
						break;
				}
				_loaderScale = newScale;
			}catch(error:*)
			{
				/**TRACEDISABLE:trace("[UILoader] ",error);*/
			}
		}
		
		public override function set width(value:Number):void
		{
			if(value != 0)
			{
				_width = value;
			}
			else
				return;
			
			if(!LoadComplete)
			{
				_checkWidth = true;
				return;
			}
			
			resized();
		}
		
		/*
		public override function get width():Number
		{
		return _width;
		}
		*/
		
		public override function set height(value:Number) : void
		{
			if(value != 0)
			{
				_height = value;
			}
			else
				return;
			
			if(!LoadComplete)
			{
				_checkHeight = true;
				return;
			}
			
			resized();
		}
		
		/*
		public override function get height():Number
		{
		return _height;
		}
		*/
		
		
		override protected function draw():void
		{
			super.draw();
			if(!LoadComplete)
				return;
			
			//check/reset scale
			if(loader.scaleX != 1 || loader.scaleY != 1)
			{
				loader.scaleX = 1;
				loader.scaleY = 1;
			}
			
			//resize
			if(_width < _height)
			{
				if(_height != 0)
				{
					this.height = _height;
				}
				else
					_height = loader.height;
			}
			else
			{
				if(_width != 0)
				{
					this.width = _width;
				}
				else
					_width = loader.width;
			}
		}
		
		//consider adding methods for centering the loaded image for animations/fx that require the registration point be in the center of the image 
		
		//--------------------------------------
		//  EVENT HANDLERS - (internally handle & destroy)
		//--------------------------------------
		internal function _onComplete(event:Event):void {
			LoadComplete = true;
			
			//event.currentTarget.removeEventListener(ProgressEvent.PROGRESS,_onProgress);
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,_onComplete);
			
			if(_checkWidth || _checkHeight)
				draw();
			
			//dispatchEvent(new Event(Event.COMPLETE,false,false));
			onComplete(event);//hook for notification of onComplete event
		}
//		internal function _onProgress(event:ProgressEvent):void {
//			onProgress(event);	
//		}
		internal function _onIOError(event:Event):void {
			onIOError(event);
		}
//		internal function Events(event:*):void
//		{
//			switch(event.type)
//			{
//				case Event.COMPLETE:
//					//trace("UILoader finished loading",_loaderUrl);
//					LoadComplete = true;
//					loader.contentLoaderInfo.(Event.COMPLETE,Events);
//					
//					
//					if(_checkWidth || _checkHeight)
//						draw();
//					
//					//dispatchEvent(new Event(Event.COMPLETE,false,false));
//					if(onComplete != null)
//						onComplete(event);//hook for notification of onComplete event
//					
//					break;
//				
//				case IOErrorEvent.IO_ERROR:
//					if(onIOError != null)
//						onIOError(event);
//					break;
//				
//				case ProgressEvent.PROGRESS:		
//					switch(event.bytesLoaded == event.bytesTotal)
//					{
//						case true:
//							event.currentTarget.(ProgressEvent.PROGRESS,Events);
//							break;
//					}
//					if(onProgress != null)
//						onProgress(event);	
//					break;				
//			}
//		}
		
		override protected function deinit():void
		{
			onComplete = onIOError = nullFunc;
			
			if(base != null)
			{
				base.removeChild(loader);
				removeChild(base);
				base 								= null;
			}
			
			if(loader != null)
			{
				//loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,_onProgress,false);
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,_onComplete,false);
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,_onIOError,false);	
				loader.unloadAndStop();
				loader 							= null;
			}
			_request 							= null;
			
			super.deinit();
		}
		
		//--------------------------------------
		//  PRIVATE & PROTECTED INSTANCE METHODS
		//--------------------------------------
		override protected function init(event:Event):void
		{
			super.init(event);
			
			base 								= new Sprite();
			
			_request 							= new URLRequest();
			loader 								= new Loader();
			
			loader.cacheAsBitmap				= true;
			addChild(base);
			base.addChild(loader);
			
			//loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,_onProgress,false,0,true);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,_onComplete,false,0,true);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,_onIOError,false,0,true);			

			this.url = _loaderUrl;
		}
		
		private static function nullFunc(event:Event):void {return;}
	}
}