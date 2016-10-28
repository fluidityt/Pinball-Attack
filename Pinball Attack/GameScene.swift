//
//  GameScene.swift
//  Pinball Attack
//
//  Created by Dude Guy  on 10/27/16.
//  Copyright (c) 2016 Dude Guy . All rights reserved.
//

// MARK: - Top -
import SpriteKit

// ***************************** \\
var gScene: SKScene?
var gView:	SKView?

// ***************************** \\
class GameScene: SKScene {
	
	// ** \\
	private var player: (top: Player, bottom: Player)? = nil
	private let ball = Pinball(size: ConBall().default_size)
	
	// ** \\
	override func didMoveToView(view: SKView) {
		
		inits: do {
			// Global:
			gScene = self
			gView = view
			
			// Init:
			self.size = CGSize(width: view.frame.width, height: view.frame.height)
			self.anchorPoint = CGPoint(x: 0, y: 0)
			self.physicsBody?.affectedByGravity = true
		}
		
		
		player = (bottom:Player(player: .bottom, ball: ball),
		          top: Player(player: .top, ball: ball))
		
		//player!.top = player!.bottom
		
	}
	
	// ** \\
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		
		for touch in touches {
			
			func flip(c: ConPhy = ConPhy(),
			          view: SKView = gView!,
			          tloc: CGPoint = touch.locationInNode(self),
			          player: (bottom: Player, top: Player) = self.player!) {
				
				let pos_neg = SKAction.sequence([
					SKAction.rotateByAngle(c.dist, duration: c.flip_up),
					SKAction.rotateByAngle(-c.dist, duration: c.flip_down)])
				
				let neg_pos = SKAction.sequence([
					SKAction.rotateByAngle(-c.dist, duration: c.flip_up),
					SKAction.rotateByAngle(c.dist, duration: c.flip_down)])
				
				flipPlayerBottom: do {
					if (tloc.y <= view.center.y) {
						(tloc.x <= view.center.x) ?
							player.bottom.flipper.left.runAction(pos_neg) : // Flip left
							player.bottom.flipper.right.runAction(neg_pos)  // Flip right
					}
				}
				
				flipPlayerTop: do {
					if (tloc.y > view.center.y) {
						tloc.x <= view.center.x ?
							player.top.flipper.left.runAction(neg_pos) : // Flip left
							player.top.flipper.right.runAction(pos_neg)  // Flip right
					}
				}
			}
			
			// FUCKING BUGS:
			flip(tloc: touch.locationInNode(self), player: self.player!)
		}
	}
	
//	override func update(currentTime: CFTimeInterval){
//	
//		resetPinball: do {
//			let sbnpx = self.ball.node.position.x
//			let sbnpy = self.ball.node.position.y
//			
//			if (sbnpx == self.frame.minX) || (sbnpx == self.frame.maxX) {
//				self.ball.node.position = self.center
//			}
//			else if (sbnpy == self.frame.minY) || (sbnpy == self.frame.maxY) {
//				self.ball.node.position = self.center
//			}
//		}
//	}
}