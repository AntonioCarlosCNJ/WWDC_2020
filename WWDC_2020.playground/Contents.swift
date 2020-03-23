//: A SpriteKit based Playground

import PlaygroundSupport
import SpriteKit

let coordinator = FirstCoordinator(skView: SKView(frame: NSRect(x: 0, y: 0, width: 700, height: 500)))

coordinator.start()

PlaygroundSupport.PlaygroundPage.current.liveView = coordinator.skView
