import SpriteKit

public class Sandwich: Item {
    
    //Attributes
    public var node: SKSpriteNode = SKSpriteNode(imageNamed: "interactable_items/sandwich")
    public var speedReproduction: TimeInterval? = -0.8
    
    //Initializers
    public init() {
        self.createNode()
    }
    
    //Methods
    public func createNode() {
        node.name = "sandwich"
        node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        node.setScale(0.15)
        node.zPosition = zPositionOfElements.item.rawValue
    }
    
    public func addNodeToHudLayer(hudLayer: HudLayerGameScene, position: CGPoint) {
        node.position = position
        hudLayer.addChild(self.node)
    }
    
    
    
    
}

