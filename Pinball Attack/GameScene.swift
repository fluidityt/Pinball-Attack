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
	
	enum Size: CGFloat {
		
		case small, normal, large
		
		func toRadius(scene: SKScene = Pinball.scene) -> CGFloat {
			let sizes = (small: (scene.frame.width / 20),
			             normal: (scene.frame.width / 15),
			             large: (scene.frame.width  / 10))
			switch self {
				case .small:  return sizes.small
				case .normal:	return sizes.normal
				case .large:  return sizes.large
			}
		}
	}

	// IA Fields:
	let size: 	Pinball.Size
	let radius: CGFloat

	init(radius: CGFloat) {

		// Sudden death round is ultra-multiball madness!
		
		//self.radius = radius
		self.size =
		self.radius = Size.getSize(Pinball.Size.normal)
		
		
	}
}

// ***************************** \\
class Flipper: SKSpriteNode {
	
	required init?(coder aDecoder: NSCoder) {		fatalError("")	}
	static func notes()	{
		// FLipper size is 1/4 of width
	}
	
	static let scene = gScene
	
	// Enums:
	enum Flip {
		enum State { case down, up }
		enum Side { case left, right }
		enum Power: CGFloat {			case low = 25;			case med = 50;			case high = 75		}
		enum Player { case top, bottom }
	}
	
	// IA Fields:
	let player: Flip.Player
	let side: Flip.Side
	
	// MA Fields:
	var power: Flip.Power
	var state: Flip.State
	
	// Methods:
	func flip()	{		self.state = Flip.State.up		/* Do physics stuff */	}
	
	// Init:
	init(side: Flip.Side, player: Flip.Player, ball: Pinball) {
		
		let scene = Flipper.scene!
		
		inits: do {
			
			self.side = side
			self.player = player
			self.state = .down
			self.power = .low
			
			let swidth = scene.frame.maxX / 4
			let sheight = swidth / 5
			
			super.init(texture: SKTexture(),
			           color: SKColor.blueColor(),
			           size: CGSize(width: swidth, height: sheight))
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
			let gap_factor: CGFloat = 2
			let gap = (ball.radius * gap_factor)
		
			if self.player == Flip.Player.bottom {
				switch side {
					case .left:
						self.position.y = scene.frame.midY
						self.position.x = scene.frame.midX
						self.position.x -= (self.frame.width + gap)
					case .right:
						self.position.y = scene.frame.midY
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
		
		testing: do {
		//		let flipperLeft = Flipper(side: .left, player: .bottom)
		//let flipperRight = Flipper(side: .right, player: .bottom)

		//flipperLeft.runAction(SKAction.moveBy(CGVector(dx: 500, dy: 500), duration: 10))
		//myFlip = flipperRight
			}
		
		let ball = Pinball(radius: self.frame.width / 15)
		
		player = (bottom:Player(player: .bottom, ball: ball),
		          top: Player(player: .top, ball: ball))
		//let left = Flipper(side: .left, player: .bottom)
		//Xlet right = Flipper(side: .right, player: .bottom)
		
	}
	
	// ** \\
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) { for touch in touches {
		
		let tloc = touch.locationInNode(self); print(tloc)
			
			
		}
	}
	
	// ** \\
	override func update(currentTime: CFTimeInterval) {
		
	}
}

//
//
//
//