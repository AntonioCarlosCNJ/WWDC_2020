import SpriteKit

public class BackgroundLayerGameScene: SKNode {
     
    //Attributes
    private var sceneSize: CGSize!
    
    private var backgroundImage: SKSpriteNode!
    
    //Initializers
    public init(sceneSize: CGSize) {
        super.init()
        
        //Set the size of the node
        self.sceneSize = sceneSize
        
        //Set the backgroundImage
        self.addBackgroundImage()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //Methods
    private func addBackgroundImage() {
        self.backgroundImage = SKSpriteNode(color: .headerColor, size: self.sceneSize)
        self.backgroundImage.anchorPoint = CGPoint(x: 0, y: 0)
        
        self.addChild(self.backgroundImage)
    }
    
    
}

