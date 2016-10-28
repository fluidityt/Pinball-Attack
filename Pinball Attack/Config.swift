//
//  Game Board.swift
//  Pinball Attack
//
//  Created by Dude Guy  on 10/27/16.
//  Copyright © 2016 Dude Guy . All rights reserved.
//

import SpriteKit



private let scene2 = gScene
// Ball
struct ConBall {
	let
	small:CGFloat = 20,
	normal:CGFloat = 15,
	large:CGFloat = 10
	
	let default_size: Pinball.Size = .normal
}

// Flipper:
struct ConFlip {
	let
	
	power = CGFloat(25), // TODO: Move this to physics
	
	width = CGFloat(scene2!.frame.maxX / 4),
	height = CGFloat((scene2!.frame.maxX / 4)/5),
	
	gap_factor = CGFloat(2),
	
	offset: CGFloat = 100
}

// Physics
struct ConPhy {
	let
	dist: CGFloat = 1, // Distance
	flip_up:NSTimeInterval = 0.06,
	flip_down:NSTimeInterval = 0.08
}


extension SKScene {
	var center: CGPoint { get { return CGPoint(x: self.frame.midX, y: self.frame.midY) } }
}

extension SKNode {
	func fullStop() {
		FullStopHandler.stop(self) // make a lsit
	}
}