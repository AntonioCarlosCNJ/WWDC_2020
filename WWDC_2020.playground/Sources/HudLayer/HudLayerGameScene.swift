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
    
    //Initializers
    public init(sceneSize: CGSize) {
        //Setting the size of the node
        self._sceneSize = sceneSize
        self._toothBrush = ToothBrush()
        
        //Instantiating the Hud Attributes
        
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
    }
    
    
}

