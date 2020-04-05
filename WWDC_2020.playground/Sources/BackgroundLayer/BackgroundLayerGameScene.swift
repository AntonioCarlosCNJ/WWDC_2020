import SpriteKit

public protocol ObserverBackgroundLayer: class {
    func didChangeAcidityLevel(increase: Bool)
    func didChangeBacteryLevel(decrease: Bool)
}

public protocol BackgroundLayerDelegate: class {
    func logicToMakeChangeOfAcidityLevel(_ backgroundLayer: BackgroundLayerGameScene, didIncrease increase: Bool)
    func logicToChangeColorsOfChemicalReaction(_ backgroundLayer: BackgroundLayerGameScene, didDecrease decrease: Bool)
}

public class BackgroundLayerGameScene: SKNode {
     
    //Attributes
    private var sceneSize: CGSize
    
    public weak var delegate: BackgroundLayerDelegate?
    
    private var backgroundColor: SKSpriteNode
    private var boardDesk = SKSpriteNode(imageNamed: "background/board_desk")
    
    private var shelf1 = SKSpriteNode(imageNamed: "background/shelf")
    private var shelf2 = SKSpriteNode(imageNamed: "background/shelf")
    private var shelf3 = SKSpriteNode(imageNamed: "background/shelf")
    
    private var _mouth: Mouth
    public var mouth: Mouth {
        get {
            return _mouth
        }
    }
    
    private var _reagent = SKSpriteNode(imageNamed: "Main_Reaction/reagent")
    public var reagent: SKSpriteNode {
        get {
            return _reagent
        }
    }
    private var _reagentFull = SKSpriteNode(imageNamed: "Main_Reaction/reagent_full")
    public var reagentFull: SKSpriteNode {
        get {
            return _reagentFull
        }
    }
    
    private var _directArrow = SKSpriteNode(imageNamed: "Main_Reaction/direct")
    public var directArrow: SKSpriteNode {
        get {
            return _directArrow
        }
    }
    
    private var _reverseArrow = SKSpriteNode(imageNamed: "Main_Reaction/reverse")
    public var reverseArrow: SKSpriteNode {
        get {
            return _reverseArrow
        }
    }
    
    private var _product = SKSpriteNode(imageNamed: "Main_Reaction/product")
    public var product: SKSpriteNode {
        get {
            return _product
        }
    }
    private var _productFull = SKSpriteNode(imageNamed: "Main_Reaction/product_full")
    public var productFull: SKSpriteNode {
        get {
            return _productFull
        }
    }
    
    private var pHTitleNode = SKSpriteNode(imageNamed: "chemistry/pH")
    private var _upArrow = SKSpriteNode(imageNamed: "chemistry/up_arrow")
    public var upArrow: SKSpriteNode {
        get {
            return self._upArrow
        }
    }
    private var _downArrow = SKSpriteNode(imageNamed: "chemistry/down_arrow")
    public var downArrow: SKSpriteNode {
        get {
            return self._downArrow
        }
    }
    public var phLabelNode = SKLabelNode()
    
    //Initializers
    public init(sceneSize: CGSize) {
        
        //Set the size of the node
        self.sceneSize = sceneSize
        
        //Set the backgroundColor
        backgroundColor = SKSpriteNode(color: NSColor(calibratedRed: 137/255, green: 164/255, blue: 170/255,
                                                      alpha: 1.0), size: sceneSize)
        
        //Set the mouth texture and instantiate mouth before the super.init()
        let mouthTexture = SKTexture(imageNamed: "mouth/mouth")
        self._mouth = Mouth(texture: mouthTexture)
        
        
        super.init()
        
        //Set the backgroundNodes
        self.addBackgroundColor()
        self.addBoardDesk()
        
        //Set the mouth observer and add mouth to layer
        self._mouth.observer = self
        self._mouth.addMouthToLayer(backgroundLayer: self,
                                    position: CGPoint(x: boardDesk.position.x + ((boardDesk.size.width - mouthTexture.size().width)/2),
                                                     y: sceneSize.height*0.12))
        
        //Add shelfs to layer
        self.addShelf1()
        self.addShelf2()
        self.addShelf3()
        
        //Add the nodes for main reaction
        self.addReagent()
        self.addReagentFull()
        self.addReverseArrow()
        self.addDirectArrow()
        self.addProduct()
        self.addProductFull()
        
        //Add the nodes to show acidity level(pH)
        self.addPhtitleNode()
        self.addUpArrow()
        self.addDownArrow()
        self.addPhLabelNode()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Required init coder has not be implemented...")
    }
    
    //Methods
    private func addBackgroundColor() {
        backgroundColor.anchorPoint = CGPoint(x: 0, y: 0)
        backgroundColor.zPosition = zPositionOfElements.backgroundColor.rawValue
        backgroundColor.isUserInteractionEnabled = true
        
        self.addChild(backgroundColor)
    }
    
    private func addBoardDesk(){
        boardDesk.anchorPoint = CGPoint(x: 0, y: 0)
        boardDesk.position = CGPoint(x: sceneSize.width*0.94 - boardDesk.frame.width, y: sceneSize.height*0.92 - boardDesk.frame.height)
        boardDesk.zPosition = zPositionOfElements.boardDesk.rawValue
        boardDesk.name = "boardDesk"
        
        addChild(boardDesk)
    }

    private func addShelf1() {
        shelf1.anchorPoint = CGPoint(x: 0, y: 0)
        shelf1.position = CGPoint(x: sceneSize.width*0.02, y: sceneSize.height*0.09)
        shelf1.name = "shelf1"
        
        addChild(shelf1)
    }
    
