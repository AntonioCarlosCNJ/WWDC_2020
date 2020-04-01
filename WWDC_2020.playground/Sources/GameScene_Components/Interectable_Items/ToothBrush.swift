import SpriteKit

public class ToothBrush: Item {
    
    // Attributes
    public var node: SKSpriteNode = SKSpriteNode(imageNamed: "interactable_items/toothbrush")
    public var speedReproduction: TimeInterval
    
    
    // Initializers
    public init() {
        self.speedReproduction = 0.4
        
        self.createNode()
    }
    
    // Methods
    public func createNode() {
        node.name = "toothBrush"
        node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        node.setScale(0.15)
        node.zPosition = zPositionOfElements.item.rawValue
    }
    
    
    public func addNodeToHudLayer(hudLayer: HudLayerGameScene, position: CGPoint) {
        node.position = position
        hudLayer.addChild(self.node)
    }
}

