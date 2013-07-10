package  {
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	import flash.display.LineScaleMode;
	
	public class Main extends Sprite{
		
		public var line:Shape = new Shape();
		public var _xStart:Number;
		public var _yStart:Number;
		public var _xZiel:Number;
		public var _yZiel:Number;var _mx:Number;
		public var _my:Number;
		public var _platformCollision:Boolean;
		const ACCELERATION:Number = 10;
		
		public function Main() {
			init();
		}
		
		private function init():void{
			_platformCollision = false;
			_xStart = 20;
			_yStart = 350;
			_xZiel = 20;
			_yZiel = 350;
			
			line.x = 20;
			line.y = 350;
			line.graphics.lineStyle(2,0x0000FF,1, false, LineScaleMode.NONE);
			line.graphics.lineTo(1,1);
			addChild(line);
			addEventListener(Event.ENTER_FRAME, mainLoop);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onClick);
		}
		
		private function mainLoop(e:Event):void{
			checkCollisionPlatform();
			drawHook();
			
		}
		
		private function onClick(e:Event):void{
			if(_xStart == _xZiel && _yStart == _yZiel){
				_platformCollision = false;
				_xZiel = mouseX;
				_yZiel = mouseY;
				_mx = (mouseX - _xStart)/ Math.sqrt(Math.pow((mouseX - _xStart),2)+Math.pow((mouseY - _yStart),2));
				_my = (mouseY - _yStart)/ Math.sqrt(Math.pow((mouseX - _xStart),2)+Math.pow((mouseY - _yStart),2));
			}
		}
		
		private function drawHook():void{
			//trace(_xStart+" "+_yStart);
			line.graphics.lineStyle(2,0x0000FF,1, false, LineScaleMode.NONE);
			line.graphics.lineTo(1,1);
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
				_yStart += _my * ACCELERATION;
				line.scaleX += _mx * ACCELERATION;
				line.scaleY += _my * ACCELERATION;
			}
			if(_xStart == _xZiel && _yStart == _yZiel && _platformCollision == false){
				line.graphics.clear();
				line.x = 20;
				line.y = 350;
				line.scaleX = 1;
				line.scaleY = 1;
				_xStart = 20;
				_yStart = 350;
				_xZiel = 20;
			    _yZiel = 350;
			}
		}
		
		private function checkCollisionPlatform():void{
			if(balken1.hitTestPoint(_xStart,_yStart)){
				textfield.text = "1 getroffen";
				_xZiel = _xStart;
				_yZiel = _yStart;
				_platformCollision = true;
				retractHook();
			}
			if(balken2.hitTestPoint(_xStart,_yStart)){
				textfield.text = "2 getroffen";
				_platformCollision = true;
				_xZiel = _xStart;
				_yZiel = _yStart;
				_platformCollision = true;
				retractHook();
			}
		}
		
		private function retractHook():void{
			trace(line.scaleX/ACCELERATION +" "+line.scaleY/ACCELERATION+" "+_platformCollision);
			line.rotation = 180;
			line.x = _xZiel;
			line.y = _yZiel;
			line.scaleX -= _mx * ACCELERATION;
			line.scaleY -= _my * ACCELERATION;
			if ((Math.floor((line.scaleX/ACCELERATION))) == 0 && (Math.floor((line.scaleY/ACCELERATION))) == 0){
				trace("Klappt");
				_platformCollision = false;
				line.rotation = 0;
			}
			
		}

	}
	
}
