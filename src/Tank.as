package  
{
	import flash.events.KeyboardEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Benjamin
	 */
	public class Tank extends TankBase
	{
		//private var tankBodyArt:MovieClip;
		//private var tankTurretArt:TankTurretArt;
		
		private var controlDir:Point;
		private var speed:Number = 0;
		//public var turretAngle:Number = 0;
		
		public function Tank() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			
			/*/tankBodyArt = new TankBodyArt(); //instantieren van de class
			this.addChild(tankBodyArt); //class op het scherm zetten binnen Tank.as
			
			tankTurretArt = new TankTurretArt();
			this.addChild(tankTurretArt);/*/
			

		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			this.addEventListener(Event.ENTER_FRAME, loop);
			stage.addEventListener(MouseEvent.CLICK, onClick)
			
			controlDir = new Point(0, 0);
			
			//this.scaleX = this.scaleY = 0.5;
			
		}
		
		private function onClick(e:MouseEvent):void 
		{
			var se:ShootEvent = new ShootEvent ("onShoot")
			se.shooter = this;
			dispatchEvent(se);
			//dispatchEvent(new Event("onShoot"));
		}
		
		override public function loop(e:Event):void 
		{
			speed = controlDir.y * -7;
			
			this.rotation += controlDir.x * 4;
			var radian:Number = this.rotation * Math.PI / 180;
										// van graden naar radians
			var xMove:Number = Math.cos(radian);
			var yMove:Number = Math.sin(radian);
			this.x += xMove * speed;
			this.y += yMove * speed;
			
			targetPosition.x = mouseX;
			targetPosition.y = mouseY;
			super.loop(e);
			
		}
		
		private function onKeyUp(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.W)
			{
				controlDir.y = 0;
				
			}
			if (e.keyCode == Keyboard.A)
			{
				controlDir.x = 0;
				
			}
			if (e.keyCode == Keyboard.S)
			{
				controlDir.y = 0;
				
			}
			if (e.keyCode == Keyboard.D)
			{
				controlDir.x = 0;
				
			}
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.W) 
			{
				controlDir.y = -1;
				
			}
			if (e.keyCode == Keyboard.A) 
			{
				controlDir.x = -1;
				
			}
			if (e.keyCode == Keyboard.S) 
			{
				controlDir.y = 1;
			}
			if (e.keyCode == Keyboard.D) 
			{
				controlDir.x = 1;
				
			}
		}
		override public function destroy():void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			stage.removeEventListener(MouseEvent.CLICK, onClick)
			super.destroy();
		}
	}
	

}