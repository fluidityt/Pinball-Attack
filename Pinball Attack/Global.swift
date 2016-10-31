//
//  Global.swift
//  Pinball Attack
//
//  Created by Dude Guy  on 10/30/16.
//  Copyright © 2016 Dude Guy . All rights reserved.
//

import SpriteKit
import UIKit

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


// Update() globes:
var taps    = 0
var label   = SKLabelNode ( text: "0" )
var counter = 0
var seconds = 0
