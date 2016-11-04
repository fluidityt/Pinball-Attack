//: Playground - noun: a place where cats can play (with rockets).

/* BATTLE CATS!!

Conventions:
	
	camelCase:
		- Global Mutable:		gGlobalName
		- External Pram:		pramName
		- Labels:						labelName
		-	Named Closures: 	closureName()
		- Enum Case:				caseName
	
	CamelCase:
		- Struct/Type:			ClassName
	
	under_score:
		- Locals:						local_name
		- Parameter:				pram_name
	
	UPPERCASE:
		- Constant Fields
			(Non-transform): 	FIELDNAME
		- Global Constant:	gCONSTANT
	
Methods:
	- Pass 'self' implicitly (to reduce verbosity, etc.)
		I still consider this pure, though not referentailly transparent
		IMO, since explicitly passing	in an instance of Cat type 
		may not always yeild 'self:'
		Since the function will not work without 'self', this is a
		no-brainer to me.
	
	- Sub-functions may not always pass outer-pram for
		verbose reasons ( see matchName() )

Goal:
	- To make a single, mutable var 'cat list';
		this list contains immutable Cat instanaces.

Structs:
	- Cat instances transform via constructor with
		default-parameters; a passed in "Old Cat" pram
		is used to copy from.
		
		All methods use this "Old Cat" to "update" self,
		via passing in 'self' implicitly,	then returning a 
		new instance with only the specified	data in the 
		pram as transformed 
		
		All others are copied from "Old Cat" which is usually just 'self'.

	- CatList is to be used as a singleton, but is handled i
		in a similar way to Cat--but currently CatList
		has no methods (it is a data structure).
	
	- Battle is a static func-struct (no fields),
		and is used to make updating our CatList instance
		easier / less verbose.

TODO: 
	- Make more enums (alive, dead, etc)
	- Implement random battles (unnamed cats)
	- Test performance
	- Make unit tests
	- Clean up documentation

*/


/// Says meow... OR fires a rocket at your face:
struct Cat {
	
	/* Enum: */
	
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
	
	
	/* Inits: */
	
	/// Default init:
	init(_name: String) { age = 5; name = _name; rockets = 5; lives = 9; dmg_to_give = 0; hp = self.MAXHP; status = "Alive"}
	
	/// Call for FP transformation:
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
	
	
	/* Methods: */  // NOTE: All methods pass 'self' into parameter implicitly (pseudo-pure).
	
	/// Calculates damage to give (from $0's DEF), then stores it in own field:
	func fireRocket(at victim: Cat) -> Cat {
		let dmg_to_give2 = (self.AP - victim.DEF)
		let rockets2 = (self.rockets - 1)
		
		return Cat(fromOldCat: self, rockets: rockets2, dmg_to_give: dmg_to_give2)
	}
	
	/// Decreases own HP from value stored in other cat, then updates
	func takeDamage(from attacker: Cat) -> Cat {
		
		// Returners:
		let hp2: Int
		let lives2: Int
		let status2: String

		assignmentLogic: do {
			
			let dmg_taken = attacker.dmg_to_give
			let dam_left = (self.hp - dmg_taken)
			
			if dam_left <= 0 {
				hp2 = self.MAXHP
				lives2 = (self.lives - 1)
				lives2 == 0 ? (status2 = "Dead") : (status2 = "Alive")
			}
				
			else {
				hp2 = dam_left
				lives2 = self.lives
				status2 = "Alive"
			}
		}
		
		return Cat(fromOldCat: self, hp: hp2, lives: lives2, status: status2 )
	}
	
	
	func readyForNextBattle(/* Uses 'self'*/) -> Cat {
		return Cat(fromOldCat: self, dmg_to_give: 0, hp: 0)
	}
	
	

} //</cat>


/* List of Cats: */

/// Holds our cats:
struct CatList {
	
	// TODO: Enum.case.rawValue seemed too verbose in the constructor, but Enum would be ideal..
	struct Names { static let fluffy="Fluffy", kitty="Kitty", boots="Boots"}
	
	// Known cats:
	let fluffy: Cat
	let kitty:  Cat
	let boots:  Cat
	
	// Unknown cats (random battles): // TODO: Implement random battles with unnamed cats
	let uk_cats: [Cat]

	// Default: (protected):
	private init(defaults: Int) {
		fluffy = Cat(_name: Names.fluffy)
		kitty = Cat(fromOldCat: fluffy, age: 34, name: Names.kitty)
		boots = Cat(fromOldCat: kitty, name: Names.boots)
		
		uk_cats = []
	}
	
