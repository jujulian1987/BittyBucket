import tjson.TJSON;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLRequest;
import flash.events.Event;

typedef Trade = {
    var amount:Float;
    var item:String;
    var price:Float;
    var trade_type:String;
    var tid:Int;
    var price_currency:String;
    var date:Date;
}

interface TradesCallback {
    function onNewTrades(newTrades:Array<Trade>) : Void;
}

class Trades {
    private static var savedInstance:Trades;
    private var allTrades:Array<Trade>;
    private var tradesCallback:TradesCallback;

    public static function getInstance(){
        if(savedInstance == null){
            savedInstance = new Trades();
        }
        return savedInstance;
    }

    public function setCallback(tradesCallback:TradesCallback){
        this.tradesCallback = tradesCallback;
    }

    function new() {
        super();

        initVars();

        var yourTimer:haxe.Timer = new haxe.Timer(10000);
        yourTimer.run = function():Void{
            getCurrentTrades();
        };
    }

    function initVars(){
        allTrades = new Array<Trade>();
    }

    function getCurrentTrades(){
        var loader = new URLLoader();
        var request = new URLRequest("https://btc-e.com/api/2/btc_usd/trades");

        loader.addEventListener(Event.COMPLETE, onComplete);
        loader.load(request);
    }

    function onComplete(e:Event){
        trace(e.target.data.toString());

        var objects = cast(TJSON.parse(e.target.data.toString()), Array<Dynamic>);
        var trades = new Array<Trade>();
        trace(objects.length);
        for(object in objects){
            trades.push({
            amount : object.amount,
            item : object.item,
            price : object.price,
            trade_type : object.trade_type,
            tid : object.tid,
            price_currency : object.price_currency,
            date: object.date
            });
        }

        addTrades(trades);
    }

    function addTrades(trades:Array<Trade>){
        var tradesLength = trades.length;

        for(trade in trades){
            if(!Lambda.exists(allTrades, function(ii) { return ii.tid==trade.tid; })){
                allTrades.push(trade);
            }
        }

        if(tradesCallback != null){
            tradesCallback.onNewTrades(allTrades.slice(tradesLength, allTrades.length));
        }
    }
}