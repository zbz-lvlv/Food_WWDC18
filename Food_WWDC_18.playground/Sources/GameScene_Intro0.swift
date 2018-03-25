import Foundation
import SpriteKit

public class GameScene_Intro0: SKScene {
    
    let FADE_DURATION = 2.0;
    
    private var buttonNext: SKLabelNode!
    
    override public func didMove(to view: SKView) {

        let labelLine0 = childNode(withName: "//line_0") as? SKLabelNode
        let labelLine1 = childNode(withName: "//line_1") as? SKLabelNode
        let labelLine2 = childNode(withName: "//line_2") as? SKLabelNode
        let labelLine3 = childNode(withName: "//line_3") as? SKLabelNode
        buttonNext = childNode(withName: "//next") as? SKLabelNode

        labelLine0!.run(SKAction.sequence([.fadeIn(withDuration: FADE_DURATION)]))
        labelLine1!.run(SKAction.sequence([.wait(forDuration: FADE_DURATION * 1), .fadeIn(withDuration: FADE_DURATION)]))
        labelLine2!.run(SKAction.sequence([.wait(forDuration: FADE_DURATION * 2), .fadeIn(withDuration: FADE_DURATION)]))
        labelLine3!.run(SKAction.sequence([.wait(forDuration: FADE_DURATION * 3), .fadeIn(withDuration: FADE_DURATION)]))
        buttonNext!.run(SKAction.repeatForever(SKAction.sequence([.fadeIn(withDuration: 1), .fadeOut(withDuration: 1)])))
    
    }
    
    public func touchUp(atPoint pos : CGPoint) {
        if(atPoint(pos) == buttonNext){
           
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
