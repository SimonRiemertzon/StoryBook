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
    
    
    let swipeRightRec = UISwipeGestureRecognizer()
    let swipeLeftRec = UISwipeGestureRecognizer()
    let swipeUpRec = UISwipeGestureRecognizer()
    let swipeDownRec = UISwipeGestureRecognizer()
    
    
    let rotateRec = UIRotationGestureRecognizer()
    let tapRec = UITapGestureRecognizer()
    
    
    
    

    override func didMove(to view: SKView) {
        //World settings
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        //GestureRecognizers
        swipeRightRec.addTarget(self, action: #selector(GameScene.swipedRight))
        swipeRightRec.direction = .right
        self.view!.addGestureRecognizer(swipeRightRec)
        
        swipeLeftRec.addTarget(self, action: #selector(GameScene.swipedLeft))
        swipeLeftRec.direction = .left
        self.view!.addGestureRecognizer(swipeLeftRec)
        
        swipeUpRec.addTarget(self, action: #selector(GameScene.swipedUp))
        swipeUpRec.direction = .up
        self.view?.addGestureRecognizer(swipeUpRec)
        
        swipeUpRec.addTarget(self, action: #selector(GameScene.swipedDown))
        swipeUpRec.direction = .down
        self.view?.addGestureRecognizer(swipeDownRec)
        
        
        /*
        rotateRec.addTarget(self, action: #selector(GameScene.rotatedView (_:)))
        self.view?.addGestureRecognizer(rotateRec)
        
        tapRec.addTarget(self, action: #selector(GameScene.tappedView))
        tapRec.numberOfTapsRequired = 1
        tapRec.numberOfTouchesRequired = 1
        self.view?.addGestureRecognizer(tapRec)
 
        */
        
        if let somePlayer:SKSpriteNode = self.childNode(withName: "Player") as? SKSpriteNode {
            thePlayer = somePlayer
            thePlayer.physicsBody?.isDynamic = false
            thePlayer.physicsBody?.affectedByGravity = false
            
        }
        
        
    }
    
    //MARK: =============== Gesture Recongnizers
    
    func tappedView() {
        print("tapped")
    }
    
    
    func rotatedView(_ sender:UIRotationGestureRecognizer) {
        if sender.state == .began {
            print("rotation began")
           
        }
        
        if sender.state == .changed {
            print("rotation changed")
            
            let rotateAmount = Measurement(value: Double(sender.rotation), unit: UnitAngle.radians).converted(to: .degrees).value
            
            print(rotateAmount)
            
            thePlayer.zRotation = -sender.rotation
            
        }
        
        if sender.state == .ended {
            print("Rotation ended ")
          
        }
    }
    
    func swipedRight() {
        print("Swiped Right!")
    }
    
    func swipedLeft() {
        print("Swiped Left!")
    }
    
    func swipedUp() {
           moveChar(xAmount: 0, yAmount: 100, animation: "WalkBack")
    }
    
    func swipedDown() {
        print("Swiped Down")
        moveChar(xAmount: 0, yAmount: -100, animation: "WalkFront")
        
    }
    
    
    
    
    func cleanUp() {
        
        //For moving to a new scene.
        for gesture in (self.view?.gestureRecognizers)! {
           self.view?.removeGestureRecognizer(gesture)
        }
        
    }
    
  
    
    
    override func update(_ currentTime: TimeInterval) {
     
    }
    
    func moveChar(xAmount:CGFloat, yAmount:CGFloat, animation:String) {
        
        thePlayer.physicsBody?.isDynamic = true
        thePlayer.physicsBody?.affectedByGravity = true
        
        let wait:SKAction = SKAction.wait(forDuration: 0.1)
        
        let walkAnimation:SKAction = SKAction(named: animation)!
        
        let moveAction:SKAction = SKAction.moveBy(x: xAmount, y: yAmount, duration: moveSpeed)
        
        let group:SKAction = SKAction.group([walkAnimation, moveAction])
        
        let finish:SKAction = SKAction.run {
            
            self.thePlayer.physicsBody?.isDynamic = false
            self.thePlayer.physicsBody?.affectedByGravity = false
            print("Finished!")
            
        }
        
        let seq:SKAction = SKAction.sequence([wait, group, finish])
        
        thePlayer.run(seq)
    }
    

    
    func touchDown(atPoint pos : CGPoint) {
        /*
        if (pos.y > 0) {
            //top half touch
            moveUp()
        } else {
            //bottom half touch
            moveDown()
        }
        */
        
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
