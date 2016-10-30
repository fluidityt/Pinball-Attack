import SpriteKit
import UIKit



// All potential nodes that could need stop / start or Qing go in here
var gNodesToCheck = Set<SKNode>()

/* For use in FullStopHandler: */
extension SKNode {

	var addToCheck: Bool          /*-*/ { get { return self.addToCheck } set {} } /*_*/

	var nextForces: [CGVector]    /*-*/ {	get { return self.nextForces} set {} } /*_*/

	/** Fileprivate checks self against global and adds if needed: */
	private func addToChecklist(inout noded: Set<SKNode>) {
		noded.contains( self ) ? () : noded.insert( self )
	}

	/** Checks if pinned.. if yes, puts in NextForces */
	func applyForce( force: CGVector, inout checkList gnodes_to_check: Set<SKNode> ) {
		/* TODO: Why can't I put this in the fucking default prams? */
		addToChecklist(&gnodes_to_check)
		
		let pb = self.physicsBody!
		pb.pinned ? self.nextForces.append( force ) : pb.applyForce( force )
	}

	func stop(inout checkList gnodes_to_check: Set<SKNode>) {
		addToChecklist(&gnodes_to_check)

		let pb = self.physicsBody!
		pb.pinned = false
	}
}


func updateStuff<imp>( imp: imp ) {

	// Nothing to do:
	if gNodesToCheck.isEmpty { return }

	// Act then reset:
	else { gNodesToCheck.removeAll() }

}
