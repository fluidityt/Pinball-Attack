import SpriteKit
import UIKit



var gFSDict: [SKNode: [CGVector]?] = [:]

struct FullStopHandler {

	// Inits:
	// See also, gFSDict, and FullStopDict
	typealias FullStopDict = [SKNode: [CGVector]?]
	private init() {}

	static func queueForce( next_force: CGVector, to node: SKNode, FP fs_dict: [SKNode: [CGVector]?] )
					-> [SKNode: [CGVector]?] {

		// Check if empty:
		if fs_dict[node] == nil {
			var new_dict = fs_dict
			new_dict.updateValue( [next_force], forKey: node )

			return fs_dict
		}

		// Append if not:
		else {
			var new_vector_array = fs_dict[node]!
			new_vector_array!.append( next_force )
			
			var new_dict = fs_dict
			new_dict.updateValue(new_vector_array, forKey: node)
			
			return new_dict
		}
	} /*Called in SKPB*/

	static func stop( node: SKNode ) {
		if node.physicsBody?.pinned == false {
			return
		}
		else {
			node.physicsBody?.pinned = true
			OOP --> this.stop_dict.updateValue( nil, forKey: node )
		}
	} // Called in SKPB

	static func handle() {

		// Unpin, then apply any Qd forces:
		if this.stop_dict.count > 0 {

			// Unpin:
			for node in this.stop_dict.keys {
				node.physicsBody?.pinned = false

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