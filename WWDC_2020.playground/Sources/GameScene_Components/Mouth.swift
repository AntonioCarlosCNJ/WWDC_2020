import SpriteKit

public class Mouth {
    
    //Attributes
    private var node: SKSpriteNode
    
    private var maxAcidityLevel: CGFloat = 7.2
    private var minAcidityLevel: CGFloat = 4.5
    private var currentAcidityLevel: CGFloat = 6.8
    
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
    
    public func decreaseAcidityLevel(percentage: Int) {
        let percentageFloat = CGFloat(percentage)/100
        let newAcidityLevel = currentAcidityLevel - currentAcidityLevel * percentageFloat
        
        if  newAcidityLevel > minAcidityLevel {
            currentAcidityLevel = newAcidityLevel
        } else {
            currentAcidityLevel = minAcidityLevel
        }
        
        print("Current pH: \(currentAcidityLevel)")
    }
    
    public func increaseAcidityLevel(percentage: Int) {
        let percentageFloat = CGFloat(percentage)/100
        let newAcidityLevel = currentAcidityLevel + currentAcidityLevel * percentageFloat
        
        if  newAcidityLevel < maxAcidityLevel {
            currentAcidityLevel = newAcidityLevel
        } else {
            currentAcidityLevel = maxAcidityLevel
        }
        
        print("Current pH: \(currentAcidityLevel)")
    }
    
}

extension Mouth: GameLayerGameSceneDelegate {
    
    public func reproduceBacteriaInTeeth() {
        for i in 0..<highTeeth.count {
            highTeeth[i].addBacteriumToTooth()
            lowTeeth[i].addBacteriumToTooth()
        }
    }
    
}

