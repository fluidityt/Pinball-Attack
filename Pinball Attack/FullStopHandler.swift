import SpriteKit
import UIKit



// All potential nodes that could need stop / start or Qing go in here
var gNodesToCheck = [Pinball]()


func updateStuff( inout gCheckList gnodes_to_check: [Pinball] ) {

	// Nothing to do:
	guard !gnodes_to_check.isEmpty else { return }

	// Act then reset:
	for node in gnodes_to_check {
		
		// Unpin:
		guard !node.node.physicsBody!.pinned else { continue }
		node.node.physicsBody!.pinned = false
		
		// Apply forces:
		guard  !node.nextForces.isEmpty else { return }
		for force in node.nextForces { node.node.physicsBody?.applyForce( force ) }

		node.nextForces.removeAll()
	}
}

