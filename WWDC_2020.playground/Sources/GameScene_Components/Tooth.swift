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
    
    
}


