import Foundation
import SpriteKit

public class GameScene_Game: SKScene {

    //4 countries
    var countries = [Country(), Country(), Country(), Country()] //0, 1 = abundane, 2, 3 = food deficit
    var countryShapeNodes = [SKShapeNode(circleOfRadius: 80), SKShapeNode(circleOfRadius: 80), SKShapeNode(circleOfRadius: 80), SKShapeNode(circleOfRadius: 80)]
    
    //Robot
    var deliveryRobotLabel = SKLabelNode();
    var deliveryRobot = SKShapeNode(circleOfRadius: 40)
    var deliveryRobotFoodCount = 0;
    
    //Labels and corr. values
    var labelHungryPeopleHelped: SKLabelNode!
    var hungryPeopleHelped = 0
    
    var labelReputation: SKLabelNode!
    var reputation = 0;
    
    var labelRobotCapacity: SKLabelNode!
    var deliveryRobotCapacity = 3;
    
    var labelRobotCapacityUpgradeCost: SKLabelNode!
    var upgradeCost = 50;
    
    var buttonRobotCapacityUpgrade: SKLabelNode!
    
    //Vars
    var isHoldingRobot = false;
    
    //Timer (1 min, see how well you can do in one minute)
    var timer: Timer!
    var timeLeft = 60;
    
    var labelTimeLeft: SKLabelNode!
    
    override public func didMove(to view: SKView) {
        
        labelHungryPeopleHelped = childNode(withName: "//labelHungryPeopleHelped") as? SKLabelNode
        labelReputation = childNode(withName: "//labelReputation") as? SKLabelNode
        labelRobotCapacity = childNode(withName: "//labelRobotCapacity") as? SKLabelNode
        labelRobotCapacityUpgradeCost = childNode(withName: "//labelRobotCapacityUpgradeCost") as? SKLabelNode
        
        buttonRobotCapacityUpgrade = childNode(withName: "//buttonRobotCapacityUpgrade") as? SKLabelNode
        
        var i = 0
        for countryShapeNode in countryShapeNodes{
            
            if(i == 0 || i == 1){
                countryShapeNode.fillColor = UIColor(red: 196/255, green: 236/255, blue: 180/255, alpha: 1)
                countries[i].dHungryPeople = 0
                countries[i].dFood = 0
            }
            else{
                countryShapeNode.fillColor = UIColor(red: 248/255, green: 243/255, blue: 219/255, alpha: 1)
                countries[i].dHungryPeople = 0
                countries[i].dFood = 0
            }
            countryShapeNode.position = CGPoint(x: 120 + (i % 2) * 240, y: 120 + (i / 2) * 240)
            countryShapeNode.isAntialiased = false;
            countryShapeNodes.append(countryShapeNode)
            self.addChild(countryShapeNode)
            
            countries[i].shapeNode = countryShapeNode;
            
            i += 1;
            
        }
        
        deliveryRobotLabel.text = "0"
        deliveryRobotLabel.horizontalAlignmentMode = .center
        deliveryRobotLabel.verticalAlignmentMode = .center
        
        deliveryRobot.fillColor = UIColor(red: 236/255, green: 100/255, blue: 75/255, alpha: 1)
        deliveryRobot.position = CGPoint(x: 240, y: 240)
        deliveryRobot.addChild(deliveryRobotLabel)
        
        self.addChild(deliveryRobot)
        
        labelTimeLeft = childNode(withName: "//labelTimeLeft") as? SKLabelNode
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(GameScene_Game.updateTimer)), userInfo: nil, repeats: true)
        
    }
    
    @objc public func updateTimer(){
        
        timeLeft -= 1
        
        if(timeLeft == -1){
            timer.invalidate()
            
            presentScore()
            
        }
        
        labelTimeLeft.text = "0" + ":" + String(format: "%02d", timeLeft);
        
        var i = 0
        
        for country in countries{
            
            if(i == 0 || i == 1){ //Abundant
                country.dFood = 15 - Int(timeLeft / 4)
            }
            else{ //Deficit
                country.dHungryPeople = 12 - Int(timeLeft / 5)
            }
            country.update();
            country.addFoodAndHungryPeople();
            
            i += 1
            
        }
        
    }
    
    public func presentScore(){
        
        if let scene = GameScene_Score(fileNamed: "GameScene_Score.sks") {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            scene.score = hungryPeopleHelped;
            // Present the scene
            self.view?.presentScene(scene)
            
        }
        
    }
    
    public func touchDown(atPoint pos : CGPoint) {
        if(atPoint(pos) == deliveryRobot || atPoint(pos) == deliveryRobotLabel){
            isHoldingRobot = true;
        }
        
        if(atPoint(pos) == buttonRobotCapacityUpgrade){
            if(reputation >= upgradeCost){
                
                reputation -= upgradeCost
                labelReputation.text = String(reputation)
                
                upgradeCost *= 2
                labelRobotCapacityUpgradeCost.text = "(" + String(upgradeCost) + " reputation points)"
                
                deliveryRobotCapacity += 2
                labelRobotCapacity.text = String(deliveryRobotCapacity)
                
            }
        }
        
    }
    
    public func touchMoved(toPoint pos : CGPoint) {
        if(isHoldingRobot){
            deliveryRobot.position = pos;
            
            for country in countries{
                
                for foodNode in country.foodOnScreenNodes{
                    
                    //Picking up food and giving it to hungry people
                    if(calculateDistance(x1: pos.x, y1: pos.y, x2: country.getAbsolutePosition(node: foodNode).x, y2: country.getAbsolutePosition(node: foodNode).y) < 40 && deliveryRobotFoodCount < deliveryRobotCapacity){
                        
                        deliveryRobotFoodCount += 1
                        deliveryRobotLabel.text = String(deliveryRobotFoodCount)
                        
                        foodNode.removeFromParent()
                        country.foodOnScreenNodes.remove(at: country.foodOnScreenNodes.index(of: foodNode)!)
                        
                    }
                    
                }
                
                for hungryPeopleNode in country.hungryPeopleOnScreenNodes{
                    
                    //Picking up food and giving it to hungry people
                    if(calculateDistance(x1: pos.x, y1: pos.y, x2: country.getAbsolutePosition(node: hungryPeopleNode).x, y2: country.getAbsolutePosition(node: hungryPeopleNode).y) < 40 && deliveryRobotFoodCount > 0){
                        
                        deliveryRobotFoodCount -= 1
                        deliveryRobotLabel.text = String(deliveryRobotFoodCount)
                        
                        hungryPeopleNode.removeFromParent()
                        country.hungryPeopleOnScreenNodes.remove(at: country.hungryPeopleOnScreenNodes.index(of: hungryPeopleNode)!)
                        
                        hungryPeopleHelped += 1
                        labelHungryPeopleHelped.text = String(hungryPeopleHelped)
                        
                        reputation += 2
                        labelReputation.text = String(reputation)
                        
                    }
                    
                }
                
            }
        }
    }
    
    public func touchUp(atPoint pos : CGPoint) {
        if(atPoint(pos) == deliveryRobot || atPoint(pos) == deliveryRobotLabel){
            isHoldingRobot = false;
        }
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchDown(atPoint: t.location(in: self)) }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    override public func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    public func calculateDistance(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat) -> CGFloat{
        let square = (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1)
        return sqrt(square)
    }
    
}
