import SpriteKit

public class HudLayerLaunchScene: SKNode {
    
    //Attributes
    private var sceneSize: CGSize!
    
    private var playButton: SKSpriteNode!
    private var playButtonText: SKLabelNode!
    
    //Initializers
    public init(sceneSize: CGSize) {
        super.init()
        
        //Set scene size
        self.sceneSize = sceneSize
        
        //Adding play button to scene
        self.addPlayButtonToScene()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //Methods
    private func addPlayButtonToScene() {
        self.playButton = SKSpriteNode(color: .purple, size: CGSize(width: sceneSize.width * 0.25,
                                                                 height: sceneSize.height * 0.1))
        self.playButton.name = "playButton"
        self.position = CGPoint(x: self.sceneSize.width/2, y: self.sceneSize.height/2)
        
        self.addChild(self.playButton)
        
        self.addPlayButtonTextToPlayButtonNode()
    }
    
    private func addPlayButtonTextToPlayButtonNode() {
        self.playButtonText = SKLabelNode(text: "Play")
        self.playButtonText.color = .white
        self.playButtonText.name = "playButtonText"
        
        self.playButtonText.position = CGPoint(x: 0, y: self.playButton.size.height/4 * -1)
        
        self.playButton.addChild(self.playButtonText)
    }
    
    
}

