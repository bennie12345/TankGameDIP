package  
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Benjamin
	 */
	public class ShootEvent extends Event 
	{
		public var shooter:TankBase;
		public function ShootEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}