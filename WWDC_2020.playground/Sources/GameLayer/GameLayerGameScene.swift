import SpriteKit

public protocol GameLayerGameSceneDelegate: class {
    
    func reproduceBacteriaInTeeth()
    
}

public class GameLayerGameScene: SKNode {
    
    //Attributes
    private var currentSpeedReprodution: TimeInterval = MIN_REPRODUCTION_SPEED {
        didSet {
            self.createActionToReproduceBacteria(speedReproduction: self.currentSpeedReprodution)
            print(self.currentSpeedReprodution)
        }
    }
    
    public weak var delegate: GameLayerGameSceneDelegate?
    
    public var selectedNode: SKSpriteNode?
    
    //Initializers
    public override init() {
        super.init()
        
        self.createActionToReproduceBacteria(speedReproduction: currentSpeedReprodution)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("required init coder has not be implemented...")
    }
    
    //Methods
    
    public func createActionToReproduceBacteria(speedReproduction: TimeInterval) {
        
        //Create the wait action and the reproduce action
        let waitAction = SKAction.wait(forDuration: speedReproduction)
        let reproduceAction = SKAction.run {
            self.delegate?.reproduceBacteriaInTeeth()
        }
        
        //Create the sequence action
        let sequence = SKAction.sequence([waitAction,
                                          reproduceAction])
        
        //Create the repeat forever action
        let repeatForeverAction = SKAction.repeatForever(sequence)
        
        //Remove action for that key
        self.removeAction(forKey: REPRODUCTION_ACTION_KEY)
        
        //Add the action in the gameLayer
        self.run(repeatForeverAction, withKey: REPRODUCTION_ACTION_KEY)
    
    }
    
    public func moveToothBrush(destiny: CGPoint) {
        if let toothBrush = selectedNode {
            toothBrush.position = destiny
        }
    }
    
    public func moveToothBrushToInitialPosition(initialPosition: CGPoint) {
        if let toothBrush = selectedNode {
            toothBrush.position = initialPosition
            selectedNode = nil
        }
    }
    
    public func cleanTeeth(mouth: Mouth) {
        
        if let contactNode = selectedNode?.children.first as? SKSpriteNode {
            
            let mouthLimit: CGFloat = mouth.node.position.y + (mouth.node.size.height/2)
            if selectedNode!.position.y > mouthLimit {
                for tooth in mouth.highTeeth {
                    for bacterium in tooth.bacteria {
                        if contactNode.intersects(bacterium) {
                            let increaseSpeedReproductionPerBacterium = (MAX_REPRODUCTION_SPEED - currentSpeedReprodution) / Double(mouth.bacteriaAmount)
                            tooth.removeBacteriaFromTooth(bacterium)
                            mouth.bacteriaAmount -= 1
                            if currentSpeedReprodution < MAX_REPRODUCTION_SPEED {
                                currentSpeedReprodution += increaseSpeedReproductionPerBacterium
                            }
                        }
                    }
                }
            } else {
                for tooth in mouth.lowTeeth {
                    for bacterium in tooth.bacteria {
                        if contactNode.intersects(bacterium) {
                            let increaseSpeedReproductionPerBacterium = (MAX_REPRODUCTION_SPEED - currentSpeedReprodution) / Double(mouth.bacteriaAmount)
                            tooth.removeBacteriaFromTooth(bacterium)
                            mouth.bacteriaAmount -= 1
                            if currentSpeedReprodution < MAX_REPRODUCTION_SPEED {
                                currentSpeedReprodution += increaseSpeedReproductionPerBacterium
                            }
                        }
                    }
                }
            }
        }
    }
    
    public func duplicateSodaNode(sodaNode: SKSpriteNode) {
        selectedNode = SKSpriteNode(texture: sodaNode.texture)
        selectedNode?.position = sodaNode.position
        selectedNode?.zPosition = sodaNode.zPosition
        selectedNode?.anchorPoint = sodaNode.anchorPoint
        selectedNode?.setScale(0.15)
        selectedNode?.name = "sodaSelected"
        self.addChild(selectedNode!)
    }
    
    public func moveSodaNode(destiny: CGPoint) {
        if let sodaNode = selectedNode {
            sodaNode.position = destiny
        }
    }
    
    public func dropSodaNodeIntoMouth(mouth: Mouth, soda: Soda) {
        if let sodaNode = selectedNode {
            
            if sodaNode.intersects(mouth.node) {
                sodaNode.removeFromParent()
                let drinkSound = SKAction.playSoundFileNamed("Sound_Effects/drinking_sound.mp4", waitForCompletion: true)
                self.run(drinkSound)
                
                if self.currentSpeedReprodution > MIN_REPRODUCTION_SPEED {
                    if (self.currentSpeedReprodution + soda.speedReproduction!) < MIN_REPRODUCTION_SPEED {
                        self.currentSpeedReprodution = MIN_REPRODUCTION_SPEED
                    } else {
                        self.currentSpeedReprodution += soda.speedReproduction!
                    }
                }
            } else {
                sodaNode.removeFromParent()
            }
            
            selectedNode = nil
            
        }
    }
    
}

extension GameLayerGameScene: BackgroundLayerDelegate {
    
    public func logicToMakeChangeOfAcidityLevel(_ backgroundLayer: BackgroundLayerGameScene, didIncrease increase: Bool) {
        if increase {
            backgroundLayer.downArrow.isHidden = true
            backgroundLayer.upArrow.isHidden = false
        } else {
            backgroundLayer.downArrow.isHidden = false
            backgroundLayer.upArrow.isHidden = true
        }
        
        backgroundLayer.phLabelNode.text = "\(round(backgroundLayer.mouth.currentAcidityLevel*10)/10)"
    }
    
}
