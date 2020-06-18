import SpriteKit

public protocol GameLayerGameSceneDelegate: class {
    
    func reproduceBacteriaInTeeth()
    
}

public class GameLayerGameScene: SKNode {
    
    //Attributes
    
    private var currentSpeedReprodution: TimeInterval = MIN_REPRODUCTION_SPEED {
        didSet {
            self.createActionToReproduceBacteria(speedReproduction: self.currentSpeedReprodution)
        }
    }
    
    public weak var delegate: GameLayerGameSceneDelegate?
    
    public var selectedNode: SKSpriteNode?
    
    public var clonedLogNode: SKSpriteNode?
    
    //Initializers
    public override init() {
        super.init()
        
        //Creates the method to reproduce bacteria in mouth
        self.createActionToReproduceBacteria(speedReproduction: currentSpeedReprodution)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("required init coder has not be implemented...")
    }
    
    //Methods
    
    /**
     This method creates the action to reproduce bacteria, waiting the time of currentSpeedReproduction
     
     - Parameter speedReproduction: currentSpeedReproduction of bacteria
     */
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
    
    /**
     This method moves back the toothbrush to initial position
     when the user deselects the toothbrush
     
     - Parameter initialPosition: initialPosition of toothbrush
     */
    public func moveToothBrushToInitialPosition(initialPosition: CGPoint) {
        if let toothBrush = selectedNode {
            toothBrush.position = initialPosition
            selectedNode = nil
        }
    }
    
    /**
    This method cleans the teeth that toothbrush is intersecting
     
     - Parameter mouth: this parameter is to get the teeth of the mouth
     */
    public func cleanTeeth(mouth: Mouth) {
        //Get the contact node
        if let contactNode = selectedNode?.children.first as? SKSpriteNode {
            //Get the middleY position of the mouth
            let mouthLimit: CGFloat = mouth.node.position.y + (mouth.node.size.height/2)
            //Verify if the toothbrush is above or below to the mouthLimit
            if selectedNode!.position.y > mouthLimit {
                //If the toothbrush is above than clean the high teeth
                loopThroughTheTeeth(teeth: mouth.highTeeth, contactNode: contactNode, mouth: mouth)
            } else {
                //Else clean the low teeth
                loopThroughTheTeeth(teeth: mouth.lowTeeth, contactNode: contactNode, mouth: mouth)
            }
        }
    }
    
    /**
     This method loop through the teeth to remove bacteria from then
     
     - Parameter teeth: array of tooth, can be high teeth or low teeth
     - Parameter contactNode: contact node of the toothbrush
     - Parameter mouth: mouth class to update the bacteria amount
     */
    private func loopThroughTheTeeth(teeth: [Tooth], contactNode: SKSpriteNode, mouth: Mouth) {
        //Loop throught teeth
        for tooth in teeth {
            //Loop throught bacteria in tooth
            for bacterium in tooth.bacteria {
                //Verify if the contact node of toothbrush intersects in bacterium
                if contactNode.intersects(bacterium) {
                    //Create the increase speed reproduction based on the bacteriaAmount
                    let increaseSpeedReproductionPerBacterium = (MAX_REPRODUCTION_SPEED - currentSpeedReprodution) / Double(mouth.bacteriaAmount)
                    //Remove the bacteria of tooth
                    tooth.removeBacteriaFromTooth(bacterium)
                    //Decrease the bacteria amount
                    mouth.bacteriaAmount -= 1
                    /*Verify if the currentSpeedReproduction it's less than
                     the MAX_SPEED_REPRODUCTION because the speed cannot be higher than the max*/
                    if currentSpeedReprodution < MAX_REPRODUCTION_SPEED {
                        currentSpeedReprodution += increaseSpeedReproductionPerBacterium
                    }
                }
            }
        }
    }
    
