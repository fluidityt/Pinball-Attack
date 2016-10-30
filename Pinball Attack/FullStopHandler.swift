import SpriteKit
import UIKit



// All potential nodes that could need stop / start or Qing go in here
var gNodesToCheck: [SKNode] = []

/* For use in FullStopHandler: */
extension SKNode {

	var nextForces: [CGVector] /*-*/{	get { return nextForces } set {}} /*_*/

	// Checks if pinned.. if yes, puts in NextForces
	func applyForce( force: CGVector ) {
		let pb = self.physicsBody!

		pb.pinned ? self.nextForces.append( force ) : pb.applyForce( force )

	}

}


func updateStuff<imp>( imp: imp ) {

	// Nothing to do:
	if gNodesToCheck.isEmpty { return }

	// Act then reset:
	else { gNodesToCheck.removeAll() }

}
