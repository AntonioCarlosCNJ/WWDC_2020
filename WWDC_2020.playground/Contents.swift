//: A SpriteKit based Playground



import PlaygroundSupport
import SpriteKit

let skView = SKView(frame: NSRect(x: 0, y: 0, width: 700, height: 500))

let gameScene = GameScene(size: skView.frame.size)

skView.presentScene(gameScene)
skView.showsNodeCount = true
skView.showsFPS = true

PlaygroundSupport.PlaygroundPage.current.liveView = skView