    /**
     This method duplicate the interactable item (sandwich or soda) to interact with mouth
     
     Duplicated Variables:
     * texture
     * position
     * zPosition
     * anchorPoint
     * setScale
     * name (+ "selected" suffix)
     
     - Parameter itemNode: node item to duplicate
     */
    public func duplicateItemNode(itemNode: SKSpriteNode){
        selectedNode = SKSpriteNode(texture: itemNode.texture)
        selectedNode?.position = itemNode.position
        selectedNode?.zPosition = itemNode.zPosition
        selectedNode?.anchorPoint = itemNode.anchorPoint
        selectedNode?.setScale(0.15)
        selectedNode?.name = itemNode.name! + SUFFIX_DUPLICATE_ITEM_NODE
        itemNode.parent!.addChild(selectedNode!)
    }
    
    /**
     This method is to move interactable item node to a destiny
     
     - Parameter destiny: the position to move the node
     */
    public func moveItemNode(destiny: CGPoint) {
        if let itemNode = selectedNode {
            itemNode.position = destiny
        }
    }
    
    /**
     This method drop the item node (Soda or sandwich) into the mouth
     
     - Parameter mouth: mouth
     - Parameter item: Item to drop (Soda or sandwich)
     */
    public func dropItemNodeIntoMouth(mouth: Mouth, item: Item) {
        //Verify if exists a selectedNode
        if let itemNode = selectedNode {
            
            //Verify if the itemNode intersects with the mouth
            if itemNode.intersects(mouth.node) {
                
                //Remove the node from parent
                itemNode.removeFromParent()
                
                //Verify if the selectedNode is soda to reproduce the drinking soung
                if itemNode.name == SODA_SELECTED_NAME {
                    let drinkSound = SKAction.playSoundFileNamed(DRINKING_SOUND_EFFECT, waitForCompletion: true)
                    self.run(drinkSound)
                } else if itemNode.name == SANDWICH_SELECTED_NAME { //Else verify if the selected is sandwich to reproduce the eating sound
                    let eatSound = SKAction.playSoundFileNamed(EATING_SOUND_EFFECT, waitForCompletion: true)
                    self.run(eatSound)
                }
                
                //Verify if the current speed reproduction is higher than MIN_REPRODUCTION_SPEED
                if self.currentSpeedReprodution > MIN_REPRODUCTION_SPEED {
                    /*Verify if the sum of currentSpeedReproduction it's lower than the MIN_REPRODUCTION_SPEED
                     because if it's, attribute the currentSpeedReproduction to the MIN_REPRODUCTION_SPEED*/
                    if (self.currentSpeedReprodution + item.speedReproduction!) < MIN_REPRODUCTION_SPEED {
                        self.currentSpeedReprodution = MIN_REPRODUCTION_SPEED
                    } else { // If not diminute the speed reproduction to be fastest
                        self.currentSpeedReprodution += item.speedReproduction!
                    }
                }
            } else { // if not just remove from parent and do nothing
                itemNode.removeFromParent()
            }
            
            //Attributes the selectedNode to nil because nothing is selected anymore
            selectedNode = nil
            
        }
    }
    
    
    /**
     This method create the action to change the direction of main reaction
     
     - Parameter directArrow: direct arrow of the main reaction
     - Parameter reverseArrow: reverse arrow of the main reaction
     - Parameter currentAcidityLevel: the current acidity level of the mouth
     - Parameter increase: shows if the acidity level increased or not
     */
    private func createActionToDirectionOfReaction(directArrow: SKSpriteNode, reverseArrow: SKSpriteNode, currentAcidityLevel: Double, increase: Bool) {
        
        //Creates the pulse action
        let pulseAction = SKAction.sequence([SKAction.scale(to: 0.7, duration: 0.5),SKAction.scale(to: 0.5, duration: 0.5)])
        
        //Verify if the current acidity level increased
        if increase {
            
            //Remove the actions, set the original texture and set the original scale of direct arrow
            directArrow.removeAllActions()
            directArrow.texture = SKTexture(imageNamed: DIRECT_ARROW_TX)
            directArrow.setScale(0.5)
            
            //change the texture of reverse arrow
            reverseArrow.texture = SKTexture(imageNamed: REVERSE_ACTIVE_ARROW_TX)
            //Verify if the reverse arrow does not have actions, if not add the pulse action
            if !reverseArrow.hasActions() {
                reverseArrow.run(SKAction.repeatForever(pulseAction))
            }
        } else if currentAcidityLevel < MIN_GOOD_ACIDITY_LEVEL { //Verify if the currentAcidityLevel is lower than the min good
            
            //Remove the actions, set the original texture and set the original scale of reverse arrow
            reverseArrow.removeAllActions()
            reverseArrow.texture = SKTexture(imageNamed: REVERSE_ARROW_TX)
            reverseArrow.setScale(0.5)

            //change the texture of direct arrow
            directArrow.texture = SKTexture(imageNamed: DIRECT_ACTIVE_ARROW_TX)
            //Verify if the direct arrow does not have actions, if not add the pulse action
            if !directArrow.hasActions() {
                directArrow.run(SKAction.repeatForever(pulseAction))
            }
        }
    }
    
