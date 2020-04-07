/*:
 
 # What is chemystry?
 
 Atoms, molecules, complex formulas, this is the foundation of chemistry, but for those who think that this is only a matter of research in the laboratory, they were wrong!
 
 Chemistry is present in our daily lives more than we think. Our body is made up entirely of atoms and molecules. Everything that surrounds us is also composed of several elements, but in different states and compositions. In short, everything around you and inside you works and exists because of chemistry!
 
 In chemistry there are several important concepts, but two of them are fundamental to understand how it works. First, atoms, which are the smallest particles of anything that exists and when I say smaller, they are even smaller. For you to understand how small they are, a single grain of sand is made up of billions of atoms. Second, it is the molecules, which are sets of atoms, and even that set is extremely small.
 
 These atoms and molecules mix, react and cause chemical reactions, a process that happens all the time in our universe and everyday. And in this project you will be able to see a chemical process that occurs every day inside our mouth !!
 
 # Chemical Process in Human Mouth
 
 Você sabe o que acontece quando nós nos alimentamos? Já se perguntou porque nós temos que manter a higiene bucal em dia? Vem comigo que eu te explico!
 
 Nossa boca é um ambiente muito propício à proliferação de bactérias, devido a sua temperatura em torno de 36˚C, ela está sempre úmida e possui um alto fluxo de nutrientes devido a nossa alimentação. Quando comemos ou bebemos, esses alimentos possuem açúcares que ficam depositados na nossa boca e esses açúcares servem de alimento para as bactérias que aumentam a sua proliferação. Resumindo, quanto mais açúcares o alimento tiver mais irá aumentar a velocidade de reprodução das bactérias.
 
 Com base nessa explicação, você sabe que quanto mais tempo ficamos sem escovar nossos dentes depois de fazer alguma refeição, mais bactérias teremos na nossa boca e isso poderá gerar a famosa cárie. Mas qual o processo químico que ocorre até gerar a cárie?
 
 O processo químico que gera a cárie é chamado de **Desmineralização** onde o principal componente do esmalte dentário se dissolve pelo nível de acidez da boca diminuir conforme a proliferação de bactérias aumenta.
 
 Porém esse processo pode ser revertido desde que nós mantemos uma higiene bucal constante, mesmo quando nós passamos um bom tempo sem nos alimentarmos. Agora você irá poder ver na prática como ocorre esse processo químico.
 */



import PlaygroundSupport
import SpriteKit

let skView = SKView(frame: NSRect(x: 0, y: 0, width: 700, height: 500))

let gameScene = GameScene(size: skView.frame.size)

skView.presentScene(gameScene)
//skView.showsNodeCount = true
//skView.showsFPS = true

PlaygroundSupport.PlaygroundPage.current.liveView = skView
