//
//  GameScene.swift
//  StoryBook
//
//  Created by Simon Riemertzon on 07/03/17.
//  Copyright © 2017 Simon Riemertzon. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var thePlayer:SKSpriteNode = SKSpriteNode()
    var moveSpeed:TimeInterval = 1
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 9.8)
        
        if let somePlayer:SKSpriteNode = self.childNode(withName: "Player") as? SKSpriteNode {
            thePlayer = somePlayer
            thePlayer.physicsBody?.isDynamic = false
            thePlayer.physicsBody?.affectedByGravity = false
            
            
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        
        
    }
    
    func moveDown() {
        
        thePlayer.physicsBody?.isDynamic = true
        thePlayer.physicsBody?.affectedByGravity = true
        
        let wait:SKAction = SKAction.wait(forDuration: 0.1)
        
        let walkAnimation:SKAction = SKAction(named: "WalkFront")!
        
        let moveAction:SKAction = SKAction.moveBy(x: 0, y: -100, duration: moveSpeed)
        
        let group:SKAction = SKAction.group([walkAnimation, moveAction])
        
        let finish:SKAction = SKAction.run {
            
            self.thePlayer.physicsBody?.isDynamic = false
            self.thePlayer.physicsBody?.affectedByGravity = false
            print("Finished!")
            
        }
        
        let seq:SKAction = SKAction.sequence([wait, group, finish])
        
        thePlayer.run(seq)
    }
    
    func moveUp() {
        
        let wait:SKAction = SKAction.wait(forDuration: 0.1)
        
        let walkAnimation:SKAction = SKAction(named: "WalkBack")!
        
        let moveAction:SKAction = SKAction.moveBy(x: 0, y: 100, duration: moveSpeed)
        
        let group:SKAction = SKAction.group([walkAnimation, moveAction])
        
        let seq:SKAction = SKAction.sequence([wait, group])
        
        thePlayer.run(seq)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
        if (pos.y > 0) {
            //top half touch
            moveUp()
        } else {
            //bottom half touch
            moveDown()
        }
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for t in touches {
            self.touchDown(atPoint: t.location(in: self))
            break;
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    
}
