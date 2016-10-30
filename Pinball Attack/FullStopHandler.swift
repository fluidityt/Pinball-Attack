import SpriteKit
import UIKit



// All potential nodes that could need stop / start or Qing go in here
var gNodesToCheck = Set<SKNode>()

/* For use in FullStopHandler: */
extension SKNode {

	var addToCheck: Bool /*-*/ { get { return self.addToCheck } set {} } /*_*/
	
	var nextForces: [CGVector] /*-*/{	get { return self.nextForces} set {} } /*_*/

	/** Checks if pinned.. if yes, puts in NextForces */
	func applyForce( force: CGVector ) {
		/* TODO: Why can't I put this in the fucking default prams? */
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
