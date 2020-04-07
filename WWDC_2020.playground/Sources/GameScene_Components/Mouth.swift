import SpriteKit

public protocol Observer: class {
    
    func decreaseAcidityLevel()
    func increaseAcidityLevel()
    
}

public class Mouth {
    
    //Attributes
    private var _node: SKSpriteNode
    public var node: SKSpriteNode {
        get {
            return self._node
        }
    }
    
    private var _currentAcidityLevel: Double = 7.2
    public var currentAcidityLevel: Double {
        get {
            return self._currentAcidityLevel
        }
    }
    
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
    
    public var bacteriaAmount: Int = 0 {
        willSet{
            if _currentAcidityLevel < MIN_GOOD_ACIDITY_LEVEL {
                if newValue > bacteriaAmount {
                    observer?.didChangeBacteryLevel(decrease: false)
                } else {
                    observer?.didChangeBacteryLevel(decrease: true)
                }
            }
        }
    }
    
    public weak var observer: ObserverBackgroundLayer?
    
    
    //Initializers
    public init(texture: SKTexture) {
        _node = SKSpriteNode(texture: texture)
        
        _node.setScale(0.5)
        
        _node.name = MOUTH_NAME
        _node.anchorPoint = CGPoint(x: 0, y: 0)
        _node.zPosition = zPositionBackgroundLayer.mouth.rawValue
        
        createHighTeeth()
        createLowTeeth()
    }
    
    //Methods
    public func addMouthToLayer(backgroundLayer: BackgroundLayerGameScene, position: CGPoint) {
        self._node.position = position
        backgroundLayer.addChild(self._node)
    }
    
    private func createHighTeeth() {
        
        for i in 1...8 {
            _highTeeth.append(Tooth(name: "highTooth\(i)", image: "teeth/high_teeth_\(i)"))
            _highTeeth[i-1].observer = self
        }
        
        _highTeeth[0].addToothToMouth(mouthNode: self._node, position: CGPoint(x: 384, y: 386))
        _highTeeth[1].addToothToMouth(mouthNode: self._node, position: CGPoint(x: 370, y: 394))
        _highTeeth[2].addToothToMouth(mouthNode: self._node, position: CGPoint(x: 306, y: 406))
        _highTeeth[3].addToothToMouth(mouthNode: self._node, position: CGPoint(x: 222, y: 410))
        _highTeeth[4].addToothToMouth(mouthNode: self._node, position: CGPoint(x: 2, y: 386))
        _highTeeth[5].addToothToMouth(mouthNode: self._node, position: CGPoint(x: 12, y: 396))
        _highTeeth[6].addToothToMouth(mouthNode: self._node, position: CGPoint(x: 48, y: 406))
        _highTeeth[7].addToothToMouth(mouthNode: self._node, position: CGPoint(x: 120, y: 410))
        
    }
    
    private func createLowTeeth() {
        
        for i in 1...8 {
            _lowTeeth.append(Tooth(name: "lowTooth\(i)", image: "teeth/low_teeth_\(i)"))
            _lowTeeth[i-1].observer = self
        }
        
        _lowTeeth[0].addToothToMouth(mouthNode: self._node, position: CGPoint(x: 368, y: 170))
        _lowTeeth[1].addToothToMouth(mouthNode: self._node, position: CGPoint(x: 356, y: 134))
        _lowTeeth[2].addToothToMouth(mouthNode: self._node, position: CGPoint(x: 306, y: 108))
        _lowTeeth[3].addToothToMouth(mouthNode: self._node, position: CGPoint(x: 220, y: 98))
        _lowTeeth[4].addToothToMouth(mouthNode: self._node, position: CGPoint(x: 22, y: 166))
        _lowTeeth[5].addToothToMouth(mouthNode: self._node, position: CGPoint(x: 36, y: 134))
        _lowTeeth[6].addToothToMouth(mouthNode: self._node, position: CGPoint(x: 70, y: 108))
        _lowTeeth[7].addToothToMouth(mouthNode: self._node, position: CGPoint(x: 136, y: 96))
        
    }
    
}

extension Mouth: GameLayerGameSceneDelegate {
    
    public func reproduceBacteriaInTeeth() {
        if bacteriaAmount < MAX_BACTERIA_AMOUNT {
            for i in 0..<highTeeth.count {
                highTeeth[i].addBacteriumToTooth { () in
                    bacteriaAmount += 1
                }
                lowTeeth[i].addBacteriumToTooth { () in
                    bacteriaAmount += 1
                }
//                self.observer?.didChangeBacteryLevel(increase: true)
            }
//            print("Bacteria Amount: \(bacteriaAmount)")
        }
    }
    
}

extension Mouth: Observer {
    
    public func decreaseAcidityLevel() {
        self._currentAcidityLevel -= ACID_LEVEL_PER_BACTERIUM
        self.observer?.didChangeAcidityLevel(increase: false)
//        print("Current acidity level = \(self._currentAcidityLevel)")
    }
    
    public func increaseAcidityLevel() {
        self._currentAcidityLevel += ACID_LEVEL_PER_BACTERIUM
        self.observer?.didChangeAcidityLevel(increase: true)
    }
    
}

