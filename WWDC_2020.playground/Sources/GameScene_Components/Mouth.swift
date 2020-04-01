import SpriteKit

public protocol Observer: class {
    
    func decreaseAcidityLevel()
    
}

public class Mouth {
    
    //Attributes
    private var node: SKSpriteNode
    
    private var currentAcidityLevel: Double = 7.2
    
    private var _highTeeth: [Tooth] = []
    public var highTeeth: [Tooth] {
        get {
            return _highTeeth
        }
    }
    
    private var _lowTeeth: [Tooth] = []
    public var lowTeeth: [Tooth] {
        get {
            return _lowTeeth
        }
    }
    
    public var bacteriaAmount: Int = 0
    
    
    //Initializers
    public init(texture: SKTexture) {
        node = SKSpriteNode(texture: texture)
        
        node.name = "mouth"
        node.anchorPoint = CGPoint(x: 0, y: 0)
        node.zPosition = zPositionOfElements.mouth.rawValue
        
        createHighTeeth()
        createLowTeeth()
    }
    
    //Methods
    public func addMouthToLayer(backgroundLayer: BackgroundLayerGameScene, position: CGPoint) {
        self.node.position = position
        backgroundLayer.addChild(self.node)
    }
    
    private func createHighTeeth() {
        
        for i in 1...8 {
            _highTeeth.append(Tooth(name: "highTooth\(i)", image: "teeth/high_teeth_\(i)"))
            _highTeeth[i-1].observer = self
        }
        
        _highTeeth[0].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 192, y: 193))
        _highTeeth[1].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 185, y: 197))
        _highTeeth[2].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 153, y: 203))
        _highTeeth[3].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 111, y: 205))
        _highTeeth[4].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 1, y: 193))
        _highTeeth[5].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 6, y: 198))
        _highTeeth[6].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 24, y: 203))
        _highTeeth[7].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 60, y: 205))
        
    }
    
    private func createLowTeeth() {
        
        for i in 1...8 {
            _lowTeeth.append(Tooth(name: "lowTooth\(i)", image: "teeth/low_teeth_\(i)"))
            _lowTeeth[i-1].observer = self
        }
        
        _lowTeeth[0].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 184, y: 85))
        _lowTeeth[1].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 178, y: 67))
        _lowTeeth[2].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 153, y: 54))
        _lowTeeth[3].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 110, y: 49))
        _lowTeeth[4].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 11, y: 83))
        _lowTeeth[5].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 18, y: 67))
        _lowTeeth[6].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 35, y: 54))
        _lowTeeth[7].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 68, y: 48))
        
    }
    
}

extension Mouth: GameLayerGameSceneDelegate {
    
    public func reproduceBacteriaInTeeth() {
        if bacteriaAmount < MAX_BACTERIA_AMOUNT {
            for i in 0..<highTeeth.count {
                bacteriaAmount += 2
                highTeeth[i].addBacteriumToTooth()
                lowTeeth[i].addBacteriumToTooth()
            }
            print("Bacteria Amount: \(bacteriaAmount)")
        }
    }
    
}

extension Mouth: Observer {
    
    public func decreaseAcidityLevel() {
        self.currentAcidityLevel -= DECREASE_ACID_LEVEL_PER_BACTERIUM
        print("Current acidity level = \(self.currentAcidityLevel)")
    }
    
}

