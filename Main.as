package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	
	public class Main extends Sprite{
		
		public var line:Graphics=graphics;
		public var _xStart:Number;
		public var _yStart:Number;
		public var _xZiel:Number;
		public var _yZiel:Number;var _mx:Number;
		public var _my:Number;
		const ACCELERATION:Number = 10;
		
		public function Main() {
			init();
		}
		
		private function init():void{
			_xStart = 100;
			_yStart = 100;
			_xZiel = 100;
			_yZiel = 100;
			line.lineStyle(1,0x0000FF,1);
			line.moveTo(10,400);
			line.lineTo(_xStart,_yStart);
			addEventListener(Event.ENTER_FRAME, mainLoop);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onClick);
		}
		
		private function mainLoop(e:Event):void{
			drawHook();
		}
		
		private function onClick(e:Event):void{
			_xZiel = mouseX;
			_yZiel = mouseY;
			_mx = (mouseX - _xStart)/ Math.sqrt(Math.pow((mouseX - _xStart),2)+Math.pow((mouseY - _yStart),2));
			_my = (mouseY - _yStart)/ Math.sqrt(Math.pow((mouseX - _xStart),2)+Math.pow((mouseY - _yStart),2));
		}
		
		private function drawHook():void{
			if(_xZiel>_xStart){
				if((_xStart+_mx*ACCELERATION)>_xZiel){
					_xStart = _xZiel;
				}
			}else if(_xZiel<_xStart){
				if((_xStart+_mx*ACCELERATION)<_xZiel){
					_xStart = _xZiel;
				}
			}
			if(_yZiel>_yStart){
				if((_yStart+_my*ACCELERATION)>_yZiel){
					_yStart = _yZiel;
				}
			}else if(_yZiel<_yStart){
				if((_yStart+_my*ACCELERATION)<_yZiel){
					_yStart = _yZiel;
				}
			}
			if(_xStart != _xZiel && _yStart != _yZiel){
				_xStart += _mx * ACCELERATION;
				_yStart += _my * ACCELERATION;;
			}
			line.lineTo(_xStart,_yStart);
		}

	}
	
}
