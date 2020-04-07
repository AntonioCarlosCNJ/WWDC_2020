import SpriteKit

/**
 This  observer will observe the Mouth class
 */
public protocol ObserverBackgroundLayer: class {
    func didChangeAcidityLevel(increase: Bool)
    func didChangeBacteryLevel(decrease: Bool)
}

/**
 This delegate will delegate the logic to GameLayerGameScene
 */
public protocol BackgroundLayerDelegate: class {
    func logicToMakeChangeOfAcidityLevel(_ backgroundLayer: BackgroundLayerGameScene, didIncrease increase: Bool)
    func logicToChangeColorsOfChemicalReaction(_ backgroundLayer: BackgroundLayerGameScene, didDecrease decrease: Bool)
    func logicToShowChemicalLog(_ backgroundLayer: BackgroundLayerGameScene, chemicalLog: ChemicalLog, didIncreaseAcidityLevel increase: Bool)
}

public class BackgroundLayerGameScene: SKNode {
     
    //Attributes
    private var sceneSize: CGSize
    
    public weak var delegate: BackgroundLayerDelegate?
    
    private var backgroundColor: SKSpriteNode
    private var boardDesk = SKSpriteNode(imageNamed: BOARD_DESK_TX)
    
    private var shelf1 = SKSpriteNode(imageNamed: SHELF_TX)
    private var shelf2 = SKSpriteNode(imageNamed: SHELF_TX)
    private var shelf3 = SKSpriteNode(imageNamed: SHELF_TX)
    
    private var _mouth: Mouth
    public var mouth: Mouth {
        get {
            return _mouth
        }
    }
    
    private var _reagent = SKSpriteNode(imageNamed: REAGENT_TX)
    public var reagent: SKSpriteNode {
        get {
            return _reagent
        }
    }
    private var _reagentFull = SKSpriteNode(imageNamed: REAGENT_FULL_TX)
    public var reagentFull: SKSpriteNode {
        get {
            return _reagentFull
        }
    }
    
    private var _directArrow = SKSpriteNode(imageNamed: DIRECT_ARROW_TX)
    public var directArrow: SKSpriteNode {
        get {
            return _directArrow
        }
    }
    
    private var _reverseArrow = SKSpriteNode(imageNamed: REVERSE_ARROW_TX)
    public var reverseArrow: SKSpriteNode {
        get {
            return _reverseArrow
        }
    }
    
    private var _product = SKSpriteNode(imageNamed: PRODUCT_TX)
    public var product: SKSpriteNode {
        get {
            return _product
        }
    }
    private var _productFull = SKSpriteNode(imageNamed: PRODUCT_FULL_TX)
    public var productFull: SKSpriteNode {
        get {
            return _productFull
        }
    }
    
    private var pHTitleNode = SKSpriteNode(imageNamed: PH_TITLE_TX)
    private var _upArrow = SKSpriteNode(imageNamed: UP_ARROW_TX)
    public var upArrow: SKSpriteNode {
        get {
            return self._upArrow
        }
    }
    private var _downArrow = SKSpriteNode(imageNamed: DOWN_ARROW_TX)
    public var downArrow: SKSpriteNode {
        get {
            return self._downArrow
        }
    }
    public var phLabelNode = SKLabelNode()
    
    private var _chemicalLog: ChemicalLog
    public var chemicalLog: ChemicalLog {
        get  {
            return _chemicalLog
        }
    }
    
