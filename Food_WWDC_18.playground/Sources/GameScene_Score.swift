import Foundation
import SpriteKit

public class GameScene_Score: SKScene {
    
    var labelScore: SKLabelNode!
    private var buttonNext: SKLabelNode!
    
    var score = 0;
    
    override public func didMove(to view: SKView) {
        
        //let labelLine0 = childNode(withName: "//line_0") as? SKLabelNode
        //let labelLine1 = childNode(withName: "//line_1") as? SKLabelNode
        labelScore = childNode(withName: "//score") as? SKLabelNode
        //let labelLine3 = childNode(withName: "//line_3") as? SKLabelNode
        buttonNext = childNode(withName: "//next") as? SKLabelNode
        
        pushScore();
        
    }
    
    public func pushScore(){
        labelScore.text = String(score)
    }
    
    public func touchUp(atPoint pos : CGPoint) {
        if(atPoint(pos) == buttonNext){
            
            if let scene = GameScene_End(fileNamed: "GameScene_End.sks") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                self.view?.presentScene(scene)
            }
            
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    override public func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
