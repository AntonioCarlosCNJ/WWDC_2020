import SpriteKit

public class ToothBrush: Item {
    
    // Attributes
    public var node: SKSpriteNode = SKSpriteNode(imageNamed: TOOTHBRUSH_TEXTURE)
    public var contactNode: SKSpriteNode = SKSpriteNode(imageNamed: CONTACT_TEXTURE)
    public var speedReproduction: TimeInterval?
    
    public var initialPosition: CGPoint = .zero
    
    
    // Initializers
    public init() {
        self.createNode()
        self.createAndAddContactNodeToToothBrush()
    }
    
    // Methods
    public func createNode() {
        node.name = TOOTHBRUSH_NAME
        node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        node.setScale(0.15)
        node.zPosition = zPositionHudLayer.toothBrush.rawValue
    }
    
    public func createAndAddContactNodeToToothBrush() {
        contactNode.name = CONTACT_NAME
        contactNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        contactNode.zPosition = zPositionHudLayer.toothBrush.rawValue

        contactNode.position = CGPoint(x: node.size.width*1.7, y: node.size.height*1.8)
        
        node.addChild(contactNode)
    }
    
    
    public func addNodeToHudLayer(hudLayer: HudLayerGameScene, position: CGPoint) {
        self.initialPosition = position
        node.position = position
        hudLayer.addChild(self.node)
    }
}