    private func addShelf2() {
        shelf2.anchorPoint = CGPoint(x: 0, y: 0)
        shelf2.position = CGPoint(x: sceneSize.width*0.02, y: shelf1.frame.maxY + sceneSize.height*0.1)
        shelf2.name = "shelf2"
        
        addChild(shelf2)
    }
    
    private func addShelf3() {
        shelf3.anchorPoint = CGPoint(x: 0, y: 0)
        shelf3.position = CGPoint(x: sceneSize.width*0.02, y: shelf2.frame.maxY + sceneSize.height*0.1)
        shelf3.name = "shelf3"
        
        addChild(shelf3)
    }
    
    private func addReagent() {
        _reagent.anchorPoint = .zero
        _reagent.position = CGPoint(x: boardDesk.position.x + boardDesk.size.width*0.06, y: boardDesk.position.y + boardDesk.size.height * 0.88)
        _reagent.zPosition = zPositionOfElements.chemicalReaction.rawValue
        _reagent.name = "reagent"
        
        /**
            Set alpha .zero because the reagent are full, so only
            the reagent full has to apear
        */
        _reagent.alpha = .zero
        
        self.addChild(_reagent)
    }
    
    private func addReagentFull() {
        _reagentFull.anchorPoint = _reagent.anchorPoint
        _reagentFull.position = _reagent.position
        _reagentFull.zPosition = _reagent.zPosition
        _reagentFull.name = "reagentFull"
        
        _reagentFull.alpha = 1.0
        
        self.addChild(_reagentFull)
    }
    
    private func addReverseArrow() {
        _reverseArrow.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        _reverseArrow.setScale(0.5)
        _reverseArrow.position = CGPoint(x:  _reagent.size.width + _reagent.position.x*1.1, y: _reagent.position.y*1.045)
        _reverseArrow.zPosition = zPositionOfElements.chemicalReaction.rawValue
        _reverseArrow.name = "reverseArrow"
        
        self.addChild(_reverseArrow)
    }
    
    private func addDirectArrow() {
        _directArrow.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        _directArrow.setScale(0.5)
        _directArrow.position = CGPoint(x: _reverseArrow.position.x, y: _reagent.position.y*1.075)
        _directArrow.zPosition = zPositionOfElements.chemicalReaction.rawValue
        _directArrow.name = "directArrow"
        
        self.addChild(_directArrow)
    }
    
    private func addProduct() {
        _product.anchorPoint = .zero
        _product.position = CGPoint(x: _reverseArrow.size.width + _reverseArrow.position.x, y: _reagent.position.y*1.005)
        _product.zPosition = zPositionOfElements.chemicalReaction.rawValue
        _product.name = "product"
        
        _product.alpha = 1.0
        
        self.addChild(_product)
    }
    private func addProductFull() {
        _productFull.anchorPoint = _product.anchorPoint
        _productFull.position = _product.position
        _productFull.zPosition = _product.zPosition
        _productFull.name = "productFull"
        
        /**
            Set alpha .zero because the reagent are full, so only
            the product has to apear
        */
        _productFull.alpha = .zero
        
        self.addChild(_productFull)
    }
    
    public func addPhtitleNode() {
        pHTitleNode.anchorPoint = CGPoint(x: 0, y: 0)
        pHTitleNode.position = CGPoint(x: boardDesk.position.x + boardDesk.size.width * 0.815,
                                       y: boardDesk.position.y + boardDesk.size.height * 0.52)
        pHTitleNode.zPosition = zPositionOfElements.chemicalReaction.rawValue
        pHTitleNode.name = "pHTitleNode"
        
        self.addChild(pHTitleNode)
    }
    
    public func addUpArrow() {
        _upArrow.anchorPoint = CGPoint(x: 0, y: 0)
        _upArrow.position = CGPoint(x: pHTitleNode.position.x + (pHTitleNode.position.x*0.05),
                                   y: pHTitleNode.position.y*0.82)
        _upArrow.zPosition = zPositionOfElements.chemicalReaction.rawValue
        _upArrow.name = "upArrow"
        _upArrow.isHidden = true
        
        self.addChild(_upArrow)
    }
    
    public func addDownArrow() {
        _downArrow.anchorPoint = CGPoint(x: 0, y: 0)
        _downArrow.position = CGPoint(x: pHTitleNode.position.x + (pHTitleNode.position.x*0.05),
                                   y: pHTitleNode.position.y*0.82)
        _downArrow.zPosition = zPositionOfElements.chemicalReaction.rawValue
        _downArrow.name = "downArrow"
        
        self.addChild(_downArrow)
    }
    public func addPhLabelNode() {
        phLabelNode.text = "\(mouth.currentAcidityLevel)"
        phLabelNode.fontName = "Hey October"
        phLabelNode.position = CGPoint(x: pHTitleNode.position.x + (pHTitleNode.position.x*0.01),
                                       y: pHTitleNode.position.y*0.82)
        phLabelNode.fontSize = 26
        phLabelNode.zPosition = zPositionOfElements.chemicalReaction.rawValue
        
        self.addChild(phLabelNode)
    }
    
}

extension BackgroundLayerGameScene: ObserverBackgroundLayer {
    
    public func didChangeAcidityLevel(increase: Bool) {
        self.delegate?.logicToMakeChangeOfAcidityLevel(self, didIncrease: increase)
    }
    
    public func didChangeBacteryLevel(decrease: Bool) {
        self.delegate?.logicToChangeColorsOfChemicalReaction(self, didDecrease: decrease)
    }
    
}

