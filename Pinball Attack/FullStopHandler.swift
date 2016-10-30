import SpriteKit
import UIKit


var gFSDict: [SKNode: [CGVector]?] = [:]
typealias FSDict = [SKNode: [CGVector]?]
func grabAGlobe<T>(inout any: T) -> T {	return any }

/* For use in FullStopHandler: */
extension SKPhysicsBody {

	/// If pinned Q the next force, else just do the force:
	func applyForce( nextForce force: CGVector, gfs_dict: FSDict = gFSDict ) {
		if self.pinned {
			gFSDict = FullStopHandler.queueForce( willAppy: force, onNode: self.node!, fromDict: gfs_dict )
		}
		else { self.applyForce( force ) }
	}

	/// Stop the node NOW, then add it to a Q to be unpinned...
	func fullStop( gfs_dict: FSDict ) {
		gFSDict = FullStopHandler.stop( self.node!, fs_dict: gfs_dict )
	}
}

/* Uses gFSDict and the above extension: */
struct FullStopHandler {

	private init() {}

	static func queueForce( willAppy next_force: CGVector, onNode node: SKNode, fromDict fs_dict: FSDict)
					-> FSDict {

		// Check if empty then create value:
		if fs_dict[node]! == nil {
			print("was empty : \(fs_dict[node]!)")
			// TODO: Again, figure out exactly why this isn"t working and use my [safe:] in future
			var new_dict = fs_dict
			new_dict.updateValue( [next_force], forKey: node )

			return fs_dict
		}

		// Append if not:
		else {
			print("was not : \(fs_dict[node]!)")
			var new_vector_array = fs_dict[node]!
			new_vector_array!.append( next_force )

			var new_dict = fs_dict
			new_dict.updateValue( new_vector_array, forKey: node )

			return new_dict
		}
	} /*Called in SKPB*/


	static func stop( node: SKNode, fs_dict: FSDict )
					-> FSDict {

		guard !node.physicsBody!.pinned else { return fs_dict }

		OOP --> (node.physicsBody?.pinned = true)

		var new_dict = fs_dict
		new_dict.updateValue( nil, forKey: node )

		return new_dict

	} /* Called in SKPB */

	static func handle(fs_dict: FSDict) -> FSDict {

		let unpinThenApplyStoredForces = { (forces: [CGVector]?, node: SKNode) in

			// Unpin:
			node.physicsBody?.pinned = false

			// Check for forces (value): // TODO: UNDERSTAND WHY ADDING AN EXCLAIM FIXED THIS
				if fs_dict[node]! != nil {

					// Apply forces:
					for force in forces! { node.physicsBody?.applyForce( force ) }
				}
		}

		// Early return if no entries:
		guard fs_dict.count > 0 else {


			return fs_dict
		}

		// Unpin (keys):
		for node in fs_dict.keys { OOP --> unpinThenApplyStoredForces( fs_dict[node]!, node ) }

		return [:]
	} /* Called in update() */
}
