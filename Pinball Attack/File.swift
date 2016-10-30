import SpriteKit
import UIKit



var gFullStop = FullStopHandler.full_stop_instance

struct FullStopHandler {
	typealias this = FullStopHandler;

	private static var full_stop_instance = FullStopHandler

	private init () {} // protected

	let stop_dict: [SKNode: [CGVector]?] = [:]

	var z = "hi"
	static func queueForce ( next_force: CGVector, to node: SKNode, FP object: FullStopHandler )
					-> FullStopHandler {

		// Check if empty:
		if this.stop_dict[node] == nil {
			var new_dict = object.stop_dict
			return this ( stop_dict: new_dict.stop_dict.updateValue ( [next_force], forKey: node )
		}

		// Append if not:
		else {
			var forceQ = this.stop_dict[node]!
			forceQ!.append ( next_force )
			OOP --> this.stop_dict.updateValue ( forceQ!, forKey: node )
		}
	} // Called in SKPB

	static func stop ( node: SKNode ) {
		if node.physicsBody?.pinned == false {
			return
		}
		else {
			node.physicsBody?.pinned = true
			/* Reset the pinned status on next frame ( .handle() )*/
			OOP --> this.stop_dict.updateValue ( nil, forKey: node )
		}
	} // Called in SKPB

	static func handle () {

		// Unpin, then apply any Qd forces:
		if this.stop_dict.count > 0 {

			// Unpin:
			for node in this.stop_dict.keys {
				node.physicsBody?.pinned = false

				// Check for forces:
				if this.stop_dict[node] != nil {

					// Apply forces:
					for force in this.stop_dict[node]!! {
						node.physicsBody?.applyForce ( force )
					}
				}
			}
			OOP --> this.stop_dict.removeAll ()
		}
	} // Called in update
}