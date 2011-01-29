package
{
	import attacks.Firebomb;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Point;
	
	import lookup.Lookup;
	
	import player.PlayerData;
	import player.tools.Tool;
	import player.tools.ToolEvent;
	
	
	/**
	 * [Description]
	 *
	 * @author G$
	 * @since Jan 28, 2011
	 */
	//[SWF(width="1024", height="768", version_major="10", frameRate="24")]
	
	public class ExtInc extends Sprite
	{
		
		//--------------------------------------
		// CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// VARIABLES
		//--------------------------------------
		
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		public function ExtInc()
		{
			/*stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;*/
			
			var player:PlayerData = new PlayerData();
			var tool:Tool = player.getTool(Lookup.MINES);
			tool.addEventListener(ToolEvent.TOOL_AVAILABLE, onTool, false, 0, true);
			tool.useTool();
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
		
		private function onTool(e:ToolEvent):void
		{
			trace("yay tools!");
		}
		
	}
}