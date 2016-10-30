import SpriteKit
import UIKit



// All potential nodes that could need stop / start or Qing go in here
var gNodesToCheck = [Pinball]()


func updateStuff( inout gCheckList gnodes_to_check: [Pinball] ) {

	if counter > 58 { print(gnodes_to_check) }
	// Nothing to do:
	guard !gnodes_to_check.isEmpty else {
		print(" i hate my life")
		return
	}

	// Act then reset:
	for node in gnodes_to_check {
		
		// Unpin:
		guard !node.node.physicsBody!.pinned else {
			print("should be false : \(node.node.physicsBody!)")
			continue
		}
			print("should be true : \(node.node.physicsBody!)")
		node.node.physicsBody!.pinned = false
		
		// Apply forces:
		guard  !node.nextForces.isEmpty else { return }
		for force in node.nextForces { node.node.physicsBody?.applyForce( force ) }

		node.nextForces.removeAll()
	}
}

