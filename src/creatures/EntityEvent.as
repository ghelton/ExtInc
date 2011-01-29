package creatures
{
	import flash.events.Event;
	
	public class EntityEvent extends Event
	{
		public function EntityEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}