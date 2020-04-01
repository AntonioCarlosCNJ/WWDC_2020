import SpriteKit

public class Tooth {
    
    private var node: SKSpriteNode
    private var bacteria: [SKSpriteNode] = []
    
    public weak var observer: Observer?
    
    public init(name: String, image: String) {
        self.node = SKSpriteNode(imageNamed: image)
        
        node.name = name
        node.anchorPoint = CGPoint(x: 0, y: 0)
    }
    
    public func addToothToMouth(mouthNode: SKSpriteNode, position: CGPoint) {
        self.node.position = position
        mouthNode.addChild(self.node)
    }
    
    public func addBacteriumToTooth() {
        if bacteria.count < MAX_BACTERIA_AMOUNT_PER_TOOTH {
            let xPosition = Int.random(in: Int(node.size.width*0.18)..<Int(node.size.width*0.85))
            let yPosition = Int.random(in: Int(node.size.height*0.17)..<Int(node.size.height*0.83))
            
            let bacterium = SKSpriteNode(imageNamed: "bacterium")
            bacterium.name = "bacterium"
            bacterium.position = CGPoint(x: xPosition, y: yPosition)
            
            observer?.decreaseAcidityLevel()
            
            bacteria.append(bacterium)
            node.addChild(bacterium)
        }
    }
    
    
}


