package com.audio
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	public class CoreSound
	{
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// PUBLIC VARIABLES
		//--------------------------------------
		
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		public function CoreSound(url:String, onSoundComplete:Function)
		{
			_onSoundComplete = onSoundComplete;
			
			_gameSoundRequest = new URLRequest(url);
			_gameSound = new Sound();
			_gameSound.load(_gameSoundRequest);
			_gameSound.addEventListener(Event.COMPLETE, onLoadComplete);
		}
		
		//--------------------------------------
		// PRIVATE VARIABLES
		//--------------------------------------
		private var _onSoundComplete:Function;
		private var _gameSound:Sound;
		private var _gameSoundChannel:SoundChannel;
		private var _gameSoundRequest:URLRequest;
		
		//--------------------------------------
		// GETTER/SETTERS
		//--------------------------------------
		
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		
		//--------------------------------------
		// EVENT HANDLERS
		//--------------------------------------
		
		
		//--------------------------------------
		// SERVER CALLBACKS
		//--------------------------------------
		
		
		//--------------------------------------
		// PRIVATE & PROTECTED INSTANCE METHODS
		//--------------------------------------	
		private function onLoadComplete(evt:Event):void
		{
			_gameSound.removeEventListener(Event.COMPLETE, onLoadComplete);
			_gameSoundChannel = _gameSound.play();
			_gameSoundChannel.addEventListener(Event.SOUND_COMPLETE, onComplete);
		}
		private function onComplete(evt:Event):void
		{
			if(_onSoundComplete != null)
				_onSoundComplete(this);
			_onSoundComplete = null;
			//_gameSound.close();
			_gameSound = null;
			_gameSoundChannel = null;
			_gameSoundRequest = null;
		}
	}
}