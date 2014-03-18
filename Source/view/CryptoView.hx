package view;

import openfl.Assets;
import flash.display.Bitmap;
import flash.display.Sprite;

class CryptoView extends Sprite {
    public function new() {
        super();
        var bitmap = new Bitmap(Assets.getBitmapData("assets/logo_litecoin.png"));
        bitmap.width = 100;
        bitmap.height = 100;
        bitmap.x = -bitmap.width * 0.5;
        bitmap.y = -bitmap.height * 0.5;
        addChild(bitmap);
    }
}