	// Add named cats here:
	init(ol: CatList, fluffy: Cat? = nil, kitty: Cat? = nil, boots: Cat? = nil, uk_cats: [Cat]? = nil) {
		// Inits:
	
		fluffy == nil  ? (self.fluffy = ol.fluffy)   : (self.fluffy = fluffy!)
		kitty == nil   ? (self.kitty = ol.kitty)  	 : (self.kitty = kitty!)
		boots == nil   ? (self.boots = ol.boots)  	 : (self.boots = boots!)
		uk_cats == nil ? (self.uk_cats = ol.uk_cats) : (self.uk_cats = uk_cats!)
	}
}


/* GLOBAL: */

/// Instance to pass around:
var gCatList = CatList(defaults: 1)


/* Combat funk */

/** Static / abstract struct (func only):
 
		gCatList = Battle.start(handleResults(doCombat()))
*/
struct Battle {
	
	/// 1v1 Combatants:
	typealias Combatants = (attacker: Cat, victim: Cat)
	
	/// Makes doCombat (defined next) more Englishy / fun, by pairing an enum to a 1v1 Cat.method()
	enum Attacks {
		
		case fires1Rocket
		
		func becomeFunc(combatants: Combatants) -> ()->(Cat) {
			let attacker = combatants.attacker
			let victim  = combatants.victim
			switch self {
			case fires1Rocket:
				return { attacker.fireRocket( at: victim) }
			}
		}
	}
	
	/// Returns two new cats after battling.. Use them to update your CatList:
	private static func doCombat(attacker: Cat, _ const: Attacks, at victim: Cat) -> Combatants {
		
		// New funcs that make a new Cat each:
		let attacked = const.becomeFunc((attacker, victim))
		let victimized = { victim.takeDamage(from: attacked()) }
		
		return (attacker: attacked(), victim: victimized())
	}
	
	/// Mutates our gCatList automagically with the battle results:
	private static func handleResults(battled_cats battled_cats: Combatants, fromInitial list: CatList)	-> CatList {
		
		// Returner method:
		func matchName(this_cat: (name: String, is_attacker: Bool),
		               updateFrom list2: CatList)
			-> CatList {
				
				// Returner:
				let new_cat: Cat
				
				// Logic1:
				this_cat.is_attacker ?
					(new_cat = battled_cats.attacker) : (new_cat = battled_cats.victim)
				
				// Logic2:
				typealias n=CatList.Names
				switch this_cat.name {
					case n.boots:  return CatList (ol: list2, boots: new_cat)
					case n.fluffy: return CatList (ol: list2, fluffy: new_cat)
					case n.kitty:  return CatList (ol: list2, kitty: new_cat)
						
					// Induce crash:
					default: print("error cant find cat"); let error: CatList? = nil; return error!
				}
		}
		
		//	matchName(results.attacker.name, is_attacker: true, list2: list).boots.damage_to_give
		let attacker2 = (name: battled_cats.attacker.name, is_attacker: true)
		let victim2 	=	(name: battled_cats.victim.name, 	 is_attacker: false)
		
		// Attacker must present dmg_to_give to victim (takeDamage())--attacker must be processed first (on the right)
		return matchName( victim2, updateFrom: (matchName(attacker2, updateFrom: list)) )
	}
	
/** Brings it all together (in reverse order):
		
		gCatList = (start ->  handleResults -> doCombat)
*/
	internal static func start(combatants: Combatants, initialList gcat_list: CatList = gCatList) -> CatList {
		let attacker = combatants.attacker
		let victim = combatants.victim
		return handleResults(battled_cats: doCombat(attacker, .fires1Rocket, at: victim), fromInitial: gcat_list)
	}
}

// Makes transformation more obvious than '=' operator.. lhs 'does' rhs (transforms into):
infix operator ->>{}; func ->> <T> (inout l: T, r: T) { l = r }

// MARK: TESTING 2:
aBattleTest: do {
	
	// For testing purposes:
	var boots2 = gCatList.boots, fluffy2 = gCatList.fluffy
	
	// Very verbose way:
	boots2->>boots2.fireRocket(at: fluffy2)
	fluffy2->>fluffy2.takeDamage(from: boots2)
	
	// Verbose way:
	let test_attacker = gCatList.boots
	let test_victim = gCatList.fluffy
	let between_combatants = (test_attacker, test_victim)
	gCatList = Battle.start(between_combatants)
	
	// Non-verbose way:
	gCatList = Battle.start((attacker: gCatList.boots, victim: gCatList.fluffy))
	
	// Super non-verbose way:
	gCatList = Battle.start((gCatList.boots, gCatList.fluffy))
	
	// Working:
	print(gCatList.fluffy.lives)
}





