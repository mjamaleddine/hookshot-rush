package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	
	public class Main extends Sprite{
		
		public var line:Graphics=graphics;
		public var _x:int = 100;
		
		public function Main() {
			init();
		}
		
		private function init():void{

			line.lineStyle(5,0x0000FF,1);
			line.moveTo(100,100);
			line.lineTo(500,100);
			addEventListener(Event.ENTER_FRAME, mainLoop);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onClick);
		}
		
		private function mainLoop(e:Event):void{
			_x++;
			
		}
		
		private function onClick(e:Event):void{
			line.lineTo(mouseX,mouseY);
			trace("laeuft");
		}

	}
	
}
