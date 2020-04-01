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
//            print(clickedNode.name!)
        }
        
    }
    
    public override func mouseDragged(with event: NSEvent) {
        let location = event.location(in: self)
        
        for clickedNode in nodes(at: location) {
            
            if clickedNode.name == "toothBrush" {
                
                gameLayer.selectedNode = clickedNode as? SKSpriteNode
                gameLayer.moveToothBrush(destiny: location)
                
                if let contactNode = clickedNode.children.first as? SKSpriteNode {
                    
//                    print("Toothbrush position: \(clickedNode.position)")
//                    print("Contact node position: \(contactNode.position)")
                    
                    for tooth in backgroundLayer.mouth.highTeeth {
                        for bacteria in tooth.bacteria {
                            if contactNode.intersects(bacteria) {
                                bacteria.removeFromParent()
                                tooth.bacteria.remove(at: tooth.bacteria.firstIndex(of: bacteria)!)
                            }
                        }
                    }
                    
                    for tooth in backgroundLayer.mouth.lowTeeth {
                        for bacteria in tooth.bacteria {
                            if contactNode.intersects(bacteria) {
                                bacteria.removeFromParent()
                                tooth.bacteria.remove(at: tooth.bacteria.firstIndex(of: bacteria)!)
                            }
                        }
                    }
                    
                    let bacteriaNodes = nodes(at: contactNode.position).filter { (bacterium) -> Bool in
                        bacterium.name == "bacterium"
                    }
                    
                    if !bacteriaNodes.isEmpty {
                        print(bacteriaNodes)
                    }
                    
                }
                
//                print("x: \(location.x), y: \(location.y)")
            }
            
        }
    }
    
    public override func mouseUp(with event: NSEvent) {
        gameLayer.moveToothBrushToInitialPosition(initialPosition: hudLayer.toothBrush.initialPosition)
    }
    
    public override func mouseMoved(with event: NSEvent) {
        
    }
    
    public override func update(_ currentTime: TimeInterval) {
        
        
    }
    
}


