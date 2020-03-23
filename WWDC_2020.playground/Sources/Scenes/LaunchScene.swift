import Foundation
import SpriteKit

public protocol LaunchSceneDelegate: class {
    func navigateToNextScene()
}

public class LaunchScene: SKScene {
    
    public weak var launchSceneDelegate: LaunchSceneDelegate?
    
    private var hudLayer: HudLayerLaunchScene!
    private var gameLayer: GameLayerLaunchScene!
    private var backgroundLayer: BackgroundLayerLaunchScene!
    
    public override func didMove(to view: SKView) {
        
        self.backgroundLayer = BackgroundLayerLaunchScene(sceneSize: self.size)
        self.addChild(self.backgroundLayer)
        
        self.hudLayer = HudLayerLaunchScene(sceneSize: self.size)
        self.addChild(self.hudLayer)
        
        self.gameLayer = GameLayerLaunchScene()
        self.addChild(self.gameLayer)
        
    }
    
    public override func mouseDown(with event: NSEvent) {
        let location = event.location(in: self)
        let touchedNodes = self.nodes(at: location)
        print(touchedNodes.first?.name)
        
        if touchedNodes.first?.name == "playButton" || touchedNodes.first?.name == "playButtonText" {
            self.gameLayer.animatePlayButton(playButton: touchedNodes.first!) {
                self.launchSceneDelegate?.navigateToNextScene()
            }
        }
        
    }
    
}

