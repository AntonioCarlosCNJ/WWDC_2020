import SpriteKit

public protocol ObserverBackgroundLayer: class {
    
    func changepHLabelNodeAndArrow(increase: Bool)
    
}

public class BackgroundLayerGameScene: SKNode {
     
    //Attributes
    private var sceneSize: CGSize
    
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
    
    private var chemicalReaction = SKSpriteNode(imageNamed: "chemistry/chemical_reaction")
    private var directArrow = SKSpriteNode(imageNamed: "chemistry/direct")
    private var reverseArrow = SKSpriteNode(imageNamed: "chemistry/reverse")
    
    private var pHTitleNode = SKSpriteNode(imageNamed: "pH")
    private var upArrow = SKSpriteNode(imageNamed: "up_arrow")
    private var downArrow = SKSpriteNode(imageNamed: "down_arrow")
    private var phLabelNode = SKLabelNode()
    
    //Initializers
    public init(sceneSize: CGSize) {
        
        //Set the size of the node
        self.sceneSize = sceneSize
        
        //Set the backgroundColor
        backgroundColor = SKSpriteNode(color: NSColor(calibratedRed: 137/255, green: 164/255, blue: 170/255,
                                                      alpha: 1.0), size: sceneSize)
        
        let mouthTexture = SKTexture(imageNamed: "mouth/mouth")
        self._mouth = Mouth(texture: mouthTexture)
        
        
        super.init()
        
        //Set the backgroundNodes
        self.addBackgroundColor()
        self.addBoardDesk()
        
        
        self._mouth.observer = self
        self._mouth.addMouthToLayer(backgroundLayer: self,
                                   position: CGPoint(x: boardDesk.position.x + ((boardDesk.size.width - mouthTexture.size().width)/2),
                                                     y: sceneSize.height*0.12))
        
        self.addShelf1()
        self.addShelf2()
        self.addShelf3()
        
        self.addChemicalReaction()
        self.addDirectArrow()
        self.addReverseArrow()
        
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
    
    private func addChemicalReaction() {
        chemicalReaction.anchorPoint = CGPoint(x: 0, y: 0)
        chemicalReaction.setScale(0.5)
        chemicalReaction.position = CGPoint(x: boardDesk.frame.minX + ((boardDesk.size.width - chemicalReaction.size.width)/2), y: 394)
        chemicalReaction.zPosition = zPositionOfElements.chemicalReaction.rawValue
        chemicalReaction.name = "chemicalReaction"
        
        self.addChild(chemicalReaction)
    }
    
    private func addDirectArrow() {
        directArrow.anchorPoint = CGPoint(x: 0, y: 0)
        directArrow.position = CGPoint(x: chemicalReaction.frame.width*0.63, y: chemicalReaction.frame.height * 1.15)
        directArrow.zPosition = zPositionOfElements.arrows.rawValue
        directArrow.name = "directArrow"
        
        chemicalReaction.addChild(directArrow)
    }
    
    private func addReverseArrow() {
        reverseArrow.anchorPoint = CGPoint(x: 0, y: 0)
        reverseArrow.position = CGPoint(x: chemicalReaction.frame.width*0.63, y: chemicalReaction.frame.height * 0.65)
        reverseArrow.zPosition = zPositionOfElements.arrows.rawValue
        reverseArrow.name = "reverseArrow"
        
        chemicalReaction.addChild(reverseArrow)
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
        upArrow.anchorPoint = CGPoint(x: 0, y: 0)
        upArrow.position = CGPoint(x: pHTitleNode.position.x + (pHTitleNode.position.x*0.05),
                                   y: pHTitleNode.position.y*0.82)
        upArrow.zPosition = zPositionOfElements.chemicalReaction.rawValue
        upArrow.name = "upArrow"
        
        self.addChild(upArrow)
    }
    
    public func addDownArrow() {
        downArrow.anchorPoint = CGPoint(x: 0, y: 0)
        downArrow.position = CGPoint(x: pHTitleNode.position.x + (pHTitleNode.position.x*0.05),
                                   y: pHTitleNode.position.y*0.82)
        downArrow.zPosition = zPositionOfElements.chemicalReaction.rawValue
        downArrow.name = "downArrow"
        
        self.addChild(downArrow)
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
    
    public func changepHLabelNodeAndArrow(increase: Bool) {
        
        if increase {
            downArrow.isHidden = true
            upArrow.isHidden = false
        } else {
            downArrow.isHidden = false
            upArrow.isHidden = true
        }
        
        self.phLabelNode.text = "\(round(self.mouth.currentAcidityLevel*10)/10)"
        
    }
    
}

