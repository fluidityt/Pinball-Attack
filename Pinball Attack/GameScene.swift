//
//  GameScene.swift
//  Pinball Attack
//
//  Created by Dude Guy  on 10/27/16.
//  Copyright (c) 2016 Dude Guy . All rights reserved.
//

// MARK: - Top -
import SpriteKit

// GLOBAL:
var gScene: SKScene?

class Flipper: SKSpriteNode {
	static func notes() {
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
	func flip() {
		self.state = Flip.State.up
		// Do physics stuff
	}
	
	// Init:
	init(side: Flip.Side, player: Flip.Player) {

		let scene = Flipper.scene!
		
		self.side = side
		self.player = player
		self.state = .down
		self.power = .low
		
		let swidth = scene.frame.maxX / 4
		let sheight = swidth / 3
		
		super.init(texture: SKTexture(),
		           color: SKColor.blueColor(),
		           size: CGSize(width: swidth, height: sheight))
		
		// Find anchorpoint:
		switch side {
			case .left:
				self.anchorPoint.x = 2
			case .right:
				()
		}
	};required init?(coder aDecoder: NSCoder) {		fatalError("init(coder:) has not been implemented")	}
}

struct Player {
	
	static let scene = gScene
	
	let flipper: (left: Flipper, right: Flipper)
	
	var score: Int
	
	init(player: Flipper.Flip.Player) {
		self.flipper.left = Flipper(side: .left, player: player)
		self.flipper.right = Flipper(side: .right, player: player)
		
		self.score = 0
	}
}

class GameScene: SKScene {
	
	var player = (top: Player(player: .top), bottom: Player(player: .bottom))
	
	override func didMoveToView(view: SKView) {
		gScene = self
	}
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		for touch in touches {
			_ = touch.locationInNode(self)
		}
	}
	
	override func update(currentTime: CFTimeInterval) {
		
	}
}
