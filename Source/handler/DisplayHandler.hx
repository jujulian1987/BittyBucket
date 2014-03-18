package handler;

import flash.geom.Point;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.Lib;

class DisplayHandler{
    static var spriteLayer:Array<Sprite> = new Array<Sprite>();

    public static function addToScene(dObject:DisplayObject, layer:Int):DisplayObject {
        if (layer < spriteLayer.length && layer >= 0) {
            spriteLayer[layer].addChild(dObject);
        }else if(layer >= spriteLayer.length){
            while (layer >= spriteLayer.length) {
                spriteLayer.push(new Sprite());
                Lib.current.addChild(spriteLayer[spriteLayer.length-1]);
            }
            spriteLayer[layer].addChild(dObject);
        }else {
            trace("Error: Layer out of bounds");
        }

        return dObject;
    }

    public static function removeFromScene(dObject:DisplayObject, layer:Int) {
        if (layer < spriteLayer.length && layer >= 0) {
            spriteLayer[layer].removeChild(dObject);
        }else {
            trace("Error: Layer out of bounds");
        }
    }

    public static function scale(x:Float, y:Float) {
        Lib.current.scaleX = x;
        Lib.current.scaleY = y;
    }

    public static function getScale():Point {
        return new Point(Lib.current.scaleX, Lib.current.scaleY);
    }

    public static function getScreenSize():Point {
        return new Point(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
    }

    public static function unload() {

        for (i in 0 ... spriteLayer.length) {
            for (k in 0 ... spriteLayer[i].numChildren) {
                trace("unload");
                spriteLayer[i].removeChildAt(0);
            }

        }
    }
}