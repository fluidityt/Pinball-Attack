import SpriteKit
import UIKit
import Foundation



var gFSDict: [SKNode: [CGVector]?] = [:]

struct FullStopHandler {

	// Inits:

	// See also, gFSDict
	private init() {}
	typealias FSDict = [SKNode: [CGVector]?]

	static func queueForce( next_force: CGVector, node: SKNode, fs_dict: [SKNode: [CGVector]?] )
					-> [SKNode: [CGVector]?] {

		// Check if empty:
		if fs_dict[node] == nil {
			var new_dict = fs_dict as! Zoom.taFullStopDict
			new_dict.updateValue( [next_force], forKey: node )

			return fs_dict
		}

		// Append if not:
		else {
			var new_vector_array = fs_dict[node]!
			new_vector_array!.append( next_force )

			var new_dict = fs_dict
			new_dict.updateValue( new_vector_array, forKey: node )

			return new_dict
		}
	} /*Called in SKPB*/


	static func stop( node: SKNode, fs_dict: [SKNode: [CGVector]?] )
					-> [SKNode: [CGVector]?] {

		guard !node.physicsBody!.pinned else { return fs_dict }

		OOP --> (node.physicsBody?.pinned = true)

		var new_dict = fs_dict
		new_dict.updateValue( nil, forKey: node )

		return new_dict

	} /* Called in SKPB */

	static func handle() {

		// Unpin, then apply any Qd forces:
		if this.stop_dict.count > 0 {

			// Unpin:
			for node in this.stop_dict.keys {
				OOP --> node.physicsBody?.pinned = false

				// Check for forces:
				if this.stop_dict[node] != nil {

					// Apply forces:
					for force in this.stop_dict[node]!! {
						node.physicsBody?.applyForce( force )
					}
				}
			}
			OOP --> this.stop_dict.removeAll()
		}
	} // Called in update
}