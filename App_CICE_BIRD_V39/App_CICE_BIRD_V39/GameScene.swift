//
//  GameScene.swift
//  App_CICE_BIRD_V39
//
//  Created by formador on 21/4/17.
//  Copyright © 2017 formador. All rights reserved.
//

import SpriteKit
import GameplayKit

//SKPhysicsContactDelegate --> Permite colisiones
class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //MARK: - Variables locales
    var background = SKSpriteNode()
    var bird = SKSpriteNode()
    var pipeFinal1 = SKSpriteNode()
    var pipeFinal2 = SKSpriteNode()
    var limitLand = SKNode()
    var timer = Timer()
    
    //- Grupo de colisiones
    //Hay que tener en cuenta que son números binarios
    let birdGroup : UInt32 = 1
    let objectGroup : UInt32 = 2
    let gapGroup : UInt32 = 4
    let movingGroup = SKNode()
    
    //- Grupo de LBL
    var score = 0
    var scoreLBL = SKLabelNode()
    var gameOverLBL = SKLabelNode()
    var gameOver = false
    
    
    
    override func didMove(to view: SKView) {
        
        //Establecemos la vísta como delegada de las físicas
        self.physicsWorld.contactDelegate = self
        
        //Gravedad asociada a las físicas. Se hace menos dura, para que flote un poco
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -5.0)
        
        //Añadir los grupos en movimiento
        self.addChild(movingGroup)
        
        //Pintar en pantalla los objetos
        
        makelimitLand()
        makeBackground()
        makeLabel()
        makeLoopPipe1AndPipe2()
        makeBird()
        
    }
    
    ///Cada vez que se toque la ventana se aumentará la velocidad del pájaro y se subirá su altura
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if(!gameOver){
            //Velocidad de las físicas cuando se toca: Reseteamos la gravedad
            bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            
            //Impulso en cada toque hacia arriba
            bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 70))
        }else{
            resetGame()
        }
    }
    
    ///Función delegada que indica que ha habido un contacto
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == gapGroup ||
            contact.bodyB.categoryBitMask == gapGroup {
            score += 100
            scoreLBL.text = "\(score)"
        }else if !gameOver{
            gameOver = true
            movingGroup.speed = 0
            timer.invalidate()
            makeLabelGameOver()
        }
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
        
    }
    
    
    
    //MARK: - Utils
    ///Posición de la gravedad, se sitúa en el lado inferior de la pantalla
    func makelimitLand(){
        limitLand.position = CGPoint(x: 0, y: -(self.frame.height / 2))
        limitLand.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 1))
        limitLand.physicsBody?.isDynamic = false
        
        //Asignar la máscara para las físicas
        limitLand.physicsBody?.categoryBitMask = objectGroup
        
        limitLand.zPosition = 2
        self.addChild(limitLand)
    }
    
    
    
    
    ///El fondo está divido en tres partes, cada una de las cuales se mueven para generar sensación de movimiento.
    func makeBackground(){
        let backgroundFinal = SKTexture(imageNamed: "bg")
        let moveBackground = SKAction.moveBy(x: -backgroundFinal.size().width, y: 0, duration: 9)
        let replaceBackground = SKAction.moveBy(x: backgroundFinal.size().width, y: 0, duration: 0)
        let moveBackgroundForever = SKAction.repeatForever(SKAction.sequence([moveBackground, replaceBackground]))
        
        for c_imagen in 0..<3{
            background = SKSpriteNode(texture: backgroundFinal)
            background.position = CGPoint(x: -(backgroundFinal.size().width / 2) + (backgroundFinal.size().width * CGFloat(c_imagen)) , y: 0)
            background.zPosition = 1
            background.size.height = self.frame.height
            background.run(moveBackgroundForever)
            self.movingGroup.addChild(background)
        }
        
    }
    
    //Cada determinado tiempo se dedica a mostrar y ocultar las tuberías
    func makeLoopPipe1AndPipe2(){
        
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(makePipeFinal), userInfo: nil, repeats: true)
        
        
        
        
    }
    
    func makePipeFinal(){
        //Espacio de arriba a abajo con el tamaño de 4 pájaros, espacio entre tuberías
        let gapHeight = bird.size.height * 4
        
        //Hasta donde va a estar la tubería, random como máximo de la mitad de la pantalla
        let movementAmount = arc4random_uniform(UInt32(self.frame.height / 2))
        
        //Limitamos las tuberías hasta como máximo estár a 1/4 del borde de la pantalla
        let pipeOffset = CGFloat(movementAmount) - self.frame.height / 4
        
        //Mover la tubería, lo movemos en función del ancho de la pantalla.
        let movePipes = SKAction.moveBy(x: -self.frame.width - 200 , y: 0, duration: TimeInterval(self.frame.width / 200))
        
        //Borrar las imágenes que desaparecen
        let removePipes = SKAction.removeFromParent()
        
        //Secuencia de acciones a realizar
        let moveAndRemovePipes = SKAction.sequence([movePipes, removePipes])
        
        
        //--------------------------
        // Crear PIPE 1
        //--------------------------
        //Crear la textura
        let pipeTexture1 = SKTexture(imageNamed: "pipe1")
        
        //Asignamos la textura al pipe global
        pipeFinal1 = SKSpriteNode(texture: pipeTexture1)
        
        //Posición de la tubería
        pipeFinal1.position = CGPoint(x: (self.frame.width / 2) + (pipeFinal1.size.width/2 ), y: (pipeFinal1.size.height / 2) + (gapHeight / 2) + pipeOffset)
        
        //Damos cuerpo a las físicas de la tubería
        pipeFinal1.physicsBody = SKPhysicsBody(rectangleOf: pipeFinal1.size)
        
        //No se verá afectada por la gravedad
        pipeFinal1.physicsBody?.isDynamic = false
        
        //Indicar el grupo
        pipeFinal1.physicsBody?.categoryBitMask = objectGroup
        
        
        //Se coloca entre la gravedad y el pájaro
        pipeFinal1.zPosition = 4
        
        //Ejecutar la secuencia
        pipeFinal1.run(moveAndRemovePipes)
        
        self.movingGroup.addChild(pipeFinal1)
        
        
        //--------------------------
        // Crear PIPE 2
        //--------------------------
        //Crear la textura
        let pipeTexture2 = SKTexture(imageNamed: "pipe2")
        
        //Asignamos la textura al pipe global
        pipeFinal2 = SKSpriteNode(texture: pipeTexture2)
        
        //Posición de la tubería
        pipeFinal2.position = CGPoint(x: (self.frame.width / 2) + (pipeFinal2.size.width/2 ), y: -(pipeFinal2.size.height / 2) - (gapHeight / 2) + pipeOffset)
        
        //Damos cuerpo a las físicas de la tubería
        pipeFinal2.physicsBody = SKPhysicsBody(rectangleOf: pipeFinal2.size)
        
        //No se verá afectada por la gravedad
        pipeFinal2.physicsBody?.isDynamic = false
        
        //Indicar el grupo
        pipeFinal2.physicsBody?.categoryBitMask = objectGroup
        
        //Se coloca entre la gravedad y el pájaro
        pipeFinal2.zPosition = 4
        
        //Ejecutar la secuencia
        pipeFinal2.run(moveAndRemovePipes)
        
        self.movingGroup.addChild(pipeFinal2)
        
        
        makeGapNode(pipeOffset, gapHeight: gapHeight, moveAndRemovePipes: moveAndRemovePipes)
        
    }
    
    
    
    ///Crea un objeto entre las tuberías que permita aumentar el contador al pasar por la tubería
    func makeGapNode(_ pipeOffset : CGFloat, gapHeight : CGFloat, moveAndRemovePipes : SKAction){
        //Crear objeto
        let gap = SKNode()
        
        //La posición en X debe ser la misma que la de la tubería
        //La posición en Y debe de ser pasada por parámetro y depende de la posición del gap random
        gap.position = CGPoint(x: (self.frame.width / 2) + (pipeFinal2.size.width/2 ) , y: pipeOffset)
        
        //Pintarlo con el mismo ancho que la tubería y el alto = al espacio entre tuberías
        gap.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: pipeFinal2.size.width, height: gapHeight))
        
        gap.physicsBody?.isDynamic = false
        gap.run(moveAndRemovePipes)
        gap.zPosition = 7
        gap.physicsBody?.categoryBitMask = gapGroup
        self.movingGroup.addChild(gap)
    }
    
    
    
    
    
    
    
    
    ///Pájaro afectado por las físicas
    func makeBird(){
        //1 -> creacion de texturas
        let birdTexture1 = SKTexture(imageNamed: "flappy1")
        let birdtexture2 = SKTexture(imageNamed: "flappy2")
        //2 -> Accion
        let animacionBird = SKAction.animate(with: [birdTexture1, birdtexture2], timePerFrame: 0.1)
        //3 -> accion para siempre
        let makeBirdForever = SKAction.repeatForever(animacionBird)
        //4 -> asignamos la textura a nuestro SKSpriteNode
        bird = SKSpriteNode(texture: birdTexture1)
        //5 -> posicion en el espacio
        bird.position = CGPoint(x: 0, y: 0)
        bird.zPosition = 15
        
        //GRUPO DE FISICAS
        //Cuerpo físico para el pájaro
        
        //Que sea un círculo alrededor
        bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.width / 2)
        
        //Que se corresponda con el borde de la imagen
        //Si usamos este método los contactos cuentan varias veces.
        /*bird.physicsBody = SKPhysicsBody(texture: birdTexture1,
                                         alphaThreshold: 0.5,
                                         size: CGSize(width: bird.size.width,
                                                      height: bird.size.height))*/
        
        //Se ve modificado por las físicas
        bird.physicsBody?.isDynamic = true
        
        //Asignar grupo al pájaro
        bird.physicsBody?.categoryBitMask = birdGroup
        
        //Indicar con que objeto puede colisionar, chocan sin superponerse
        bird.physicsBody?.collisionBitMask = objectGroup
        
        //Indicar con cual superponerse
        bird.physicsBody?.contactTestBitMask = objectGroup | gapGroup
        
        //Puede girar
        bird.physicsBody?.allowsRotation = false
        
        //6 -> animacion
        bird.run(makeBirdForever)
        self.addChild(bird)
        
    }
    
    
    
    
    func makeLabel(){
        scoreLBL.fontName = "Helvetica"
        scoreLBL.fontSize = 60
        scoreLBL.text = "0"
        scoreLBL.position = CGPoint(x: 0, y: (self.frame.height / 2) - 90)
        scoreLBL.zPosition = 10
        self.addChild(scoreLBL)
    }
    
    func makeLabelGameOver(){
        gameOverLBL.fontName = "Helvetica"
        gameOverLBL.fontSize = 30
        gameOverLBL.text = "Game Over!"
        gameOverLBL.position = CGPoint(x: 0, y: 0)
        gameOverLBL.zPosition = 20
        self.addChild(gameOverLBL)
    }
    
    func resetGame(){
        //Puntos a 0
        score = 0
        
        //Repintar etiqueta
        scoreLBL.text = "0"
        
        //Borrar todo lo que se mueve: Tuberías y background
        movingGroup.removeAllChildren()
        
        //Pintar tuberías y fondo
        makeBackground()
        makeLoopPipe1AndPipe2()
        
        
        
        //Recolocar al pájaro
        bird.position = CGPoint(x: 0, y: 0)
        bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        //Borrar etiqueta de gameover
        gameOverLBL.removeFromParent()
        
        //Volvemos a mover todo
        movingGroup.speed = 1
        
        //Inidicar que no se ha acabado el juego
        gameOver = false
        
    }
    
    
    
    
    
    
}
