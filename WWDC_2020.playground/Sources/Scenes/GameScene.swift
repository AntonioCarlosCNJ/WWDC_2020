import SpriteKit

public class GameScene: SKScene {
    
    private var backgroundLayer: BackgroundLayerGameScene
    private var hudLayer: HudLayerGameScene
    private var gameLayer: GameLayerGameScene
    
    public override init(size: CGSize) {
        self.backgroundLayer = BackgroundLayerGameScene(sceneSize: size)
        self.hudLayer = HudLayerGameScene(sceneSize: size)
        self.gameLayer = GameLayerGameScene(mouth: backgroundLayer.mouth)

        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didMove(to view: SKView) {
        self.addChild(self.backgroundLayer)
        self.addChild(self.hudLayer)
        self.addChild(self.gameLayer)
    }
    
    public override func mouseDown(with event: NSEvent) {
        
        let location = event.location(in: self)
        
        for clickedNode in nodes(at: location) {
            
            if clickedNode.name == "soda" {
                gameLayer.changeReproductionSpeedAndAcidityLevel(item: hudLayer.soda, mouth: backgroundLayer.mouth)
            }
            
            if clickedNode.name == "sandwich" {
                gameLayer.changeReproductionSpeedAndAcidityLevel(item: hudLayer.sandwich, mouth: backgroundLayer.mouth)
            }
            
            if clickedNode.name == "toothbrush" {
                gameLayer.changeReproductionSpeedAndAcidityLevel(item: hudLayer.toothBrush, mouth: backgroundLayer.mouth)
            }
            
        }
        
    }
    
    public override func mouseDragged(with event: NSEvent) {
        let location = event.location(in: self)
        
        for clickedNode in nodes(at: location) {
            
            if clickedNode.name == "soda" {
                
                print("x: \(location.x), y: \(location.y)")
                
                clickedNode.position.x = location.x * 1.05
                clickedNode.position.y = location.y * 1.05
                
            }
            
        }
    }
    
    public override func mouseMoved(with event: NSEvent) {
        
    }
    
    public override func update(_ currentTime: TimeInterval) {
        
        
    }
    
}


