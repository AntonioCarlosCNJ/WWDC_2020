import SpriteKit

public class Tooth {
    
    private var node: SKSpriteNode
    private var bacteria: [SKSpriteNode] = []
    
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
        if bacteria.count < 100 {
            let xPosition = Int.random(in: Int(node.size.width*0.15)..<Int(node.size.width*0.86))
            let yPosition = Int.random(in: Int(node.size.height*0.17)..<Int(node.size.height*0.84))
            
            let bacterium = SKSpriteNode(imageNamed: "bacterium")
            bacterium.name = "bacterium"
            bacterium.position = CGPoint(x: xPosition, y: yPosition)
            
            bacteria.append(bacterium)
            node.addChild(bacterium)
        }
    }
    
    public func removeBacteriumFromTooth(bacteriumNode: SKSpriteNode) {
        bacteriumNode.removeFromParent()
//        bacteria.remove(at: )
    }
    
    
}


