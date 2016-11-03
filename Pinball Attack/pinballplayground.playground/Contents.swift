//: Playground - noun: a place where cats can play (with rockets).

// BATTLE CATS!!

// TODO: Make more enums (alive, dead, etc)
/// Says meow... OR fires a rocket at your face:
struct Cat {
	
	/* Fields: */

	// Transformable:
	let
	age: Int,
	name: String,
	rockets: Int, // Our kitty is srsbznz... bin' warn3d..
	lives: Int,
	status: String,

	dmg_to_give: Int,
	hp: Int
	
	// Constants:
	let AP = 40
	let DEF = 20
	let MAXHP = 50
	
	
	/* Methods: */
	
	/// Calculates damage to give (from $0's DEF), then stores it in own field:
	func fireRocket(at victim: Cat) -> Cat {
		let dmg_to_give2 = (self.AP - victim.DEF)
		let rockets2 = (self.rockets - 1)
		
		return Cat(fromOldCat: self, rockets: rockets2, dmg_to_give: dmg_to_give2)
	}
	
	/// Decreases own HP from value stored in other cat, then updates
	func takeDamage(from attacker: Cat) -> Cat {
		
		// Returners:
		let dmg_left2: Int
		let lives2: Int
		let status2: String

		assignmentLogic: do {
			
			let dmg_taken = attacker.dmg_to_give
			let dam_left = (self.hp - dmg_taken)
			
			if dam_left <= 0 {
				dmg_left2 = self.MAXHP
				lives2 = (self.lives - 1)
				lives2 == 0 ? (status2 = "Dead") : (status2 = "Alive")
			}
				
			else {
				dmg_left2 = dam_left
				lives2 = self.lives
				status2 = "Alive"
			}
		}
		
		return Cat(fromOldCat: self, lives: lives2, dmg_left: dmg_left2, status: status2)
	}
	
	func resetDamages() -> Cat {
		return Cat(fromOldCat: self, dmg_to_give: 0, hp: 0)
	}
	
	
	/* Inits: */
	
	/// Default init:
	init(_name: String) { age = 5; name = _name; rockets = 5; lives = 9; dmg_to_give = 0; hp = self.MAXHP; status = "Alive"}
	
	/// FP transformation:
	init(fromOldCat oc: Cat,
	                age: Int? = nil,
	                name: String? = nil,
	                rockets: Int? = nil,
	                lives: Int? = nil,
	                
	                dmg_to_give: Int? = nil,
	                hp: Int? = nil,
	                status: String? = nil) {
	
		// Basics:
		age ==  nil 	 ? 	(self.age = oc.age)   			: (self.age = age!)
		name == nil 	 ? 	(self.name = oc.name) 			: (self.name = name!)
		rockets == nil ?	(self.rockets = oc.rockets) : (self.rockets = rockets!)
		lives == nil 	 ? 	(self.lives = oc.lives) 		: (self.lives = lives!)
		status == nil  ?	(self.status = oc.status) 	: (self.status = status!)
		
		// Battle:
		hp == nil 	 	 ?  (self.hp = oc.hp) 					:(self.hp = hp!)
		dmg_to_give == nil ? (self.dmg_to_give = oc.dmg_to_give):(self.dmg_to_give = dmg_to_give!)
	}
} //</cat>


/* List of Cats: */

/// Holds our cats:
struct CatList {
	
	struct Names { static let fluffy="Fluffy", kitty="Kitty", boots="Boots"}
	
	// Known cats:
	let fluffy: Cat
	let kitty:  Cat
	let boots:  Cat
	
	// Unknown cats (random battles):
	let uk_cats: [Cat]

	// Default: (protected)
	private init(defaults: Int) {
		fluffy = Cat(_name: Names.fluffy)
		kitty = Cat(fromOldCat: fluffy, age: 34, name: Names.kitty)
		boots = Cat(fromOldCat: kitty, name: Names.boots)
		
		uk_cats = []
	}
	
	init(ol: CatList, fluffy: Cat? = nil, kitty: Cat? = nil, boots: Cat? = nil, uk_cats: [Cat]? = nil) {
		// Inits:
	
		fluffy == nil ?  (self.fluffy = ol.fluffy ) : (self.fluffy = fluffy!)
		kitty == nil ?   (self.kitty = ol.kitty ) : ( self.kitty = kitty! )
		boots == nil ? 	 (self.boots = ol.boots ) : (self.boots = boots! )
		uk_cats == nil ? (self.uk_cats = ol.uk_cats) : (self.uk_cats = uk_cats! )
	}
}


/* GLOBAL: */

/// Instance to pass around:
var gCatList = CatList(defaults: 1)

// Combat:

enum Attacks { case fireRocket
	func becomeFunc(atk atk: Cat, vic: Cat) -> ()->(Cat) {
		switch self {
		case fireRocket:
			return {atk.fireRocket(at: vic)}
		}
	}
}

func doCombat(attacker: Cat, _ y: Attacks, at victim: Cat) -> (attacker: Cat, victim: Cat) {
	let attacked = y.becomeFunc(atk: attacker, vic: victim)
	let victimized = { victim.takeDamage(from: attacked()) }
	
	return (attacked(), victimized())
}

func handleResults(list: CatList = gCatList,
                   results: (attacker: Cat, victim: Cat))
 -> CatList {
	
	func matchName(combatant: (name: String, is_attacker: Bool),
	               list2UpdateFrom: CatList)
		-> CatList {
			
			let new_cat: Cat
			combatant.is_attacker ? (new_cat = results.attacker) : (new_cat = results.victim)
			
			
			typealias n=CatList.Names
			
			switch combatant.name {
			case n.boots: return CatList(ol: list2UpdateFrom, boots: new_cat)
			case n.fluffy: return CatList(ol: list2UpdateFrom, fluffy: new_cat)
			case n.kitty: return CatList(ol: list2UpdateFrom,  kitty: new_cat)
			default: print("error cant find cat"); let error: CatList? = nil; return error!
			}
			
		
	}
	
	//	matchName(results.attacker.name, is_attacker: true, list2: list).boots.damage_to_give
	let attacker2 = (results.attacker.name, true)
	let victim2 = (results.victim.name, false)
	
	return matchName(victim2, list2UpdateFrom: (matchName(attacker2, list2UpdateFrom: list )))
}

// MARK: TESTING 2:

gCatList = handleResults(results: doCombat(gCatList.boots, .fireRocket, at: gCatList.fluffy))

print(gCatList.fluffy.dmg_left)





