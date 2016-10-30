//
//  Game Board.swift
//  Pinball Attack
//
//  Created by Dude Guy  on 10/27/16.
//  Copyright © 2016 Dude Guy . All rights reserved.
//

import SpriteKit
import UIKit




private let scene2 = gScene
// Ball
struct ConBall {
	let
			small:  CGFloat = 20,
			normal: CGFloat = 15,
			large:  CGFloat = 10

	let default_size: Pinball.Size = .normal
}

// Flipper:
struct ConFlip {
	let

			power           = CGFloat (25), // TODO: Move this to physics

			width           = CGFloat (scene2!.frame.maxX / 4),
			height          = CGFloat ((scene2!.frame.maxX / 4) / 5),

			gap_factor      = CGFloat (2),
 
			offset: CGFloat = 100
}

// Physics
struct ConPhy {
	let
			dist:      CGFloat        = 1, // Distance
			flip_up:   NSTimeInterval = 0.06,
			flip_down: NSTimeInterval = 0.08
}


extension SKScene {
	var center: CGPoint {
		get {
			return CGPoint (x: self.frame.midX, y: self.frame.midY)
		}
	}
}

/* MARK: OOP nonsense */
/// Signals that we are doing some bullshit.
func OOP () -> Any {

	return 0
}

infix operator --> {}

func --> (l: Any, r: Any) {

}


// For use in FullStopHandler:
extension SKPhysicsBody {

	/// If pinned Q the next force, else just do the force:
	func applyForce (nextForce force: CGVector) {

		if self.pinned {
			FullStopHandler.queueForce (force, to: self.node!)
		}
		else {
			self.applyForce (force)
		}
	}

	/// Stop the node NOW, then add it to a Q to be unpinned...
	func fullStop () {

		FullStopHandler.stop (self.node!)
	}
}


