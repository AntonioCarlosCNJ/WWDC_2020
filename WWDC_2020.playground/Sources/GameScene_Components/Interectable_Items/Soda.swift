import SpriteKit

public class Soda: Item {
    
    //Attributes
    public var node: SKSpriteNode = SKSpriteNode(imageNamed: "interactable_items/soda")
    public var speedReproduction: TimeInterval? = -1.6
    
    //Initializers
    public init() {
        self.createNode()
    }
    
    //Methods
    public func createNode() {
        node.name = "soda"
        node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        node.setScale(0.15)
        node.zPosition = zPositionOfElements.item.rawValue
    }
    
    public func addNodeToHudLayer(hudLayer: HudLayerGameScene, position: CGPoint) {
        node.position = position
        hudLayer.addChild(self.node)
    }
}

