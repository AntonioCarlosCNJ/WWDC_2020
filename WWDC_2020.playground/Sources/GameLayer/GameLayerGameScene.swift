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
    public init(mouth: Mouth) {
        super.init()
        
        self.delegate = mouth
        
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
        }
    }
    
    public func cleanTeeth(mouth: Mouth) {
        
        if let contactNode = selectedNode?.children.first as? SKSpriteNode {
            
            for tooth in mouth.highTeeth {
                for bacterium in tooth.bacteria {
                    if contactNode.intersects(bacterium) {
                        tooth.removeBacteriaFromTooth(bacterium)
                        mouth.bacteriaAmount -= 1
                        if currentSpeedReprodution < MAX_REPRODUCTION_SPEED {
                            currentSpeedReprodution += INCREASE_SPEED_REPRODUCTION_PER_BACTERIUM
                        }
                    }
                }
            }
            
            for tooth in mouth.lowTeeth {
                for bacterium in tooth.bacteria {
                    if contactNode.intersects(bacterium) {
                        tooth.removeBacteriaFromTooth(bacterium)
                        mouth.bacteriaAmount -= 1
                        if currentSpeedReprodution < MAX_REPRODUCTION_SPEED {
                            currentSpeedReprodution += INCREASE_SPEED_REPRODUCTION_PER_BACTERIUM
                        }
                    }
                }
            }
            
        }
    }
    
}
