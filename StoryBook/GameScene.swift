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
 
    
    override func didMove(to view: SKView) {
        if let somePlayer:SKSpriteNode = self.childNode(withName: "Player") as? SKSpriteNode {
            thePlayer = somePlayer
            thePlayer.physicsBody?.isDynamic = false
            print("Playernode Assigned")
        } else {
            print("Assignment failed")
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
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
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
