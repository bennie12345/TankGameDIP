package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Benjamin
	 */
	public class TankBase extends MovieClip
	{
		protected var tankBodyArt:MovieClip;
		protected var tankTurretArt:TankTurretArt;
		public var turretAngle:Number = 0;
		public var targetPosition:Point;
		public var tankLives:int = 10;
		
		public function TankBase() 
		{
			this.addEventListener(Event.ENTER_FRAME, loop);
			targetPosition = new Point;
			tankBodyArt = new TankBodyArt(); //instantieren van de class
			this.addChild(tankBodyArt); //class op het scherm zetten binnen Tank.as
			
			tankTurretArt = new TankTurretArt();
			this.addChild(tankTurretArt);
		}
		
		public function loop(e:Event):void 
		{	
			var dx:Number = targetPosition.x;
			var dy:Number = targetPosition.y;
			
			var radian:Number = Math.atan2(dy, dx);
			
			radian = Math.atan2(dy, dx);
			var angle:Number = radian * 180 / Math.PI; //omzetten radian naar angle
			
			tankTurretArt.rotation = angle;
			turretAngle = tankTurretArt.rotation;
			
			this.scaleX = this.scaleY = 0.3;
		}
		public function destroy():void
		{
			this.removeEventListener(Event.ENTER_FRAME, loop);
		}
	}

}