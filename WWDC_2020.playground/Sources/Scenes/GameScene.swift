import SpriteKit

public class GameScene: SKScene {
    
    private var backgroundScene: BackgroundLayerGameScene!
    
    public override func didMove(to view: SKView) {
        
        self.backgroundScene = BackgroundLayerGameScene(sceneSize: self.size)
        self.addChild(self.backgroundScene)
    }
    
}


