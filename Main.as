package  {
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	import flash.display.LineScaleMode;
	import flashx.textLayout.utils.CharacterUtil;
	import flash.display.MovieClip;
	
	public class Main extends Sprite{
		
		var figur:Player;
		
		public function Main() {
			init();
		}
		
		private function init():void{
			figur = new Player();
			addChild(figur);

		}
	}
	
}
