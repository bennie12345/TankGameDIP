package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Benjamin
	 */
	public class Main extends Sprite 
	{
		public static var tank1:Tank;
		private var enemies:Array;
		private var bullets:Vector.<Bullet>;
		private var chests:Vector.<Chest>;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			tank1 = new Tank();
			enemies = new Array();
			for (var i:int = 0; i < 3; i++)
			{
				var enemy:EnemyTank = new EnemyTank();
				enemies.push(enemy);
				addChild(enemy);
				enemy.x = Math.random() * stage.stageWidth;
				enemy.y = Math.random() * stage.stageHeight;
				enemy.addEventListener("onShoot", createBullet);
			}
			
			
			
			this.addChild(tank1);
			
			tank1.x = 300;
			tank1.y = 300;
			
			tank1.addEventListener("onShoot", createBullet);
			
			bullets = new Vector.<Bullet>();
			
			chests = new Vector.<Chest>();
			
			createChests();
			
			this.addEventListener(Event.ENTER_FRAME, loop);
			
		}
		
		private function createChests():void 
		{
			for (var i:int = 0; i < 5; i++)
			{
				var chest:Chest = new Chest();
				chests.push(chest);
				addChild(chest);
				chest.x = Math.random() * stage.stageWidth;
				chest.y = Math.random() * stage.stageHeight;
				chest.scaleX = chest.scaleY = 0.5
			}
		}
		
		private function loop(e:Event):void 
		{
			if (tank1!=null)
			{
			var toRemove:Boolean = false;
			for (var i:int = 0; i < bullets.length; i++) 
			{
				bullets [i].update();
				for (var j:int = 0; j < chests.length; j++) 
				{
					if (chests[j].hitTestPoint(bullets[i].x, bullets[i].y, true)) 
					{
						toRemove = true;
						
						chests[j].lives--;
						if (chests[j].lives <= 0)
						{
							removeChild(chests[j]);
							chests.splice(j, 1);
						}
					}
				}
				for (var k:int = 0; k < enemies.length; k++) 
				{
					if (enemies[k].hitTestPoint(bullets[i].x, bullets [i].y, true))
					{
						toRemove = true;
						enemies[k].tankLives--;
						if (enemies[k].tankLives <= 0)
						{
							enemies[k].destroy();
							removeChild(enemies[k]);
							enemies.splice(k, 1);
						}
					}
				}
				if (tank1.hitTestPoint(bullets[i].x, bullets[i].y, true))
				{
					toRemove = true;
					tank1.tankLives--;
					if (tank1.tankLives <= 0)
					{
						tank1.destroy();
						removeChild(tank1);
						tank1 = null;
						break;
					}
					
					
					
				}
				
				
				if (bullets[i].x > stage.stageWidth || 
				bullets[i].x < 0 ||
				bullets [i].y > stage.stageHeight || 
				bullets[i].y < 0)
				{
					toRemove = true;
					
				}
				
				if (toRemove) {
						removeChild(bullets[i]);
						bullets.splice(i, 1);
					}
			}	
				
			}
		}
		
		private function createBullet(e:ShootEvent):void 
		{
			if (tank1 != null)
			{
			var r:Number = e.shooter.turretAngle + e.shooter.rotation;
			var tPos:Point = new Point(e.shooter.x, e.shooter.y)
			var b:Bullet = new Bullet(r, tPos); //hier word bulle rotatie berekend
			
			bullets.push(b);
			addChild(b);
			b.scaleX = b.scaleY = tank1.scaleX;
			}
		}
		
	}
	
}