package  {
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	import flash.display.LineScaleMode;
	import flashx.textLayout.utils.CharacterUtil;
	import flash.text.*; 
	
	public class Player extends Sprite{
		
		public var textbox:TextField = new TextField(); 
		public var line:Shape = new Shape();
		public var health:Number = 3;
		public var balken1:Balken = new Balken();
		public var balken2:Balken = new Balken();
		public var hp:Leben = new Leben();
		public var wand1:Wand = new Wand();
		public var wand2:Wand = new Wand();
		public var wand3:Wand = new Wand();
		public var bg:BackGround = new BackGround();
		public var bg2:BackGround = new BackGround();
		public var char = new CharSprite();
		public var _xStart:Number;
		public var _yStart:Number;
		public var _xZiel:Number;
		public var _yZiel:Number;var _mx:Number;
		public var _my:Number;
		public var _platformCollision:Boolean;
		public var _onGround:Boolean;
		const ACCELERATION:Number = 10;
		
		public function Player() {
			init();
		}
		
		private function init():void{
			_platformCollision = false;
			_onGround = false;
			_xStart = 40;
			_yStart = 350;
			_xZiel = 40;
			_yZiel = 350;

			line.x = 40;
			line.y = 350;
			line.graphics.lineStyle(2,0x636363,1, false, LineScaleMode.NONE);
			line.graphics.lineTo(1,1);
			bg2.y = 300;
			bg2.x = 30;
			bg2.alpha = 0.4;
			bg2.scaleX = bg2.scaleY = 0.5;
			addChild(bg2);
			bg.y = 300;
			bg.alpha = 1;
			addChild(bg);
			hp.x = 275;
			hp.y = 30;
			hp.stop();
			addChild(hp);
			wand1.x = 500;
			wand1.y = 335;
			addChild(wand1);
			wand2.x = 1000;
			wand2.y = 335;
			addChild(wand2);
			wand3.x = 1500;
			wand3.y = 335;
			addChild(wand3);
			addChild(line);
			char.x = 40;
			char.y = 350;
			addChild(char);
			balken1.x = 100;
			balken1.y = 80;
			balken2.x = 100;
			balken2.y = 400;
			addChild(balken1);
			addChild(balken2);
			
						
			var format:TextFormat = new TextFormat(); 
            format.font = "Impact"; 
            format.color = 0x000000; 
            format.size = 50; 
			textbox.width = 250; 
            textbox.height = 100; 
			textbox.defaultTextFormat = format;
			
			addEventListener(Event.ENTER_FRAME, mainLoop);
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);			
		}
		
		private function onAddToStage(e:Event):void {
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onClick);
		}
		
		private function mainLoop(e:Event):void{
			if(health > 0){
				checkCollisionPlatform();
				checkCollisionWand();
				drawHook();		
				balken1.x -= 2;
				balken2.x -= 2;
				bg.x -= 1;
				bg2.x -= 0.5;
				wand1.x -= 2;
				wand3.x -= 2;
				wand2.x -= 2;
			}
			else{
				textbox.text = "GAME OVER";
				textbox.x = 165;
				textbox.y = 150;
				addChild(textbox); 
			    balken1.x -= 0;
				balken2.x -= 0;
				bg.x -= 0;
				bg2.x -= 0;
				wand1.x -= 0;
				wand3.x -= 0;
				wand2.x -= 0;
				char.stop();
			}
			
		}
		
		private function onClick(e:Event):void{
			trace("hier");
			if(_xStart == _xZiel && _yStart == _yZiel){
				_platformCollision = false;
				_xZiel = mouseX;
				_yZiel = mouseY;
				_mx = (mouseX - _xStart)/ Math.sqrt(Math.pow((mouseX - _xStart),2)+Math.pow((mouseY - _yStart),2));
				_my = (mouseY - _yStart)/ Math.sqrt(Math.pow((mouseX - _xStart),2)+Math.pow((mouseY - _yStart),2));
			}
		}
		
		private function drawHook():void{
			trace(_xStart+" "+_yStart);
			line.graphics.lineStyle(2,0x636363,1, false, LineScaleMode.NONE);
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
				line.x = char.x;
				line.y = char.y;
				line.scaleX = 1;
				line.scaleY = 1;
				_xStart = char.x;
				_yStart = 350;
				_xZiel = char.x;
			    _yZiel = 350;
				if(_onGround == false){
					char.y += 5;
				}
			}
		}
		
		private function checkCollisionPlatform():void{
			if(this.balken1.hitTestPoint(_xStart,_yStart)){
				//MovieClip(parent).textfield.text = "1 getroffen";
				_xZiel = _xStart;
				_yZiel = _yStart;
				_platformCollision = true;
				retractHook();
			}
			if(balken2.hitTestPoint(char.x,(char.y+19))){
			   _onGround = true;
			   }
			else{
				_onGround = false;
			}
			/*if(MovieClip(parent).balken2.hitTestPoint(_xStart,_yStart)){
				//MovieClip(parent).textfield.text = "2 getroffen";
				_xZiel = _xStart;
				_yZiel = _yStart;
				_platformCollision = true;
				retractHook();
			}*/
		}
		
		private function checkCollisionWand():void{
			if(wand1.hitTestPoint(char.x,char.y) && wand1.alpha != 0){
				health -= 1;
				hp.gotoAndStop(4-health);
				wand1.alpha = 0;
			}
			if(wand2.hitTestPoint(char.x,char.y) && wand2.alpha != 0){
				health -= 1;
				hp.gotoAndStop(4-health);
				wand2.alpha = 0;
			}
			if(wand3.hitTestPoint(char.x,char.y) && wand3.alpha != 0){
				health -= 1;
				hp.gotoAndStop(4-health);
				wand3.alpha = 0;
			}
		}
		
		private function retractHook():void{
			trace(line.scaleX/ACCELERATION +" "+line.scaleY/ACCELERATION+" "+_platformCollision);
			line.rotation = 180;
			line.x = _xZiel;
			line.y = _yZiel;
			line.scaleX -= _mx * ACCELERATION;
			line.scaleY -= _my * ACCELERATION;
			
			char.x += _mx * ACCELERATION
			char.y += _my * ACCELERATION;
			
			if ((Math.floor((line.scaleX/ACCELERATION))) == 0 && (Math.floor((line.scaleY/ACCELERATION))) == 0){
				trace("Klappt");
				_platformCollision = false;
				line.rotation = 0;
				_onGround = false;
			}
			
		}

	}
	
}
