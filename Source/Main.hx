package;

import view.BucketView;
import flash.Lib;

class Main {
    function new(){

    }

    static function main() {
        flash.Lib.current.addChild(new BucketView());
    }
}