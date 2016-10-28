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
var gView:	SKView?


class Flipper: SKSpriteNode {
	static func notes() {
	// FLipper size is 1/4 of width
	}
	
	static let scene = gScene
	static let view = gView
	
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
		let view 	= Flipper.view!
		
		self.side = side
		self.player = player
		self.state = .down
		self.power = .low
		
		let swidth = scene.frame.maxX / 4
		let sheight = swidth / 5
		
		super.init(texture: SKTexture(),
		           color: SKColor.blueColor(),
		           size: CGSize(width: swidth, height: sheight))
		
		// Find anchorpoint:
		switch player {
			case .bottom:
				switch side {
					case .left:
						self.anchorPoint.x = frame.minX
						self.anchorPoint.y = frame.midY
					case .right:
						self.anchorPoint.x = frame.maxX
						self.anchorPoint.y = frame.midY
				}
			
			case .top: ()
		}
	
		// Find position:
		switch player {
			case .bottom:
				switch side {
					case .left:
						self.position = view.center
						self.position.x -= self.frame.width
					case .right:
						self.position = view.center
						self.position.y += self.frame.width
				}
			case .top: ()
		}
		
		// Add to scene
		scene.addChild(self)
			
		};required init?(coder aDecoder: NSCoder) {		fatalError("init(coder:) has not been implemented")	}
}


struct Player {
	
	// static let scene = gScene
	
	let flipper: (left: Flipper, right: Flipper)
	
	var score: Int
	
	func position(xy: CGPoint) {
		flipper.left.position = xy
			flipper.right.position.x = flipper.left.frame.maxX
			flipper.right.position.y = flipper.left.frame.maxY
	}
	
	init(player: Flipper.Flip.Player) {
		self.flipper.left = Flipper(side: .left, player: player)
		self.flipper.right = Flipper(side: .right, player: player)
		self.score = 0
	}
}


private var player: (top: Player, bottom: Player)? = nil


class GameScene: SKScene {
	
	
	override func didMoveToView(view: SKView) {
	
		gScene = self
		gView = view
		
		self.size = CGSize(width: view.frame.width, height: view.frame.height)
		self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
		
		let flipperLeft = Flipper(side: .left, player: .bottom)
		let flipperRight = Flipper(side: .right, player: .bottom)
		//player = (top: Player(player: .top), bottom: Player(player: .bottom))
	}
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
	
		for touch in touches {
			let tloc = touch.locationInNode(self)
			
			print(tloc)
			//player?.bottom.position(tloc)
		}
	}
	
	override func update(currentTime: CFTimeInterval) {
		
	}
}
