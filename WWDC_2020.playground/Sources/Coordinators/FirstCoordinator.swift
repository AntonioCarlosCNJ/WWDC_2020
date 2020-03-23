import Foundation
import SpriteKit

protocol Coordinator: class {
    
    var childCoordinators: [Coordinator] { get set }
    
    init(skView: SKView)
    
    func  start()
}

public class FirstCoordinator: Coordinator {
    
    public var skView: SKView!
    
    var childCoordinators: [Coordinator] = []
    
    public required init(skView: SKView) {
        self.skView = skView
    }
    
    func start() {
        let launchScene = LaunchScene(size: self.skView.frame.size)
        
        launchScene.scaleMode = .resizeFill
        
        self.skView.presentScene(launchScene)
        
        self.skView.showsNodeCount = true
        self.skView.showsFPS = true
    }
    
}

extension FirstCoordinator: LaunchSceneDelegate {
    public func navigateToNextScene() {
        let gameScene = GameScene(size: self.skView.frame.size)
        
        gameScene.scaleMode = .resizeFill
        
        self.skView.presentScene(gameScene, transition: .fade(withDuration: 1))
    }
    
    
}

