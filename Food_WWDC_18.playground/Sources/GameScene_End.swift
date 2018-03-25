import Foundation
import SpriteKit

public class GameScene_End: SKScene {
    
    let FADE_DURATION = 2.0;
    let NO_OF_LINES = 10;
    
    var buttonReplay: SKLabelNode!
    
    override public func didMove(to view: SKView) {
        
        var i = 0;
        while (i < 10) {
            let labelLine = childNode(withName: "//line_" + String(i)) as? SKLabelNode
            labelLine!.run(SKAction.sequence([.wait(forDuration: FADE_DURATION * Double(i)), .fadeIn(withDuration: FADE_DURATION)]))
            
            i += 1;
        }
        
        buttonReplay = childNode(withName: "//replay") as? SKLabelNode
        buttonReplay!.run(SKAction.repeatForever(SKAction.sequence([.fadeIn(withDuration: 1), .fadeOut(withDuration: 1)])))
        
    }
    
    public func touchUp(atPoint pos : CGPoint) {
        if(atPoint(pos) == buttonReplay){
            
            if let scene = GameScene_Game(fileNamed: "GameScene_Game.sks") {
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
