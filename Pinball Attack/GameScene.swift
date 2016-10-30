//
//  GameScene.swift
//  Pinball Attack
//
//  Created by Dude Guy  on 10/27/16.
//  Copyright (c) 2016 Dude Guy . All rights reserved.
//

/// WHY THE FUCK DOES SELF KEEP SCREWING ME OVER????

// MARK: - Top -

import SpriteKit
import UIKit



// TODO: ADD NAMES TO NODES

// ***************************** \\
var gScene: SKScene?
var gView:  SKView?

// ***************************** \\

class Pinball {


	var addToCheck: Bool          /*-*/ { get { return self.addToCheck } set {} } /*_*/

	var nextForces: [CGVector] = []

	/** Fileprivate checks self against global and adds if needed: */
	private func addToChecklist(inout noded: [Pinball]) {
		for node in noded {
			if node === self { () }
			else { noded.append(self) }
		}
	}

	/** Checks if pinned.. if yes, puts in NextForces */
	func applyForce( force: CGVector, inout checkList gnodes_to_check: [Pinball] ) {
		/* TODO: Why can't I put this in the fucking default prams? */
		addToChecklist(&gnodes_to_check)

		let pb = self.node.physicsBody!
		pb.pinned ? self.nextForces.append( force ) : pb.applyForce( force )
	}

	func stop(inout checkList gnodes_to_check: [Pinball]) {
		//addToChecklist(&gnodes_to_check)
		gNodesToCheck.append(self)
		
		let pb = self.node.physicsBody!
		pb.pinned = true
	}

	enum Size: CGFloat {

		case small, normal, large

		func toRadius ( scene: SKScene = gScene!, c: ConBall = ConBall () ) -> CGFloat {
			switch self {
				case .small:  return (scene.frame.width / c.small)
				case .normal:  return (scene.frame.width / c.normal)
				case .large:  return (scene.frame.width / c.large)
			}
		}
	}

	// IA Fields:
	let radius: CGFloat
	let node:   SKShapeNode

	init ( size: Pinball.Size, scene: SKScene = gScene! ) {

		// Sudden death round is ultra-multiball madness!
		self.radius = size.toRadius ()
		
		self.node = SKShapeNode ( circleOfRadius: self.radius );
		_ = node
				    .name = "My Pinball";
		_ = node
				    .position = scene.center;
		_ = node
						.fillColor = SKColor.blueColor ();
		_ = node
						.physicsBody = SKPhysicsBody ( circleOfRadius: self.radius );
		_ = node
						.physicsBody?.affectedByGravity = false;
		_ = node
						.physicsBody?.pinned = false

		scene.addChild ( self.node )
	}
}

// ***************************** \\

class Flipper: SKSpriteNode {
	required init?( coder aDecoder: NSCoder ) { fatalError ( "" ) }

	static func notes () {
		// FLipper size is 1/4 of width
	}

	// Enums:

	enum Flip {

		enum State {
			case down, up
		}

		enum Side {
			case left, right
		}

		enum Player {
			case top, bottom
		}

	}

	// IA Fields
	let player: Flip.Player
	let side:   Flip.Side

	// MA Fields:
	var power:  CGFloat
	var state:  Flip.State

	// Init:
	init ( side: Flip.Side, player: Flip.Player, ball: Pinball, scene: SKScene = gScene!, c: ConFlip = ConFlip () ) {

		inits:do {

			self.side = side
			self.player = player
			self.state = .down
			self.power = c.power

			super.init ( texture: SKTexture (),
									 color: SKColor.blueColor (),
									 size: CGSize ( width: c.width, height: c.height ) )
			scene.addChild ( self )
		}

		setAnchor:do {
			switch self.side {
				case .left:
					self.anchorPoint.x = 0
					self.anchorPoint.y = self.frame.midY
				case .right:
					self.anchorPoint.x = 1
					self.anchorPoint.y = self.frame.midY
			}
		}

		setPositions:do {
			let gap = (ball.radius * c.gap_factor)

			if self.player == Flip.Player.bottom {
				switch side {

					case .left:
						self.position.y = (scene.frame.minY + c.offset)
						self.position.x = (scene.frame.midX - (self.frame.width + gap))
					case .right:
						self.position.y = (scene.frame.minY + c.offset)
						self.position.x = (scene.frame.midX + (self.frame.width + gap))
				}
			}

			else if self.player == Flip.Player.top {
				switch side {
					case .left:
						self.position.y = (scene.frame.maxY - c.offset)
						self.position.x = (scene.frame.midX - (self.frame.width + gap))
					case .right:
						self.position.y = (scene.frame.maxY - c.offset)
						self.position.x = (scene.frame.midX + (self.frame.width + gap))
				}
			}
		}
	}/* /init */
}

// ***************************** \\

struct Player {

	let flipper: ( left: Flipper, right: Flipper )

	var score: Int

	init ( player: Flipper.Flip.Player, ball: Pinball ) {
		self.flipper.left = Flipper ( side: .left, player: player, ball: ball )
		self.flipper.right = Flipper ( side: .right, player: player, ball: ball )
		self.score = 0
	}
}

// ***************************** \\
var ball:   Pinball?
var player: ( top: Player, bottom: Player )?

class GameScene: SKScene {

	// ** \\
	override func didMoveToView ( view: SKView ) {

		inits:do {
			// Global:
			gScene = self
			gView = view

			// Init:
			self.size = CGSize ( width: view.frame.width, height: view.frame.height )
			self.anchorPoint = CGPoint ( x: 0, y: 0 )
			self.physicsBody?.affectedByGravity = true

			label.position = self.center
			label.position.y -= 200
			self.addChild ( label )
		}

		ball = Pinball ( size: ConBall ().default_size )
		//ball?.node.physicsBody?.pinned = true

		/*
			player = (bottom:Player(player: .bottom, ball: ball!),
								top: Player(player: .top, ball: ball!))
		*/
	}

	// ** \\
	override func touchesBegan ( touches: Set<UITouch>, withEvent event: UIEvent? ) {

		taps += 1;
		let n = ball
		let up = CGVector ( dx: 0, dy: 2000 )

		// TODO: APPARENTLY EVERYTHING NEEDS TO BE SOME FUNCTION OF SCREEN SIZE...
		let down = CGVector ( dx: 0, dy: -20000 )

		n!.applyForce(down, checkList: &gNodesToCheck)

		for touch in touches {
			/*
			func flip(c: ConPhy = ConPhy(),
			view: SKView = gView!,
			tloc: CGPoint = touch.locationInNode(self),
			player: (bottom: Player, top: Player) = player!) {
			
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
			*/
		}
	}

	override func update ( currentTime: CFTimeInterval ) {

	let up = CGVector ( dx: 0, dy: 2000 )
		updateTime: do { counter += 1;
		if counter >= 60 {
			seconds += 1;
			counter = 0
		}
			}
		
		updateStuff(gCheckList: &gNodesToCheck)
		


		resetBall:do {

			let n = ball!.node

			if n.position.y >= self.frame.maxY {				n.position = self.center			}
			
			// current testing:
			if n.position.y <= self.frame.minY {
				n.position = self.center
				ball?.stop(checkList: &gNodesToCheck)
			}
		}
	}
}


// Update() globes:
var taps    = 0
var label   = SKLabelNode ( text: "0" )
var counter = 0
var seconds = 0


//
//
//
//

