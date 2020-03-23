import SpriteKit

public class GameLayerLaunchScene: SKNode {
    
    //Attributes
    
    //Initializers
    public override init() {
        super.init()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //Methods
    public func animatePlayButton(playButton: SKNode, completionHandler: @escaping () -> Void) {
        let clickAnimate = SKAction.sequence([SKAction.scale(to: 0.9, duration: 0.1),
                                              SKAction.scale(to: 1.0, duration: 0.1)])
        
        //Get the playButton if the press has been occurred in text
        if let playButtonText = playButton as? SKLabelNode {
            playButtonText.parent?.run(clickAnimate, completion: {
                completionHandler()
            })
        } else if let playButton = playButton as? SKSpriteNode {
            playButton.run(clickAnimate, completion: {
                completionHandler()
            })
        }
    }
    
}

