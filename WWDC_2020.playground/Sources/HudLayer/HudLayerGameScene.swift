import SpriteKit

public class HudLayerGameScene: SKNode {
    
    //Attributes
    public var sceneSize: CGSize {
        get {
            return self._sceneSize
        }
    }
    private var _sceneSize: CGSize
    
    private var _soda: Item
    public var soda: Item {
        get {
            return _soda
        }
    }
    
    private var _sandwich: Item
    public var sandwich: Item {
        get {
            return _sandwich
        }
    }
    
    private var _toothBrush: Item
    public var toothBrush: Item {
        get {
            return _toothBrush
        }
    }
    
    //Initializers
    public init(sceneSize: CGSize) {
        //Setting the size of the node
        self._sceneSize = sceneSize
        
        //Instantiating the Hud Attributes
        self._soda = Item(name: "soda", texture: SKTexture(imageNamed: "interactable_items/soda"),
                         percentage: 20, acidPercentage: 30, itemType: .accelerant)
        self._sandwich = Item(name: "sandwich", texture: SKTexture(imageNamed: "interactable_items/sandwich"),
                             percentage: 10, acidPercentage: 5, itemType: .accelerant)
        self._toothBrush = Item(name: "toothbrush", texture: SKTexture(imageNamed: "interactable_items/toothbrush"),
                               percentage: 80, acidPercentage: 100, itemType: .retardant)
        
        super.init()
        
        //Adding the Hud Attributes
        self.addItemsToLayer()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("required init coder has not be implemented...")
    }
    
    //Methods
    private func addItemsToLayer() {
        _soda.addItemToLayer(hudLayer: self, position: CGPoint(x: sceneSize.width*0.15, y: sceneSize.height*0.25))
        _sandwich.addItemToLayer(hudLayer: self, position: CGPoint(x: sceneSize.width*0.15, y: sceneSize.height*0.51))
        _toothBrush.addItemToLayer(hudLayer: self, position: CGPoint(x: sceneSize.width*0.15, y: sceneSize.height*0.785))
    }
    
    
}

