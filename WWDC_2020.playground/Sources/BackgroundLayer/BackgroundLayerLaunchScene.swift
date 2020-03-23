import SpriteKit

public class BackgroundLayerLaunchScene: SKNode {
    
    //Attributes
    private var sceneSize: CGSize!
    
    private var backgroundImage: SKSpriteNode!
    private var backgroundTitle: SKLabelNode!
    
    //Initializers
    public init(sceneSize: CGSize) {
        super.init()
        
        //Set scene size
        self.sceneSize = sceneSize
        
        //Add background to Scene
        self.addBackgroundImageToScene()
        self.addBackgroundTitleToScene()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //Methods
    private func addBackgroundImageToScene() {
        self.backgroundImage = SKSpriteNode(color: .gray, size: self.sceneSize)
        self.backgroundImage.anchorPoint = CGPoint(x: 0, y: 0)
        self.backgroundImage.name = "backgroundImage"
        
        self.addChild(self.backgroundImage)
    }
    
    private func addBackgroundTitleToScene() {
        self.backgroundTitle = SKLabelNode(text: "Title of Game")
        self.backgroundTitle.fontSize = 30
        self.backgroundTitle.name = "backgroundTitle"
        self.backgroundTitle.position = CGPoint(x: self.sceneSize.width/2, y: self.sceneSize.height/2 * 1.4)
        
        self.addChild(self.backgroundTitle)
    }
    
    
    
}

