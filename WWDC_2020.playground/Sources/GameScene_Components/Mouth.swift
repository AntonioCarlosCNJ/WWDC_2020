import SpriteKit

public class Mouth {
    
    //Attributes
    private var node: SKSpriteNode
    private var acidityLevel: CGFloat = 7.0
    private var highTeeth: [Tooth] = []
    private var lowTeeth: [Tooth] = []
    
    
    //Initializers
    public init(texture: SKTexture) {
        node = SKSpriteNode(texture: texture)
        
        node.name = "mouth"
        node.anchorPoint = CGPoint(x: 0, y: 0)
        node.zPosition = zPositionBackgroundLayer.mouth.rawValue
        
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
            highTeeth.append(Tooth(name: "highTooth\(i)", image: "teeth/high_teeth_\(i)"))
        }
        
        highTeeth[0].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 192, y: 193))
        highTeeth[1].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 185, y: 197))
        highTeeth[2].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 153, y: 203))
        highTeeth[3].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 111, y: 205))
        highTeeth[4].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 1, y: 193))
        highTeeth[5].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 6, y: 198))
        highTeeth[6].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 24, y: 203))
        highTeeth[7].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 60, y: 205))
        
    }
    
    private func createLowTeeth() {
        
        for i in 1...8 {
            lowTeeth.append(Tooth(name: "lowTooth\(i)", image: "teeth/low_teeth_\(i)"))
        }
        
        lowTeeth[0].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 184, y: 85))
        lowTeeth[1].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 178, y: 67))
        lowTeeth[2].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 153, y: 54))
        lowTeeth[3].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 110, y: 49))
        lowTeeth[4].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 11, y: 83))
        lowTeeth[5].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 18, y: 67))
        lowTeeth[6].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 35, y: 54))
        lowTeeth[7].addToothToMouth(mouthNode: self.node, position: CGPoint(x: 68, y: 48))
        
    }
    
    
    
}

