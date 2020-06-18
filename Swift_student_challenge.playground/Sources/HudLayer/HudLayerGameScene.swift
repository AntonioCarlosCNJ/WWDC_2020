import SpriteKit

public class HudLayerGameScene: SKNode {
    
    //Attributes
    public var sceneSize: CGSize {
        get {
            return self._sceneSize
        }
    }
    private var _sceneSize: CGSize
    
    private var _toothBrush: ToothBrush
    public var toothBrush: ToothBrush {
        get {
            return _toothBrush
        }
    }
    
    private var _soda: Soda
    public var soda: Soda {
        get {
            return _soda
        }
    }
    
    private var _sandwich: Sandwich
    public var sandwich: Sandwich {
        get {
            return _sandwich
        }
    }
    
    //Initializers
    public init(sceneSize: CGSize) {
        //Setting the size of the node
        self._sceneSize = sceneSize
        
        //Instantiating the Hud Attributes
        self._toothBrush = ToothBrush()
        self._soda = Soda()
        self._sandwich = Sandwich()
        
        super.init()
        
        //Adding the Hud Attributes
        self.addItemsToLayer()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("required init coder has not be implemented...")
    }
    
    //Methods
    private func addItemsToLayer() {
        _toothBrush.addNodeToHudLayer(hudLayer: self, position: CGPoint(x: sceneSize.width*0.15, y: sceneSize.height*0.785))
        _sandwich.addNodeToHudLayer(hudLayer: self, position: CGPoint(x: sceneSize.width*0.15, y: sceneSize.height*0.515))
        _soda.addNodeToHudLayer(hudLayer: self, position: CGPoint(x: sceneSize.width*0.16, y: sceneSize.height*0.27))
    }
    
    
}

