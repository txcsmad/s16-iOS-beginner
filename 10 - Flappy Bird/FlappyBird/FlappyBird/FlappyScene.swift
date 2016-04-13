//
//  FlappyScene.swift
//  FlappyBird
//
//  Created by Jesse Tipton on 11/16/15.
//  Copyright © 2015 MAD. All rights reserved.
//

import SpriteKit

class FlappyScene: SKScene {
    
    var bird: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        // TODO: Bird
        
        let birdTexture1 = SKTexture(imageNamed: "Bird1")
        birdTexture1.filteringMode = .Nearest
        
        let birdTexture2 = SKTexture(imageNamed: "Bird2")
        birdTexture2.filteringMode = .Nearest
        
        let flapAction = SKAction.animateWithTextures([birdTexture1, birdTexture2], timePerFrame: 0.2)
        let flapForeverAction = SKAction.repeatActionForever(flapAction)
        
        bird = SKSpriteNode(texture: birdTexture1)
        bird.setScale(2)
        
        bird.position = self.frame.center
        
        bird.runAction(flapForeverAction)
        
        // bird physics
        bird.physicsBody = SKPhysicsBody(texture: birdTexture1, size: bird.size)
        bird.physicsBody?.dynamic = true
        //bird.physicsBody?.allowsRotation = false
        
        self.addChild(bird)
        
        // TODO: Sky
        self.backgroundColor = SKColor.flappyBirdSkyColor()
        
        // TODO: Ground
        let groundTexture = SKTexture(imageNamed: "Ground")
        groundTexture.filteringMode = .Nearest
        
        let moveGroundAction = SKAction.moveByX(-groundTexture.size().width * 2, y: 0, duration: 1)
        let resetGroundAction = SKAction.moveByX(groundTexture.size().width * 2, y: 0, duration: 0)
        let groundSequenceAction  = SKAction.sequence([moveGroundAction, resetGroundAction])
        let moveGroundForever = SKAction.repeatActionForever(groundSequenceAction)
        
        let groundCount = Int(frame.size.width / (groundTexture.size().width * 2)) * 2
        for n in 0..<groundCount {
            let ground = SKSpriteNode(texture: groundTexture)
            ground.setScale(2)
            
            ground.position = CGPoint(x: CGFloat(n) * ground.size.width, y: ground.size.height / 2)
            
            ground.physicsBody = SKPhysicsBody(rectangleOfSize: ground.size)
            ground.physicsBody?.dynamic = false
            
            ground.runAction(moveGroundForever)
            
            self.addChild(ground)
        }
        
        // TODO: Skyline

        // TODO: Physics
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
        
        // TODO: Pipes
        let spawnPipesAction = SKAction.performSelector(#selector(pipeItUp), onTarget: self)
        let delayAction = SKAction.waitForDuration(3)
        let spawnPipesForever = SKAction.repeatActionForever(SKAction.sequence([spawnPipesAction, delayAction]))
        self.runAction(spawnPipesForever)
    }
    
    func pipeItUp() {
        let bottomPipeTexture = SKTexture(imageNamed: "Pipe1")
        bottomPipeTexture.filteringMode = .Nearest
        
        let topPipeTexture = SKTexture(imageNamed: "Pipe2")
        topPipeTexture.filteringMode = .Nearest
        
        let bottomPipe = SKSpriteNode(texture: bottomPipeTexture)
        bottomPipe.setScale(2)
    
        bottomPipe.physicsBody = SKPhysicsBody(texture: bottomPipeTexture, size: bottomPipe.size)
        bottomPipe.physicsBody?.dynamic = false
        
        let topPipe = SKSpriteNode(texture: topPipeTexture)
        topPipe.setScale(2)
        
        topPipe.physicsBody = SKPhysicsBody(texture: topPipeTexture, size: topPipe.size)
        topPipe.physicsBody?.dynamic = false
    
        let pipePair = SKNode()
        pipePair.addChild(bottomPipe)
        pipePair.addChild(topPipe)
        
        let pipeY = random() % Int(frame.size.height / 3)
        
        bottomPipe.position = CGPoint(x: 0, y: pipeY)
        topPipe.position = CGPoint(x: 0, y: bottomPipe.size.height + CGFloat(pipeY) + 150)
        
        pipePair.position = CGPoint(x: self.frame.size.width + bottomPipeTexture.size().width, y: 0)
        pipePair.zPosition = -1
        
        let movePipesAction = SKAction.moveByX(-1, y: 0, duration: 0.01)
        let movePipesForeverAction = SKAction.repeatActionForever(movePipesAction)
        pipePair.runAction(movePipesForeverAction)
        
        self.addChild(pipePair)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 10))
    }

}
