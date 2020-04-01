import SpriteKit

public protocol Item {
    
    var node: SKSpriteNode {get set}
    var speedReproduction: TimeInterval {get set}
    
    func createNode()
    func addNodeToHudLayer(hudLayer: HudLayerGameScene, position: CGPoint)
    
}

