import SpriteKit

public class ChemicalLog {
    
    //Attributes
    public var reagent = SKSpriteNode(imageNamed: REAGENT_TX)
    public var productOne = SKSpriteNode(imageNamed: PRODUCT_ONE_TX)
    public var productTwo = SKSpriteNode(imageNamed: PRODUCT_TWO_TX)
    public var productThree = SKSpriteNode(imageNamed: PRODUCT_THREE_TX)
    
    //Initializers
    public init() {
        self.createReagent()
        self.createProductOne()
        self.createProductTwo()
        self.createProductThree()
    }
    
    //Methods
    
    /**
     This method create the reagent log to chemical reaction
     */
    private func createReagent() {
        reagent.setScale(0.5)
        reagent.name = REAGENT_NAME
        reagent.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        reagent.zPosition = zPositionBackgroundLayer.chemical.rawValue
        
        reagent.alpha = .zero
    }
    
    /**
    This method create the product one log to chemical reaction
    */
    private func createProductOne() {
        productOne.setScale(0.5)
        productOne.name = PRODUCT_ONE_NAME
        productOne.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        productOne.zPosition = zPositionBackgroundLayer.chemical.rawValue
        
        productOne.alpha = .zero
    }
    
    /**
    This method create the product two log to chemical reaction
    */
    private func createProductTwo() {
        productTwo.setScale(0.5)
        productTwo.name = PRODUCT_TWO_NAME
        productTwo.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        productTwo.zPosition = zPositionBackgroundLayer.chemical.rawValue
        
        productTwo.alpha = .zero
    }
    
    /**
    This method create the product three log to chemical reaction
    */
    private func createProductThree() {
        productThree.setScale(0.5)
        productThree.name = PRODUCT_THREE_NAME
        productThree.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        productThree.zPosition = zPositionBackgroundLayer.chemical.rawValue
        
        productThree.alpha = .zero
    }
    
    /**
     This method add the reagent log to background layer
     */
    public func addReagentToLayer(_ backgroundLayer: BackgroundLayerGameScene, position: CGPoint) {
        self.reagent.position = position
        backgroundLayer.addChild(self.reagent)
    }
    
    /**
    This method add the product one log to background layer
    */
    public func addProductOneToLayer(_ backgroundLayer: BackgroundLayerGameScene, position: CGPoint) {
        productOne.position = position
        backgroundLayer.addChild(productOne)
    }
    
    /**
    This method add the product two log to background layer
    */
    public func addProductTwoToLayer(_ backgroundLayer: BackgroundLayerGameScene, position: CGPoint) {
        productTwo.position = position
        backgroundLayer.addChild(productTwo)
    }
    
    /**
    This method add the product three log to background layer
    */
    public func addProductThreeToLayer(_ backgroundLayer: BackgroundLayerGameScene, position: CGPoint) {
        productThree.position = position
        backgroundLayer.addChild(productThree)
    }
    
    
    
    
}

