
struct FullStopHandler {
    typealias this = FullStopHandler;

    private init() {} // protected

    private static var stop_dict: [SKNode: [CGVector]?] = [:]
    // protected

    static func queueForce(next_force: CGVector, to node: SKNode) {

        // Check if empty:
        if this.stop_dict[node] == nil {
            OOP --> this.stop_dict.updateValue([next_force], forKey: node)
        }

        // Append if not:
        else {
            var forceQ = this.stop_dict[node]!
            forceQ!.append(next_force)
            OOP --> this.stop_dict.updateValue(forceQ!, forKey: node)
        }
    } // Called in SKPB

    static func stop(node: SKNode) {
        if node.physicsBody?.pinned == false {
            return
        } else {
            node.physicsBody?.pinned = true
            /* Reset the pinned status on next frame ( .handle() )*/
            OOP --> this.stop_dict.updateValue(nil, forKey: node)
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
                        node.physicsBody?.applyForce(force)
                    }
                }
            }
            OOP --> this.stop_dict.removeAll()
        }
    } // Called in update
}