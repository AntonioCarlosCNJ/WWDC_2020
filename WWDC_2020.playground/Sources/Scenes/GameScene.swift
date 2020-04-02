import SpriteKit

public class GameScene: SKScene {
    
    private var backgroundLayer: BackgroundLayerGameScene
    private var hudLayer: HudLayerGameScene
    private var gameLayer: GameLayerGameScene
    
    public override init(size: CGSize) {
        self.backgroundLayer = BackgroundLayerGameScene(sceneSize: size)
        self.hudLayer = HudLayerGameScene(sceneSize: size)
        self.gameLayer = GameLayerGameScene()

        super.init(size: size)
        
        gameLayer.delegate = backgroundLayer.mouth
        backgroundLayer.delegate = gameLayer
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
                
                gameLayer.duplicateSodaNode(sodaNode: clickedNode as! SKSpriteNode)
                
            }
        }
        
    }
    
    public override func mouseDragged(with event: NSEvent) {
        let location = event.location(in: self)
        
        for clickedNode in nodes(at: location) {
            
            if clickedNode.name == "toothBrush" {
                
                gameLayer.selectedNode = clickedNode as? SKSpriteNode
                gameLayer.moveToothBrush(destiny: location)
                gameLayer.cleanTeeth(mouth: backgroundLayer.mouth)
                
            }
            
            if clickedNode.name == "sodaSelected" {
                
                gameLayer.moveSodaNode(destiny: location)
                
            }
            
        }
    }
    
    public override func mouseUp(with event: NSEvent) {
        if gameLayer.selectedNode?.name == "toothBrush" {
            gameLayer.moveToothBrushToInitialPosition(initialPosition: hudLayer.toothBrush.initialPosition)
        }
        if gameLayer.selectedNode?.name == "sodaSelected" {
            gameLayer.dropSodaNodeIntoMouth(mouth: backgroundLayer.mouth, soda: hudLayer.soda)
        }
        
        
    }
    
    public override func update(_ currentTime: TimeInterval) {
        
        
    }
    
}


