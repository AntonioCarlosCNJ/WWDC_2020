import SpriteKit

public protocol GameLayerGameSceneDelegate: class {
    
    func reproduceBacteriaInTeeth()
    
}

public class GameLayerGameScene: SKNode {
    
    //Attributes
    private var maxReproductionSpeed: CGFloat = 3.0
    private var minReproductionSpeed: CGFloat = 0.4
    private var currentReproductionSpeed: CGFloat = 0.4
    
    private var reproduceBacteria: SKAction
    
    public weak var delegate: GameLayerGameSceneDelegate?
    
    //Initializers
    public init(mouth: Mouth) {
        
        reproduceBacteria = SKAction()
        
        super.init()
        
        self.delegate = mouth
        //Starts the reproduction of bacteria
        reproduceBacteria = self.createActionToReproduceBacteria()
        
        print("Current Speed: \(currentReproductionSpeed)")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("required init coder has not be implemented...")
    }
    
    //Methods
    public func changeReproductionSpeedAndAcidityLevel(item: Item, mouth: Mouth) {
        switch  item.itemType{
            case .accelerant:
                mouth.decreaseAcidityLevel(percentage: item.acidPercentage)
                self.increaseReproductionSpeed(percentage: item.percentage)
            case .retardant:
                mouth.increaseAcidityLevel(percentage: item.acidPercentage)
                self.decreaseReproductionSpeed(percentage: item.percentage)
        }
        reproduceBacteria.speed = currentReproductionSpeed
        print("Current Speed: \(currentReproductionSpeed)")
    }
    
    private func increaseReproductionSpeed(percentage: Int) {
        let percentageFloat = CGFloat(percentage) / 100
        let newReproductionSpeed = currentReproductionSpeed + currentReproductionSpeed * percentageFloat
        
        if newReproductionSpeed > maxReproductionSpeed {
            currentReproductionSpeed = maxReproductionSpeed
        } else {
            currentReproductionSpeed = newReproductionSpeed
        }
    }
    
    private func decreaseReproductionSpeed(percentage: Int) {
        let percentageFloat = CGFloat(percentage) / 100
        let newReproductionSpeed = currentReproductionSpeed - currentReproductionSpeed * percentageFloat
        
        if newReproductionSpeed < minReproductionSpeed {
            currentReproductionSpeed = minReproductionSpeed
        } else {
            currentReproductionSpeed = newReproductionSpeed
        }
    }
    
    private func createActionToReproduceBacteria() -> SKAction {
        let timeToWait = SKAction.wait(forDuration: 2.0)
        let reproduceAction = SKAction.run {
            self.delegate?.reproduceBacteriaInTeeth()
        }
        
        let sequence = SKAction.sequence([timeToWait, reproduceAction])
        
        let repeatForever = SKAction.repeatForever(sequence)
        repeatForever.speed = currentReproductionSpeed
        
        self.run(repeatForever)
        
        return repeatForever
    }
    
}
