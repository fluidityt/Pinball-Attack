import SpriteKit
import UIKit



// All potential nodes that could need stop / start or Qing go in here
var gNodesToCheck: [SKNode] = []

/* For use in FullStopHandler: */
extension SKNode {

	var nextForces: [CGVector] /*-*/{	get { return self.nextForces} set {}} /*_*/

	// Checks if pinned.. if yes, puts in NextForces
	func applyForce( force: CGVector ) {
		let pb
				= self.physicsBody! /* TODO: Why can't I put this in the fucking default prams? */
		pb.pinned ? self.nextForces.append( force ) : pb.applyForce( force )
	}

	convenience public init( addToNodeCheck: Bool ) {
		self.init()
		addToNodeCheck ? gNodesToCheck.append( self ) : ()
	}
}


func updateStuff<imp>( imp: imp ) {

	// Nothing to do:
	if gNodesToCheck.isEmpty { return }

	// Act then reset:
	else { gNodesToCheck.removeAll() }

}
