//
//  Game Board.swift
//  Pinball Attack
//
//  Created by Dude Guy  on 10/27/16.
//  Copyright © 2016 Dude Guy . All rights reserved.
//

import SpriteKit

// Create scene

struct Configz {	static let c = Configz();	private init(){}
	
	static let scene = gScene!
	
	// Sizes Factors:
	static let small:CGFloat = 20, normal:CGFloat = 15, large:CGFloat = 10
	
	// Ball:
	func setBallSize() {}
	func setGapFactor() {}
	
	// Flipper:
	struct f {
	static let
		power = CGFloat(25),
		width = CGFloat(scene.frame.maxX / 4),
		height = CGFloat((scene.frame.maxX / 4)/5),
		gap_factor = CGFloat(2)
	}
	
}