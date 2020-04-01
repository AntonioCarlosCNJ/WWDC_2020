import SpriteKit

public protocol GameLayerGameSceneDelegate: class {
    
    func reproduceBacteriaInTeeth()
    
}

public class GameLayerGameScene: SKNode {
    
    //Attributes
    private var currentSpeedReprodution: TimeInterval = 3.0 {
        didSet {
            self.createActionToReproduceBacteria(speedReproduction: self.currentSpeedReprodution)
        }
    }
    
    public weak var delegate: GameLayerGameSceneDelegate?
    
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
    
}