    //Initializers
    public init(sceneSize: CGSize) {
        
        //Set the size of the node
        self.sceneSize = sceneSize
        
        //Set the backgroundColor
        backgroundColor = SKSpriteNode(color: NSColor(calibratedRed: 137/255, green: 164/255, blue: 170/255,
                                                      alpha: 1.0), size: sceneSize)
        
        //Set the mouth texture and instantiate mouth before the super.init()
        let mouthTexture = SKTexture(imageNamed: MOUTH_TX)
        self._mouth = Mouth(texture: mouthTexture)
        
        //Initialize the ChemicalLog
        _chemicalLog = ChemicalLog()
        
        super.init()
        
//        self.setScale(0.5)
        
        //Set the backgroundNodes
        self.addBackgroundColor()
        self.addBoardDesk()
        
        //Set the mouth observer and add mouth to layer
        self._mouth.observer = self
        self._mouth.addMouthToLayer(backgroundLayer: self,
                                    position: CGPoint(x: boardDesk.position.x + ((boardDesk.size.width - mouth.node.size.width)/2),
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

        //Add the nodes of the chemicalLog
        self.addChemicalLogNodes()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Required init coder has not be implemented...")
    }
    
    //Methods
    
    /**
     This method add the background color to this layer.
     
     #Setting some attributes to this node:
        1. AnchorPoint
        2. zPosition
        3. isUserInteractionEnabled
     */
    private func addBackgroundColor() {
        backgroundColor.anchorPoint = CGPoint(x: 0, y: 0)
        backgroundColor.zPosition = zPositionBackgroundLayer.background.rawValue
        backgroundColor.isUserInteractionEnabled = true
        
        self.addChild(backgroundColor)
    }
    
    /**
     This method add the boardDesk to this layer
     
     #Setting some attributes to this node:
        1. anchorPoint
        2. position
        3. zPosition
        4. name
     */
    private func addBoardDesk(){
        boardDesk.setScale(0.5)
        boardDesk.anchorPoint = CGPoint(x: 0, y: 0)
        boardDesk.position = CGPoint(x: sceneSize.width*0.94 - boardDesk.frame.width, y: sceneSize.height*0.92 - boardDesk.frame.height)
        boardDesk.zPosition = zPositionBackgroundLayer.background.rawValue
        boardDesk.name = BOARD_DESK_NAME
        
        addChild(boardDesk)
    }

    /**
     This method add the First Shelf to this layer
     
     #Setting some attributes to this node:
        1. anchorPoint
        2. position
        3. name
        4. zPosition
     */
    private func addShelf1() {
        shelf1.setScale(0.5)
        shelf1.anchorPoint = CGPoint(x: 0, y: 0)
        shelf1.position = CGPoint(x: sceneSize.width*0.02, y: sceneSize.height*0.09)
        shelf1.name = SHELF_1_NAME
        shelf1.zPosition = zPositionBackgroundLayer.background.rawValue
        
        addChild(shelf1)
    }
    
    /**
    This method add the Second Shelf to this layer
    
    #Setting some attributes to this node:
       1. anchorPoint
       2. position
       3. name
       4. zPosition
    */
    private func addShelf2() {
        shelf2.setScale(0.5)
        shelf2.anchorPoint = CGPoint(x: 0, y: 0)
        shelf2.position = CGPoint(x: sceneSize.width*0.02, y: shelf1.frame.maxY + sceneSize.height*0.1)
        shelf2.name = SHELF_2_NAME
        shelf2.zPosition = zPositionBackgroundLayer.background.rawValue
        
        addChild(shelf2)
    }
    
    /**
    This method add the Third Shelf to this layer
    
    #Setting some attributes to this node:
       1. anchorPoint
       2. position
       3. name
       4. zPosition
    */
    private func addShelf3() {
        shelf3.setScale(0.5)
        shelf3.anchorPoint = CGPoint(x: 0, y: 0)
        shelf3.position = CGPoint(x: sceneSize.width*0.02, y: shelf2.frame.maxY + sceneSize.height*0.1)
        shelf3.name = SHELF_3_NAME
        shelf3.zPosition = zPositionBackgroundLayer.background.rawValue
        
        addChild(shelf3)
    }
    
    /**
     This method add the Reagent of Main Reaction to this layer
     
     #Setting some attributes to this node:
        1. anchorPoint
        2. position
        3. zPosition
        4. name
        5. alpha
     */
    private func addReagent() {
        _reagent.setScale(0.5)
        _reagent.anchorPoint = .zero
        _reagent.position = CGPoint(x: boardDesk.position.x + boardDesk.size.width*0.06, y: boardDesk.position.y + boardDesk.size.height * 0.88)
        _reagent.zPosition = zPositionBackgroundLayer.chemical.rawValue
        _reagent.name = REAGENT_NAME
        
        /**
            Set alpha .zero because the reagent are full, so only
            the reagent full has to apear
        */
        _reagent.alpha = .zero
        
        self.addChild(_reagent)
    }
    
    /**
    This method add the Reagent Full of Main Reaction to this layer
    
    #Setting some attributes to this node:
       1. anchorPoint
       2. position
       3. zPosition
       4. name
       5. alpha
    */
    private func addReagentFull() {
        _reagentFull.setScale(0.5)
        _reagentFull.anchorPoint = _reagent.anchorPoint
        _reagentFull.position = _reagent.position
        _reagentFull.zPosition = _reagent.zPosition
        _reagentFull.name = REAGENT_FULL_NAME
        
        _reagentFull.alpha = 1.0
        
        self.addChild(_reagentFull)
    }
    
    /**
     This method add the Reverse Arrow of Main Reaction to this layer
     
     #Setting some attributes to this node:
        1. anchorPoint
        2. position
        3. zPosition
        4. name
     
     #Using some functions:
        1. setScale
     */
    private func addReverseArrow() {
        _reverseArrow.setScale(0.5)
        _reverseArrow.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        _reverseArrow.setScale(0.5)
        _reverseArrow.position = CGPoint(x:  _reagent.size.width + _reagent.position.x*1.1, y: _reagent.position.y*1.045)
        _reverseArrow.zPosition = zPositionBackgroundLayer.chemical.rawValue
        _reverseArrow.name = REVERSE_ARROW_NAME
        
        self.addChild(_reverseArrow)
    }
    
    /**
    This method add the Direct Arrow of Main Reaction to this layer
    
    #Setting some attributes to this node:
       1. anchorPoint
       2. position
       3. zPosition
       4. name
    
    #Using some functions:
       1. setScale
    */
    private func addDirectArrow() {
        _directArrow.setScale(0.5)
        _directArrow.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        _directArrow.setScale(0.5)
        _directArrow.position = CGPoint(x: _reverseArrow.position.x, y: _reagent.position.y*1.075)
        _directArrow.zPosition = zPositionBackgroundLayer.chemical.rawValue
        _directArrow.name = DIRECT_ARROW_NAME
        
        self.addChild(_directArrow)
    }
    
    /**
     This method add the Product of Main Reaction to this layer
     
     #Setting some attributes to this node:
        1. anchorPoint
        2. position
        3. zPosition
        4. name
        5. alpha
     */
    private func addProduct() {
        _product.setScale(0.5)
        _product.anchorPoint = .zero
        _product.position = CGPoint(x: _reverseArrow.size.width + _reverseArrow.position.x, y: _reagent.position.y*1.005)
        _product.zPosition = zPositionBackgroundLayer.chemical.rawValue
        _product.name = PRODUCT_NAME
        
        _product.alpha = 1.0
        
        self.addChild(_product)
    }
    
    /**
     This method add the Product of Main Reaction to this layer
     
     #Setting some attributes to this node:
        1. anchorPoint
        2. position
        3. zPosition
        4. name
        5. alpha
     */
    private func addProductFull() {
        _productFull.setScale(0.5)
        _productFull.anchorPoint = _product.anchorPoint
        _productFull.position = _product.position
        _productFull.zPosition = _product.zPosition
        _productFull.name = PRODUCT_FULL_NAME
        
        /**
            Set alpha .zero because the reagent are full, so only
            the product has to apear
        */
        _productFull.alpha = .zero
        
        self.addChild(_productFull)
    }
    
    /**
     This method add the Ph Title to this layer
     
     #Setting some attributes to this node:
        1. anchorPoint
        2. position
        3. zPosition
        4. name
     */
    public func addPhtitleNode() {
        pHTitleNode.setScale(0.5)
        pHTitleNode.anchorPoint = CGPoint(x: 0, y: 0)
        pHTitleNode.position = CGPoint(x: boardDesk.position.x + boardDesk.size.width * 0.815,
                                       y: boardDesk.position.y + boardDesk.size.height * 0.52)
        pHTitleNode.zPosition = zPositionBackgroundLayer.chemical.rawValue
        pHTitleNode.name = PH_TITLE_NAME
        
        self.addChild(pHTitleNode)
    }
    
    /**
     This method add the Up Arrow of pH to this layer
     
     #Setting some attributes to this node:
        1. anchorPoint
        2. position
        3. zPosition
        4. name
        5. isHidden
     */
    public func addUpArrow() {
        _upArrow.setScale(0.5)
        _upArrow.anchorPoint = CGPoint(x: 0, y: 0)
        _upArrow.position = CGPoint(x: pHTitleNode.position.x + (pHTitleNode.position.x*0.05),
                                   y: pHTitleNode.position.y*0.82)
        _upArrow.zPosition = zPositionBackgroundLayer.chemical.rawValue
        _upArrow.name = UP_ARROW_NAME
        
        //Is hidden is true, because the scenes start with pH decreasing
        _upArrow.isHidden = true
        
        self.addChild(_upArrow)
    }
    
   /**
    This method add the Down Arrow of pH to this layer
    
    #Setting some attributes to this node:
       1. anchorPoint
       2. position
       3. zPosition
       4. name
    */
    public func addDownArrow() {
        _downArrow.setScale(0.5)
        _downArrow.anchorPoint = CGPoint(x: 0, y: 0)
        _downArrow.position = CGPoint(x: pHTitleNode.position.x + (pHTitleNode.position.x*0.05),
                                   y: pHTitleNode.position.y*0.82)
        _downArrow.zPosition = zPositionBackgroundLayer.chemical.rawValue
        _downArrow.name = DOWN_ARROW_NAME
        
        self.addChild(_downArrow)
    }
    
    /**
     This method add the pH label to this layer, to show the Current pH level of the mouth
     
     #Setting some attributes to this node:
        1. text
        2. fontName
        3. position
        4. fontSize
        5. zPosition
     */
    public func addPhLabelNode() {
        phLabelNode.text = "\(mouth.currentAcidityLevel)"
        phLabelNode.fontName = PH_LABEL_FONT
        phLabelNode.position = CGPoint(x: pHTitleNode.position.x + (pHTitleNode.position.x*0.01),
                                       y: pHTitleNode.position.y*0.82)
        phLabelNode.fontSize = PH_LABEL_FONT_SIZE
        phLabelNode.zPosition = zPositionBackgroundLayer.chemical.rawValue
        
        self.addChild(phLabelNode)
    }
    
    /**
     This method add the chemicalLogNodes to this layer
     */
    private func addChemicalLogNodes() {
        self._chemicalLog.addReagentToLayer(self, position: CGPoint(x: boardDesk.position.x*1.28, y: sceneSize.height*0.26))
        self._chemicalLog.addProductOneToLayer(self, position: CGPoint(x: boardDesk.position.x*1.28, y: sceneSize.height*0.26))
        self._chemicalLog.addProductTwoToLayer(self, position: CGPoint(x: boardDesk.position.x*1.28, y: sceneSize.height*0.26))
        self._chemicalLog.addProductThreeToLayer(self, position: CGPoint(x: boardDesk.position.x*1.28, y: sceneSize.height*0.26))
    }
    
}

extension BackgroundLayerGameScene: ObserverBackgroundLayer {
    
    /**
     This method delegates the logic to change the acidity level
     and to show the chemical log
     */
    public func didChangeAcidityLevel(increase: Bool) {
        self.delegate?.logicToMakeChangeOfAcidityLevel(self, didIncrease: increase)
        self.delegate?.logicToShowChemicalLog(self, chemicalLog: _chemicalLog, didIncreaseAcidityLevel: increase)
    }
    
    /**
     This method delegates the logic to change the colors of chemical reaction
     */
    public func didChangeBacteryLevel(decrease: Bool) {
        self.delegate?.logicToChangeColorsOfChemicalReaction(self, didDecrease: decrease)
    }
    
}

