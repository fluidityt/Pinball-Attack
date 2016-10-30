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
		pb.pinned ?
			{print("ok");self.nextForces.append( force )}() : pb.applyForce( force )
	}

	func stop(inout checkList gnodes_to_check: Set<SKNode>) {
		addToChecklist(&gnodes_to_check)

		let pb = self.physicsBody!
		pb.pinned = false
	}

	func kill() {
		gNodesToCheck.remove( self )
	}
}


func updateStuff( inout gCheckList gnodes_to_check: Set<SKNode> ) {

	// Nothing to do:
	guard !gnodes_to_check.isEmpty else { return }

	// Act then reset:
	for node in gnodes_to_check {
		
		// Unpin:
		guard !node.physicsBody!.pinned else { continue }
		node.physicsBody!.pinned = false
		
		// Apply forces:
		guard  !node.nextForces.isEmpty else { return }
		for force in node.nextForces { node.physicsBody?.applyForce( force ) }

		node.nextForces.removeAll()
	}
}

