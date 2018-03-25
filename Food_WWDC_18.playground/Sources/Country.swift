import Foundation
import SpriteKit

public class Country{
    
    public init(){
        
    }
    
    let FOODS_LIST = ["🍪","🍎","🍔","🥝","🍞","🍚"]
    let HUNGRY_PEOPLE_LIST = ["🙎‍♂️", "🙎"]
    
    var shapeNode: SKShapeNode!
    
    var hungryPeople = 0
    var food = 0
    var dHungryPeople = 0
    var dFood = 0
    
    var foodOnScreen = 0;
    var hungryPeopleOnScreen = 0;
    
    var foodOnScreenNodes: [SKLabelNode] = []
    var hungryPeopleOnScreenNodes: [SKLabelNode] = []
    
    public func update(){
        
        food += dFood;
        hungryPeople += dHungryPeople
        
    }
    
    public func addFoodAndHungryPeople(){
        
        while(food - foodOnScreen > 0){
            
            let foodNode = SKLabelNode();
            let randomFoodIndex = Int(arc4random_uniform(UInt32(FOODS_LIST.count)))
            foodNode.text = FOODS_LIST[randomFoodIndex]
            foodNode.fontSize = 10;
            foodNode.horizontalAlignmentMode = .center
            foodNode.verticalAlignmentMode = .center
            
            //56 * 2 is the length of the square inscribed inside the circle, such that the food is at a position that is always inside the square and henceforth the circle
            let x = Int(arc4random_uniform(56 * 2 + 1)) - 56
            let y = Int(arc4random_uniform(56 * 2 + 1)) - 56
            foodNode.position = CGPoint(x: x, y: y);
            
            foodOnScreenNodes.append(foodNode)
            shapeNode.addChild(foodNode)
            
            foodOnScreen += 1
            
        }
        
        while(hungryPeople - hungryPeopleOnScreen > 0){
            
            let hungryNode = SKLabelNode();
            let randomFoodIndex = Int(arc4random_uniform(UInt32(HUNGRY_PEOPLE_LIST.count)))
            hungryNode.text = HUNGRY_PEOPLE_LIST[randomFoodIndex]
            hungryNode.fontSize = 10;
            hungryNode.horizontalAlignmentMode = .center
            hungryNode.verticalAlignmentMode = .center
            
            //56 * 2 is the length of the square inscribed inside the circle, such that the food is at a position that is always inside the square and henceforth the circle
            let x = Int(arc4random_uniform(56 * 2 + 1)) - 56
            let y = Int(arc4random_uniform(56 * 2 + 1)) - 56
            hungryNode.position = CGPoint(x: x, y: y);
            
            hungryPeopleOnScreenNodes.append(hungryNode)
            shapeNode.addChild(hungryNode)
            
            hungryPeopleOnScreen += 1
            
        }
        
    }
    
    public func getAbsolutePosition(node: SKLabelNode) -> CGPoint{
        
        /*
        print(node.position.x)
        print(node.position.y)
        print("")
        */
        
        return CGPoint(x: node.position.x + shapeNode.position.x, y: node.position.y + shapeNode.position.y)
        
    }
    
}
