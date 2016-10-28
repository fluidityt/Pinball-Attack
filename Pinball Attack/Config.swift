//
//  Game Board.swift
//  Pinball Attack
//
//  Created by Dude Guy  on 10/27/16.
//  Copyright © 2016 Dude Guy . All rights reserved.
//

import SpriteKit


private let scene = gScene

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
	power = CGFloat(25),
	width = CGFloat(scene!.frame.maxX / 4),
	height = CGFloat((scene!.frame.maxX / 4)/5),
	gap_factor = CGFloat(2)
}
