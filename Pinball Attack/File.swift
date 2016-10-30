import SpriteKit
import UIKit



var gFullStop = FullStopHandler.full_stop_instance // hi

struct FullStopHandler {

	// Inits:
	private static var full_stop_instance = FullStopHandler
	let stop_dict: [SKNode: [CGVector]?]
	private init() {} // protected
	typealias this = FullStopHandler;

	static func queueForce( next_force: CGVector, to node: SKNode, FP object: FullStopHandler )
					-> FullStopHandler {

		// Check if empty:
		if object.stop_dict[node] == nil {
			var new_dict = object.stop_dict
			return this( stop_dict: new_dict.updateValue( [next_force], forKey: node ) )
		}

		// Append if not:
		else {
			var forceQ = this.stop_dict[node]!
			forceQ!.append( next_force )
			OOP --> this.stop_dict.updateValue( forceQ!, forKey: node )
		}
	} // Called in SKPB

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