package physic.body;

import handler.DisplayHandler;
import view.CryptoView;
import nape.shape.Circle;
import nape.phys.BodyType;
import nape.phys.Body;
class CryptoBody{

    public static function createLitecoinBody(){
        var ball = new Body(BodyType.DYNAMIC);
        ball.shapes.add(new Circle(50));
        ball.position.setxy(DisplayHandler.getScreenSize().x*0.5, 0);
        ball.angularVel = 1;

        ball.userData.graphic = DisplayHandler.addToScene(new CryptoView(),1);

        return ball;
    }

}