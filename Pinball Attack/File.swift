
import SpriteKit

// ***************************** \\
class Pinball {
	
	enum Size: CGFloat {
		
		case small, normal, large
		
		func toRadius(scene: SKScene = gScene!, c: ConBall = ConBall()) -> CGFloat {
			switch self {
			case .small:  return (scene.frame.width / c.small )
			case .normal:	return (scene.frame.width / c.normal)
			case .large:  return (scene.frame.width / c.large )
			}
		}
	}
	
	// IA Fields:
	let radius: CGFloat
	let node: SKShapeNode
	
	init(size: Pinball.Size, scene: SKScene = gScene!) {
		
		// Sudden death round is ultra-multiball madness!
		self.radius = size.toRadius()
		self.node = SKShapeNode(circleOfRadius: self.radius);_=node
			.position = scene.center;_=node
				.fillColor = SKColor.blueColor()
		
		scene.addChild(self.node)
		
		
	}
}

// ***************************** \\
class Flipper: SKSpriteNode {
	required init?(coder aDecoder: NSCoder) {		fatalError("")	}
	static func notes()	{
		// FLipper size is 1/4 of width
	}
	
	// Enums:
	enum Flip {
		enum State { case down, up }
		enum Side { case left, right }
		enum Player { case top, bottom }
	}
	
	// IA Fields:
	let player: Flip.Player
	let side: Flip.Side
	
	// MA Fields:
	var power: CGFloat
	var state: Flip.State
	
	// Init:
	init(side: Flip.Side, player: Flip.Player, ball: Pinball, scene: SKScene = gScene!, c: ConFlip = ConFlip()) {
		
		inits: do {
			
			self.side = side
			self.player = player
			self.state = .down
			self.power = c.power
			
			super.init(texture: SKTexture(),
			           color: SKColor.blueColor(),
			           size: CGSize(width: c.width,	height: c.height))
			scene.addChild(self)
		}
		
		setAnchor: do {
			switch self.side {
			case .left:
				self.anchorPoint.x = 0
				self.anchorPoint.y = self.frame.midY
			case .right:
				self.anchorPoint.x = 1
				self.anchorPoint.y = self.frame.midY
			}
		}
		
		setPositions: do {
			let gap = (ball.radius * c.gap_factor)
			
			if self.player == Flip.Player.bottom {
				switch side {
				case .left:
					self.position.y = (scene.frame.minY + c.offset)
					self.position.x = (scene.frame.midX - (self.frame.width + gap))
				case .right:
					self.position.y = (scene.frame.minY + c.offset)
					self.position.x = (scene.frame.midX + (self.frame.width + gap))
				}
			}
				
			else if self.player == Flip.Player.top {
				switch side {
				case .left:
					self.position.y = (scene.frame.maxY - c.offset)
					self.position.x = (scene.frame.midX - (self.frame.width + gap))
				case .right:
					self.position.y = (scene.frame.maxY - c.offset)
					self.position.x = (scene.frame.midX + (self.frame.width + gap))
				}
			}
		}
	}/* /init */
}

// ***************************** \\
struct Player {
	
	let flipper: (left: Flipper, right: Flipper)
	
	var score: Int
	
	init(player: Flipper.Flip.Player, ball: Pinball) {
		self.flipper.left = Flipper(side: .left, player: player, ball: ball)
		self.flipper.right = Flipper(side: .right, player: player, ball: ball)
		self.score = 0
	}
}


