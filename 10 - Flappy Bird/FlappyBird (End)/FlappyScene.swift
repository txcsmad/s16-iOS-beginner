//
//  FlappyScene.swift
//  FlappyBird
//
//  Created by Jesse Tipton on 11/16/15.
//  Copyright © 2015 MAD. All rights reserved.
//

import SpriteKit

class FlappyScene: SKScene, SKPhysicsContactDelegate {
    
    var bird: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        // TODO: Bird
        let birdTexture = SKTexture(imageNamed: "Bird1")
        birdTexture.filteringMode = SKTextureFilteringMode.Nearest
        
        let birdFlapTexture = SKTexture(imageNamed: "Bird2")
        birdFlapTexture.filteringMode = .Nearest
        
        let flapAction = SKAction.animateWithTextures([birdTexture, birdFlapTexture], timePerFrame: 0.2)
        let flapForeverAction = SKAction.repeatActionForever(flapAction)
        
        bird = SKSpriteNode(texture: birdTexture)
        bird.setScale(2)
        
        bird.position = frame.center
        
        bird.runAction(flapForeverAction)
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.height / 2)
        bird.physicsBody?.dynamic = true
        bird.physicsBody?.allowsRotation = false

        // TODO: Enable bird contact
        
        addChild(bird)

        // Sky
        backgroundColor = SKColor.flappyBirdSkyColor()
        
        // Ground
        let groundTexture = SKTexture(imageNamed: "Ground")
        groundTexture.filteringMode = .Nearest
        
        let moveGroundAction = SKAction.moveByX(-groundTexture.size().width * 2, y: 0, duration: 1)
        let resetGroundAction = SKAction.moveByX(groundTexture.size().width * 2, y: 0, duration: 0)
        let moveGroundForeverAction = SKAction.repeatActionForever(SKAction.sequence([moveGroundAction, resetGroundAction]))
        
        let groundCount = Int(frame.size.width / (groundTexture.size().width * 2)) + 2
        for n in 0..<groundCount {
            let ground = SKSpriteNode(texture: groundTexture)
            ground.setScale(2)
            
            ground.position = CGPoint(x: CGFloat(n) * ground.size.width, y: ground.size.height / 2)
            ground.runAction(moveGroundForeverAction)
            
            addChild(ground)
        }
        
        let dummyGround = SKNode()
        dummyGround.position = CGPoint(x: frame.size.width / 2, y: groundTexture.size().height)
        dummyGround.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: frame.size.width, height: groundTexture.size().height * 2))
        dummyGround.physicsBody?.dynamic = false
        addChild(dummyGround)
        
        // TODO: Skyline

        // Physics
        physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
        //TODO: Implement the physicsworld delegate
        
        // Pipes
        let spawnPipes = SKAction.performSelector(#selector(FlappyScene.spawnPipes), onTarget: self)
        let delayAction = SKAction.waitForDuration(3)
        let spawnForever = SKAction.repeatActionForever(SKAction.sequence([spawnPipes, delayAction]))
        runAction(spawnForever)
    }
    
    func spawnPipes() {
        let bottomPipeTexture = SKTexture(imageNamed: "Pipe1")
        bottomPipeTexture.filteringMode = .Nearest
        
        let topPipeTexture = SKTexture(imageNamed: "Pipe2")
        topPipeTexture.filteringMode = .Nearest
        
        let pipePair = SKNode()
        pipePair.position = CGPoint(x: frame.size.width + bottomPipeTexture.size().width, y: 0)
        pipePair.zPosition = -1
        
        let pipeY = random() % Int(frame.size.height / 3)
        
        let bottomPipe = SKSpriteNode(texture: bottomPipeTexture)
        bottomPipe.setScale(2)
        
        bottomPipe.position = CGPoint(x: 0, y: pipeY)
        bottomPipe.physicsBody = SKPhysicsBody(rectangleOfSize: bottomPipe.size)
        bottomPipe.physicsBody?.dynamic = false
        //TODO: Enable pipe contact
        
        pipePair.addChild(bottomPipe)
        
        let topPipe = SKSpriteNode(texture: topPipeTexture)
        topPipe.setScale(2)
        
        topPipe.position = CGPoint(x: 0, y: bottomPipe.size.height + CGFloat(pipeY) + 150)
        topPipe.physicsBody = SKPhysicsBody(rectangleOfSize: topPipe.size)
        topPipe.physicsBody?.dynamic = false
        
        pipePair.addChild(topPipe)
        
        let movePipesAction = SKAction.repeatActionForever(SKAction.moveByX(-1, y: 0, duration: 0.01))
        pipePair.runAction(movePipesAction)
        
        addChild(pipePair)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // TODO: Scale velocity with force of touch
        bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 10))
    }

    func didBeginContact(contact: SKPhysicsContact) {
        
    }
}