    /**
     This method is to clone an SKSpriteNode to use in the log of chemical reaction
     
     Cloned Variables:
     * texture
     * anchorPoint
     * position
     * name (+ "cloned" suffix)
     * zPosition
     
     - Parameter node: node to clone
     */
    private func cloneSKSpriteNode(node: SKSpriteNode) -> SKSpriteNode {
        let retNode = SKSpriteNode(texture: node.texture)
        retNode.setScale(0.45)
        retNode.anchorPoint = node.anchorPoint
        retNode.position = node.position
        retNode.name = node.name! + SUFFIX_CLONE_CHEMICAL_LOG_NODE
        retNode.zPosition = node.zPosition
        
        if let parent = node.parent {
            parent.addChild(retNode)
        }
        
        return retNode
    }
    
    /**
     This method creates the action to show reagent log of the main reaction
     
     - Parameter reagent: the reagent node to clone
     */
    private func createReagentLogAction(reagent: SKSpriteNode) {
        //Remove all actions and remove from parent before to instantiate a new clonedLogNode
        clonedLogNode?.removeAllActions()
        clonedLogNode?.removeFromParent()
        
        //Instatiate a new clonedLogNode with the reagent node
        self.clonedLogNode = cloneSKSpriteNode(node: reagent)
        //Get the initialYPosition of the node (important to move back to initial position)
        let initialYPosition = self.clonedLogNode!.position.y
        
        //Creates the move and the fade alpha action
        let moveAction = SKAction.moveTo(y: self.clonedLogNode!.position.y*1.4, duration: DURATION_OF_CHEMICAL_LOG)
        let alphaAction = SKAction.fadeAlpha(to: .zero, duration: DURATION_OF_CHEMICAL_LOG)
        
        //Creates the group action to execute at the same time
        let moveFadeAction = SKAction.group([moveAction, alphaAction])
        //Creates the move back action with initialYPosition
        let moveBackAction = SKAction.moveTo(y: initialYPosition, duration: 0.0)
        //Creates the alpha to one action
        let alphaToOneAction = SKAction.fadeAlpha(to: 1.0, duration: 0.0)
        
        //Creates the sequence to run the action
        let sequence = SKAction.sequence([moveFadeAction, moveBackAction, alphaToOneAction])
        
        //Run a repeat forever action with a key
        self.clonedLogNode!.run(SKAction.repeatForever(sequence), withKey: INCREASE_LOG_ACTION_KEY)
    }
    
