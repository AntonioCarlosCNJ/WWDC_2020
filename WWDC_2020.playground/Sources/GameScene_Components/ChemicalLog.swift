import SpriteKit

public class ChemicalLog {
    
    //Attributes
    public var reagent = SKSpriteNode(imageNamed: "Main_Reaction/reagentLog")
    public var productOne = SKSpriteNode(imageNamed: "Main_Reaction/productLog_1")
    public var productTwo = SKSpriteNode(imageNamed: "Main_Reaction/productLog_2")
    public var productThree = SKSpriteNode(imageNamed: "Main_Reaction/productLog_3")
    
    //Initializers
    public init() {
        self.createReagent()
        self.createProductOne()
        self.createProductTwo()
        self.createProductThree()
    }
    
    //Methods
    private func createReagent() {
        reagent.name = "reagentLog"
        reagent.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        reagent.zPosition = zPositionOfElements.chemicalReaction.rawValue
        
        reagent.alpha = .zero
    }
    
    private func createProductOne() {
        productOne.name = "productOneLog"
        productOne.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        productOne.zPosition = zPositionOfElements.chemicalReaction.rawValue
        
        productOne.alpha = .zero
    }
    
    private func createProductTwo() {
        productTwo.name = "productTwoLog"
        productTwo.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        productTwo.zPosition = zPositionOfElements.chemicalReaction.rawValue
        
        productTwo.alpha = .zero
    }
    
    private func createProductThree() {
        productThree.name = "productThreeLog"
        productThree.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        productThree.zPosition = zPositionOfElements.chemicalReaction.rawValue + 1.0
        
        productThree.alpha = .zero
    }
    
    public func addReagentToLayer(_ backgroundLayer: BackgroundLayerGameScene, position: CGPoint) {
        self.reagent.position = position
        backgroundLayer.addChild(self.reagent)
    }
    
    public func addProductOneToLayer(_ backgroundLayer: BackgroundLayerGameScene, position: CGPoint) {
        productOne.position = position
        backgroundLayer.addChild(productOne)
    }
    
    public func addProductTwoToLayer(_ backgroundLayer: BackgroundLayerGameScene, position: CGPoint) {
        productTwo.position = position
        backgroundLayer.addChild(productTwo)
    }
    
    public func addProductThreeToLayer(_ backgroundLayer: BackgroundLayerGameScene, position: CGPoint) {
        productThree.position = position
        backgroundLayer.addChild(productThree)
    }
    
    
    
    
}

