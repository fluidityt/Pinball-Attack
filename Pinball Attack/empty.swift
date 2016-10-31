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

	// An SKNode:
	let pinball = sys.pinball
	// Data struct:
	let data    = sys.pinball.data
	// Specialized-sub-struct:
	let rocket  = sys.pinball.data.rocket






	fire_results = rocket.fire( rocket.power, rocket.fires_remaining )

	next_rocket_power = (fire_results.fires_remaining / fire_results.power)
	next_rocket_fires_remaining = fire_results.fires_remaining


	let new_rocket = Rocket( oldRocket: rocket, newPower: next_rocket_power, newFR: new_rocket_fires_remaining ) {


	}

	struct Rocket {

		let power:           Int
		let fires_remaining: Int

		init( oldRocket: Rocket? = nil,
		      newPower: Int? = nil,
		      newFR: Int? = nil ) {


			if oldRocket == nil {
				assignDefaults:do {
					let c = ConfRocket()
					self.fires_remaining = c.fires_remaining
					self.power            = c.power


				}
			}
			else {
				if newPower != nil { self.power = newPower! }
				else { self.power = oldRocket.power! }
			}
		}
	}
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



