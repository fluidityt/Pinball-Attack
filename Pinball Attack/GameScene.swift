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
class Pinball {
	static let scene: SKScene = gScene!
	//static let c = Configz.c.b // TODO: Memory issues
	
	enum Size: CGFloat {
		
		case small, normal, large
		
		func toRadius(scene: SKScene = Pinball.scene) -> CGFloat {
			let c = ConBall()
			
			switch self {
				case .small:  return (scene.frame.width / c.small ) 		// Config.Ball
				case .normal:	return (scene.frame.width / c.normal)
				case .large:  return (scene.frame.width / c.large )
			}
		}
	}

	// IA Fields:
	let radius: CGFloat

	init(size: Pinball.Size) {

		// Sudden death round is ultra-multiball madness!
		
		self.radius = size.toRadius()
	}
}

// ***************************** \\
class Flipper: SKSpriteNode {
	
	required init?(coder aDecoder: NSCoder) {		fatalError("")	}
	static func notes()	{
		// FLipper size is 1/4 of width
	}
	
	
	// Enums:
	enum Flip {
		enum State { case down, up }
		enum Side { case left, right }
		enum Player { case top, bottom }
	}
	
	// IA Fields:
	let player: Flip.Player
	let side: Flip.Side
	
	// MA Fields:
	var power: CGFloat
	var state: Flip.State
	
	// Methods:
	func flip()	{		self.state = Flip.State.up		/* Do physics stuff */	}
	
	// Init:
	init(side: Flip.Side, player: Flip.Player, ball: Pinball) {
		
		let scene = gScene!
		let c = ConFlip()
		
		inits: do {
			
			self.side = side
			self.player = player
			self.state = .down
			self.power = c.power
			
			super.init(texture: SKTexture(),
			           color: SKColor.blueColor(),
			           size: CGSize(width: c.width,	height: c.height))
			scene.addChild(self)
		}
		
		findAnchorAndPos: do {
			// Find anchorpoint:
			if self.player == Flip.Player.bottom {
				switch side {
				case .left:
					self.anchorPoint.x = 0
					self.anchorPoint.y = self.frame.midY
				case .right:
					self.anchorPoint.x = 1
					self.anchorPoint.y = self.frame.midY
				}
			}
			// Find position:
			let gap = (ball.radius * c.gap_factor)
			
			if self.player == Flip.Player.bottom {
				switch side {
				case .left:
					self.position.y = (scene.frame.minY + c.offset)
					self.position.x = scene.frame.midX
					self.position.x -= (self.frame.width + gap)
				case .right:
					self.position.y = (scene.frame.minY + c.offset)
					self.position.x = scene.frame.midX
					self.position.x += (self.frame.width + gap)
				}
			}
			else if self.player == Flip.Player.top {
				switch side {
				case .left:
					self.position.y = (scene.frame.maxY - c.offset)
					self.position.x = scene.frame.midX
					self.position.x -= (self.frame.width + gap)
				case .right:
					self.position.y = (scene.frame.maxY - c.offset)
					self.position.x = scene.frame.midX
					self.position.x += (self.frame.width + gap)
				}
			}
		}
	}
}

// ***************************** \\
struct Player {
	
	// static let scene = gScene
	
	let flipper: (left: Flipper, right: Flipper)
	
	var score: Int
	
	//	func position(xy: CGPoint) {
	//		flipper.left.position = xy
	//			flipper.right.position.x = flipper.left.frame.maxX
	//			flipper.right.position.y = flipper.left.frame.maxY
	//	}
	
	init(player: Flipper.Flip.Player, ball: Pinball) {
		self.flipper.left = Flipper(side: .left, player: player, ball: ball)
		self.flipper.right = Flipper(side: .right, player: player, ball: ball)
		self.score = 0
	}
}


// ***************************** \\
class GameScene: SKScene {
	
	// ** \\
	private var player: (top: Player, bottom: Player)? = nil
	
	// ** \\
	override func didMoveToView(view: SKView) {
		
		inits: do {
			// Global:
			gScene = self
			gView = view
			
			// Init:
			self.size = CGSize(width: view.frame.width, height: view.frame.height)
			self.anchorPoint = CGPoint(x: 0, y: 0)
		}
		
		let ball = Pinball(size: ConBall().default_size)
		
		player = (bottom:Player(player: .bottom, ball: ball),
		          top: Player(player: .top, ball: ball))
		
		//player!.top = player!.bottom
		
	}
	
	// ** \\
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		for touch in touches {
			let view = gView!
			let scene = gScene!; print(scene)
			
			let c = ConPhy()
			
			let tloc = touch.locationInNode(self); print(tloc)
			
			flipPlayerBottom: do {
				let sequence_left = SKAction.sequence([
					SKAction.rotateByAngle(c.dist, duration: c.flip_up),
					SKAction.rotateByAngle(-c.dist, duration: c.flip_down)])
				
				let sequence_right = SKAction.sequence([
					SKAction.rotateByAngle(-c.dist, duration: c.flip_up),
					SKAction.rotateByAngle(c.dist, duration: c.flip_down)])
				
				if tloc.x <= view.center.x
				{	player?.bottom.flipper.left.runAction(sequence_left) }
				else if tloc.x >= view.center.x
				{ player?.bottom.flipper.right.runAction(sequence_right) }
			}
			
			flipPlayerTop: do {
				let sequence_left	= SKAction.sequence([
					SKAction.rotateByAngle(-c.dist, duration: c.flip_up),
					SKAction.rotateByAngle(c.dist, duration: c.flip_down)])
				
				let sequence_right = SKAction.sequence([
					SKAction.rotateByAngle(c.dist, duration: c.flip_up),
					SKAction.rotateByAngle(-c.dist, duration: c.flip_down)])
				
				if tloc.x <= view.center.x
				{	player?.top.flipper.left.runAction(sequence_left) }
				else if tloc.x >= view.center.x
				{ player?.top.flipper.right.runAction(sequence_right) }
				
			}
		}
	}
	
	
	// ** \\
	override func update(currentTime: CFTimeInterval) {
		
	}
}
