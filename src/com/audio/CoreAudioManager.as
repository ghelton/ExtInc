
package com.audio
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	
	public class CoreAudioManager extends Sprite
	{
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		//--------------------------------------
		// PUBLIC VARIABLES
		//--------------------------------------
		public var _backgroundAudioOn:Boolean = true;
		public var _gameAudioOn:Boolean = true;
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function CoreAudioManager(path:String, bgPath:String)
		{
			_audioPath = path;
			_bgSoundDirectory = bgPath;
			_backgroundSound = new Sound(); 
			_backgroundChannel = new SoundChannel();
			_backgroundSoundTransform = new SoundTransform();
			_backgroundChannel.soundTransform = _backgroundSoundTransform;
		}
		
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------
		private var _audioPath:String;
		private var _bgSoundDirectory:String;
		private var _pid:String;
		
		private var _backgroundSound:Sound; 
		private var _backgroundChannel:SoundChannel;
		private var _backgroundSoundTransform:SoundTransform;
		private var _backgroundRequest:URLRequest;
		private var _backgroundIsPlaying:Boolean = false;
		private var _backgroundSongs:Array;
		private var _runwaySongs:Array;
		private var _lowerVolumeTimer:Timer = new Timer(100, 0);
		
		private var _gameSounds:Array = [];
		//private var _audioAssetsUrl:String;
		
		//--------------------------------------
		//  GETTER/SETTERS
		//--------------------------------------
		public function get backgroundIsPlaying():Boolean
		{
			return _backgroundIsPlaying;
		}
		public function get backgroundSongs():Array
		{
			return _backgroundSongs;
		}
		
		public function set backgroundSongs(value:Array):void
		{
			_backgroundSongs = value;
		}
		
		public function get runwaySongs():Array
		{
			return _runwaySongs;
		}
		
		public function set runwaySongs(value:Array):void
		{
			_runwaySongs = value;
		}
		
		public function set pid(val:String):void
		{
			_pid = val;
		}
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		
		public function playRandomBackground():void
		{
			if(_backgroundChannel != null)
			{
				_backgroundChannel.stop();
				_backgroundIsPlaying = false;
			}
			
			_backgroundSound = new Sound(); 
			_backgroundRequest = new URLRequest(_audioPath + _bgSoundDirectory + _backgroundSongs[Math.floor(Math.random() * _backgroundSongs.length)]);
			
			_backgroundSound.load(_backgroundRequest);
			_backgroundSound.addEventListener(Event.COMPLETE, backgroundLoadComplete);
		}
		
		public function playRandomRunwayBackground():void
		{
			if(_backgroundChannel != null)
			{
				_backgroundChannel.stop();
				_backgroundIsPlaying = false;
			}
			
			_backgroundSound = new Sound(); 
			_backgroundRequest = new URLRequest(runwaySongs[Math.floor(Math.random() * _runwaySongs.length)]);
			
			_backgroundSound.load(_backgroundRequest);
			_backgroundSound.addEventListener(Event.COMPLETE, backgroundLoadComplete);
			startBackground();
		}
		
		public function stopPlayback():void
		{
			_backgroundChannel.stop();	
		}
		
		
		public function backgroundLoadComplete(evt:Event):void
		{
			_backgroundSound.removeEventListener(Event.COMPLETE, backgroundLoadComplete);
			_backgroundChannel = _backgroundSound.play(0, 999999);
			_backgroundIsPlaying = true;
		}
		
		public function playBackground(song:String):void 
		{
			_backgroundRequest = new URLRequest(_audioPath + _bgSoundDirectory + song);
			_backgroundSound.load(_backgroundRequest); 
			_backgroundChannel = _backgroundSound.play(0, 999999);
			_backgroundIsPlaying = true;
		}
		
		public function startBackground():void
		{
			addEventListener(Event.ENTER_FRAME, _raiseVolumeTransform);
		}
		
		public function stopBackground():void
		{
			addEventListener(Event.ENTER_FRAME, _lowerVolumeTransform);
			removeEventListener(Event.ENTER_FRAME, _raiseVolumeTransform);
		}
		
		private function _raiseVolumeTransform(evt:Event):void
		{
			if(_backgroundSoundTransform.volume < 0.4)
			{
				_backgroundSoundTransform.volume += 0.1;
				_backgroundChannel.soundTransform = _backgroundSoundTransform;
			}
			else
			{
				_backgroundSoundTransform.volume = 0.4;
				_backgroundChannel.soundTransform = _backgroundSoundTransform;
				removeEventListener(Event.ENTER_FRAME, _raiseVolumeTransform);
			}
		}
		
		private function _lowerVolumeTransform(evt:Event):void
		{
			if(_backgroundSoundTransform.volume > 0)
			{
				_backgroundSoundTransform.volume -= 0.1;
				_backgroundChannel.soundTransform = _backgroundSoundTransform;
			}
			else
			{
				_backgroundSoundTransform.volume = 0;
				_backgroundChannel.soundTransform = _backgroundSoundTransform;
				
				removeEventListener(Event.ENTER_FRAME, _lowerVolumeTransform);
			}
		}
		
		//  Lower volume, but not completely off
		/*public function dimVolume(evt:Event):void
		{
		if(_backgroundSoundTransform.volume > 0.2)
		{
		_backgroundSoundTransform.volume -= 0.1;
		_backgroundChannel.soundTransform = _backgroundSoundTransform;
		}
		else
		{
		_backgroundSoundTransform.volume = 0;
		_backgroundChannel.soundTransform = _backgroundSoundTransform;
		
		removeEventListener(Event.ENTER_FRAME, dimVolume);
		}
		}*/
		
		public function dimVolume():void
		{
			_lowerVolumeTimer.addEventListener(TimerEvent.TIMER, onTimerExpired);
			_lowerVolumeTimer.start();
		}
		
		public function onTimerExpired(evt:TimerEvent):void
		{
			if(_backgroundSoundTransform.volume > 0.2)
			{
				_backgroundSoundTransform.volume -= 0.1;
				_backgroundChannel.soundTransform = _backgroundSoundTransform;
			}
			else
			{
				_lowerVolumeTimer.stop();
				_lowerVolumeTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerExpired);
			}
		}
		
		public function toggleBackground():void
		{
			switch(_backgroundIsPlaying)
			{
				case true:
					stopBackground();
					_backgroundIsPlaying = false;
					break;
				
				case false:
					startBackground();
					_backgroundIsPlaying = true;
					break;
			}
		}
		
		public function toggleRunwayBackground():void
		{
			switch(_backgroundIsPlaying)
			{
				case true:
					stopBackground();
					_backgroundIsPlaying = false;
					_backgroundAudioOn = false;
					break;
				
				case false:
					playRandomRunwayBackground();
					_backgroundIsPlaying = true;
					_backgroundAudioOn = true;
					break;
			}
		}
		
		public function setBackground(newSetting:Boolean):void
		{
			switch(newSetting)
			{
				case true:
					startBackground();
					_backgroundIsPlaying = true;
					break;
				
				case false:
					stopBackground();
					_backgroundIsPlaying = false;
					break;
			}
		}
		
		public function requestGameSound(sound:String):void
		{
			if(_gameAudioOn)
				_gameSounds.push(new CoreSound(_audioPath + sound, _gameSoundCompleteHandler));
			/*if(SharedObjectFactory.getInstance().getSharedObject(_soName, _pid).data["gameSound"]){
			}*/
		}
		
		private function _gameSoundCompleteHandler(sound:CoreSound):void
		{
			if(_gameAudioOn){
				_gameSounds.splice(_gameSounds.indexOf(sound), 1);
			}
			if (_backgroundAudioOn)
				startBackground();
			/*if(SharedObjectFactory.getInstance().getSharedObject(_soName, _pid).data.gameMusic){
			}*/
			
		}
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		
		//--------------------------------------
		//  PRIVATE & PROTECTED INSTANCE METHODS
		//--------------------------------------								
		
	}
}