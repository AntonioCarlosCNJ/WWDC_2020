import SpriteKit

public enum ItemType {
    case accelerant, retardant
}

public class Item {
    
    private var node: SKSpriteNode
    
    private var _percentage: Int
    public var percentage: Int {
        get {
            return _percentage
        }
    }
    
    private var _acidPercentage: Int
    public var acidPercentage: Int {
        get {
            return _acidPercentage
        }
    }
    
    private var _itemType: ItemType
    public var itemType: ItemType {
        get {
            return _itemType
        }
    }
    
    public init(name: String, texture: SKTexture, percentage: Int, acidPercentage: Int, itemType: ItemType) {
        node = SKSpriteNode(texture: texture)
        node.name = name
        node.zPosition = zPositionOfElements.item.rawValue
        node.setScale(0.15)
        node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self._itemType = itemType
        self._percentage = percentage
        self._acidPercentage = acidPercentage
    }
    
    public func addItemToLayer(hudLayer: HudLayerGameScene, position: CGPoint) {
        self.node.position = position
        hudLayer.addChild(self.node)
    }
    
}