    private func createProductLogAction(product: SKSpriteNode, textures: [SKTexture]) {
        //Remove all actions and remove from parent before to instantiate a new clonedLogNode
        clonedLogNode?.removeAllActions()
        clonedLogNode?.removeFromParent()
        
        //Instatiate a new clonedLogNode with the product node
        self.clonedLogNode = cloneSKSpriteNode(node: product)
        //Get the initialYPosition of the node (important to move back to initial position)
        let initialYPosition = self.clonedLogNode!.position.y
        
        //Creates the move and the fade alpha action
        let moveAction = SKAction.moveTo(y: self.clonedLogNode!.position.y*1.4, duration: DURATION_OF_CHEMICAL_LOG)
        let alphaAction = SKAction.fadeAlpha(to: .zero, duration: DURATION_OF_CHEMICAL_LOG)
        
        //Creates the group action to execute at the same time
        let moveFadeAction = SKAction.group([moveAction, alphaAction])
        
        //Creates the move back action with initialYPosition
        let moveBackAction = SKAction.moveTo(y: initialYPosition, duration: 0.0)
        //Creates the alpha to one action
        let alphaToOneAction = SKAction.fadeAlpha(to: 1.0, duration: 0.0)
        
        //Creates the group to change the texture of clonedNode (this is important to run the three products of main reaction)
        let setTextureOneAction = SKAction.group([SKAction.resize(toWidth: textures[1].size().width, height: textures[1].size().height, duration: 0.0),
                                                  SKAction.setTexture(textures[1])])
        let setTextureTwoAction = SKAction.group([SKAction.resize(toWidth: textures[2].size().width, height: textures[2].size().height, duration: 0.0),
                                                  SKAction.setTexture(textures[2])])
        let setTextureThreeAction = SKAction.group([SKAction.resize(toWidth: textures[0].size().width, height: textures[0].size().height, duration: 0.0),
                                                    SKAction.setTexture(textures[0])])
        
        //Creates the sequence of execution of action
        let sequence = SKAction.sequence([moveFadeAction, moveBackAction, setTextureOneAction, alphaToOneAction,
                                          moveFadeAction, moveBackAction, setTextureTwoAction, alphaToOneAction,
                                          moveFadeAction, moveBackAction, setTextureThreeAction, alphaToOneAction])
        
        //Run a repeat forever action with a key
        self.clonedLogNode!.run(SKAction.repeatForever(sequence), withKey: DECREASE_LOG_ACTION_KEY)
    }
    
}

extension GameLayerGameScene: BackgroundLayerDelegate {
    
    /**
     This method makes the logic to show chemical log of the main reaction
     
     - Parameter backgroundLayer: the background layer to gerentiate her nodes
     - Parameter chemicalLog: Chemical log of the backgroundLayer
     - Parameter increase: shows if the acidity level increased or not
     */
    public func logicToShowChemicalLog(_ backgroundLayer: BackgroundLayerGameScene, chemicalLog: ChemicalLog, didIncreaseAcidityLevel increase: Bool) {
        
        /*Verify if the current acidity level increased and if the
         clonedLogNode have the action with the decrease log key,
         because if the cloned node has this action, that means the
         acidity level changed his direction
         */
        if increase && self.clonedLogNode?.action(forKey: DECREASE_LOG_ACTION_KEY) != nil{
            
            self.createReagentLogAction(reagent: chemicalLog.reagent)
            
        } else if backgroundLayer.mouth.currentAcidityLevel < MIN_GOOD_ACIDITY_LEVEL && (self.clonedLogNode?.action(forKey: INCREASE_LOG_ACTION_KEY) != nil || self.clonedLogNode == nil) && self.selectedNode == nil{ //the difference here is to verify if the current acidity level is lower than the min_good,
                                                                    //and verify the same if above or if is the first execution of this function and then verify
                                                                    //verify that selectedNode is equal to nil because nothing can be selected.
            
            self.createProductLogAction(product: chemicalLog.productOne, textures: [chemicalLog.productOne.texture!, chemicalLog.productTwo.texture!, chemicalLog.productThree.texture!])
            
        }
        
    }
    
    /**
     This method is to make the logic to change the visual things of the acidity level
     
     - Parameter backgroundLayer: the background layer to gerentiate her nodes
     - Parameter increase: shows if the acidity level increased or not
     */
    public func logicToMakeChangeOfAcidityLevel(_ backgroundLayer: BackgroundLayerGameScene, didIncrease increase: Bool) {
        //if increased, show the up arrow else show the down arrow
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
    
    /**
        This method is to change the colors of the chemical reaction
     - Parameter backgroundLayer: the background layer to gerentiate her nodes
     - Parameter increase: shows if the bacteria amount increased or not
     */
    public func logicToChangeColorsOfChemicalReaction(_ backgroundLayer: BackgroundLayerGameScene, didDecrease decrease: Bool) {
        
        /*If decreased the product full alpha decrease and the product increase,
        and the reagent full increase and the reagent decrease, else run the opposite*/
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
            
        }
    }
    
    
    
}
