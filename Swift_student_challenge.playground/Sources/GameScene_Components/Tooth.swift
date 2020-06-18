import SpriteKit

public class Tooth {
    
    private var _node: SKSpriteNode
    public var node: SKSpriteNode {
        get  {
            return self._node
        }
    }
    
    private var _bacteria: [SKSpriteNode] = []
    public var bacteria: [SKSpriteNode] {
        get {
            return self._bacteria
        }
        set {
            self._bacteria = newValue
        }
    }
    
    public weak var observer: Observer?
    
    public init(name: String, image: String) {
        self._node = SKSpriteNode(imageNamed: image)
        
        _node.name = name
        _node.anchorPoint = CGPoint(x: 0, y: 0)
    }
    
    public func addToothToMouth(mouthNode: SKSpriteNode, position: CGPoint) {
        self._node.position = position
        mouthNode.addChild(self._node)
    }
    
    public func addBacteriumToTooth(completion: () -> Void) {
        if _bacteria.count < MAX_BACTERIA_AMOUNT_PER_TOOTH {
            let xPosition = Int.random(in: Int(_node.size.width*0.18)..<Int(_node.size.width*0.85))
            let yPosition = Int.random(in: Int(_node.size.height*0.17)..<Int(_node.size.height*0.83))
            
            let bacterium = SKSpriteNode(imageNamed: BACTERIUM_TX)
            bacterium.name = BACTERIUM_NAME
            bacterium.position = CGPoint(x: xPosition, y: yPosition)
            
            observer?.decreaseAcidityLevel()
            
            _bacteria.append(bacterium)
            _node.addChild(bacterium)
            
            completion()
        }
    }
    
    public func removeBacteriaFromTooth(_ bacterium: SKSpriteNode) {
        bacterium.removeFromParent()
        bacteria.remove(at: bacteria.firstIndex(of: bacterium)!)
        observer?.increaseAcidityLevel()
    }
    
    
}


