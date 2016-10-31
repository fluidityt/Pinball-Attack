import SpriteKit
import UIKit

class Glober: SKNode {

	var list_of_nodes: [String]
	
	init(listOfNodes lon: [String]){
		
		self.list_of_nodes = lon
		
		super.init()
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

func dmv(scene: SKScene) {
	
	let new_player = SKSpriteNode()
	
	scene.addChild(new_player)
	
}

func tb() {
	
}

func updates() {
	
}

// What about putting the data inside the node?
struct Player2  {
	
	let node: String

	let name: String
	let HP: Int
	
	
		
	
}

// Procedural
// Pure
// Immutable

// Don't persist the actual node... make it and call it by name...






