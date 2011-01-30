
package com.statusBar
{
	import com.Style.Styles;
	import com.creatures.Marine;
	
	import flash.display.Bitmap;
	import flash.display.BlendMode;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	
	/**
	 * [Description]
	 *
	 * @author G$
	 * @since Jan 29, 2011
	 */
	public class StatusBox extends Sprite
	{
		
		//--------------------------------------
		// CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// VARIABLES
		//--------------------------------------
		private var _screen:Shape;
		private var _overlayLines:Sprite;
		private var _innerWidth:uint;
		private var _innerHeight:uint;
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		public function StatusBox($width:uint, $height:uint, $cornerRadius:int)
		{
			super();
			
			var padding:uint = 5;
			_innerWidth = $width - padding * 2;
			_innerHeight = $height - padding * 2;
			
			graphics.beginFill(Styles.ALMOST_BLACK);
			graphics.drawRoundRect(0, 2, $width, $height, $cornerRadius);
			graphics.endFill();
			
			graphics.beginFill(Styles.DARK_GRAY);
			graphics.drawRoundRect(0, 0, $width, $height, $cornerRadius);
			
			graphics.endFill();
			
			_screen = new Shape();
			_screen.graphics.beginFill(0x000000);
			_screen.graphics.drawRoundRect(padding, padding, _innerWidth, _innerHeight, $cornerRadius - padding);
			_screen.filters = [Styles.SCREEN_INNER_GLOW];
			addChild(_screen);
			
			_overlayLines = new Sprite();
			_overlayLines.x = _overlayLines.y = padding;
			_overlayLines.alpha = .25;
			_overlayLines.blendMode = BlendMode.OVERLAY;
			addChild(_overlayLines);
			
			var overlayMask:Shape = new Shape();
			overlayMask.graphics.beginFill(0x000000);
			overlayMask.graphics.drawRoundRect(padding, padding, _innerWidth, _innerHeight, $cornerRadius - padding);
			addChild(overlayMask);
			_overlayLines.mask = overlayMask;
			
			var bitmapLoader:Loader = new Loader();
			bitmapLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderComplete, false, 0, true);
			bitmapLoader.load(new URLRequest('chrome/Lines.png'));
		}
		
		//--------------------------------------
		// PROTECTED & PRIVATE METHODS
		//--------------------------------------	
		private function loaderComplete(e:Event):void
		{
			var loaderInfo:LoaderInfo = e.currentTarget as LoaderInfo;
			loaderInfo.removeEventListener(Event.COMPLETE, loaderComplete);
			var bitmap:Bitmap = loaderInfo.content as Bitmap;
			if(bitmap.bitmapData)
			{	
				_overlayLines.graphics.beginBitmapFill(bitmap.bitmapData);
				_overlayLines.graphics.drawRect(0, 0, _innerWidth, _innerHeight);
				_overlayLines.graphics.endFill();
			}
			
			setChildIndex(_overlayLines, numChildren - 1);
		}
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		
		//--------------------------------------
		// EVENT HANDLERS
		//--------------------------------------							
		
		
	}
}