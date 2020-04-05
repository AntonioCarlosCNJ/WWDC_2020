import SpriteKit

public protocol GameLayerGameSceneDelegate: class {
    
    func reproduceBacteriaInTeeth()
    
}

public class GameLayerGameScene: SKNode {
    
    //Attributes
    private var currentSpeedReprodution: TimeInterval = MIN_REPRODUCTION_SPEED {
        didSet {
            self.createActionToReproduceBacteria(speedReproduction: self.currentSpeedReprodution)
//            print(self.currentSpeedReprodution)
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
                loopThroughTheTeeth(teeth: mouth.highTeeth, contactNode: contactNode, mouth: mouth)
            } else {
                loopThroughTheTeeth(teeth: mouth.lowTeeth, contactNode: contactNode, mouth: mouth)
            }
        }
    }
    
    private func loopThroughTheTeeth(teeth: [Tooth], contactNode: SKSpriteNode, mouth: Mouth) {
        for tooth in teeth {
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
    
    public func duplicateItemNode(itemNode: SKSpriteNode, name: String) {
        selectedNode = SKSpriteNode(texture: itemNode.texture)
        selectedNode?.position = itemNode.position
        selectedNode?.zPosition = itemNode.zPosition
        selectedNode?.anchorPoint = itemNode.anchorPoint
        selectedNode?.setScale(0.15)
        selectedNode?.name = name
        self.addChild(selectedNode!)
    }
    
    public func moveItemNode(destiny: CGPoint) {
        if let itemNode = selectedNode {
            itemNode.position = destiny
        }
    }
    
    public func dropItemNodeIntoMouth(mouth: Mouth, item: Item) {
        if let itemNode = selectedNode {
            
            if itemNode.intersects(mouth.node) {
                itemNode.removeFromParent()
                
                if itemNode.name == "sodaSelected" {
                    let drinkSound = SKAction.playSoundFileNamed("Sound_Effects/drinking_sound.mp4", waitForCompletion: true)
                    self.run(drinkSound)
                } else if itemNode.name == "sandwichSelected" {
                    let eatSound = SKAction.playSoundFileNamed("Sound_Effects/eating_sound", waitForCompletion: true)
                    self.run(eatSound)
                }
                
                if self.currentSpeedReprodution > MIN_REPRODUCTION_SPEED {
                    if (self.currentSpeedReprodution + item.speedReproduction!) < MIN_REPRODUCTION_SPEED {
                        self.currentSpeedReprodution = MIN_REPRODUCTION_SPEED
                    } else {
                        self.currentSpeedReprodution += item.speedReproduction!
                    }
                }
            } else {
                itemNode.removeFromParent()
            }
            
            selectedNode = nil
            
        }
    }
    
    private func createActionToDirectionOfReaction(directArrow: SKSpriteNode, reverseArrow: SKSpriteNode, currentAcidityLevel: Double, increase: Bool) {
        let pulseAction = SKAction.sequence([SKAction.scale(to: 0.7, duration: 0.5),SKAction.scale(to: 0.5, duration: 0.5)])
        
        if increase {
            
            directArrow.removeAllActions()
            directArrow.texture = SKTexture(imageNamed: "Main_Reaction/direct")
            directArrow.setScale(0.5)
            
            reverseArrow.texture = SKTexture(imageNamed: "Main_Reaction/reverse_active")
            if !reverseArrow.hasActions() {
                reverseArrow.run(SKAction.repeatForever(pulseAction))
            }
        } else if currentAcidityLevel < MIN_GOOD_ACIDITY_LEVEL {
            
            reverseArrow.removeAllActions()
            reverseArrow.texture = SKTexture(imageNamed: "Main_Reaction/reverse")
            reverseArrow.setScale(0.5)

            directArrow.texture = SKTexture(imageNamed: "Main_Reaction/direct_active")
            if !directArrow.hasActions() {
                directArrow.run(SKAction.repeatForever(pulseAction))
            }
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
        
        createActionToDirectionOfReaction(directArrow: backgroundLayer.directArrow,
                                          reverseArrow: backgroundLayer.reverseArrow,
                                          currentAcidityLevel: backgroundLayer.mouth.currentAcidityLevel,
                                          increase: increase)
    }
    
    public func logicToChangeColorsOfChemicalReaction(_ backgroundLayer: BackgroundLayerGameScene, didDecrease decrease: Bool) {
        if decrease {
            
            backgroundLayer.productFull.alpha -= PRODUCT_ALPHA_PER_BACTERIUM
            backgroundLayer.product.alpha += PRODUCT_ALPHA_PER_BACTERIUM
            
            backgroundLayer.reagentFull.alpha += REAGENT_ALPHA_PER_BACTERIUM
            backgroundLayer.reagent.alpha -= REAGENT_ALPHA_PER_BACTERIUM
            
        } else {
            
            backgroundLayer.productFull.alpha += PRODUCT_ALPHA_PER_BACTERIUM
            backgroundLayer.product.alpha -= PRODUCT_ALPHA_PER_BACTERIUM
            
            backgroundLayer.reagentFull.alpha -= REAGENT_ALPHA_PER_BACTERIUM
            backgroundLayer.reagent.alpha += REAGENT_ALPHA_PER_BACTERIUM
            
            print("Product Full: \(backgroundLayer.productFull.alpha)")
            print("Product: \(backgroundLayer.product.alpha)")
            print("Reagent Full: \(backgroundLayer.reagentFull.alpha)")
            print("Reagent: \(backgroundLayer.reagent.alpha)")
            
        }
    }
    
    
    
}
