//: Playground - noun: a place where cats can play (with rockets).

/* BATTLE CATS!! Fed up with being "cutified," one faction of furry-
   friends has decided to destroy all servers and the  Internet!! 
							
   Tech-loving felines across the globe have
   taken up arms to protect their fame, fortune, and 
   web-based addiction. Choose your side, load up, and
   BATTLE WITH CATS!!!

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
	
Methods / Funcs:
	- Are non-mutating, pass in a value, and always return a value.
		However, named closures do not necessarily return a value 
		or pass in data (they are convenience).

	- Pass 'self' implicitly (to reduce verbosity, etc.)
		I still consider this pure, though not referentailly transparent
		IMO, since explicitly passing	in an instance of Cat type 
		may not always yeild 'self:'
		Since the function will not work without 'self', this is a
		no-brainer to me.
	
	- Sub-functions may not always pass outer-pram for
		verbose reasons ( see matchName() )

	- Data used in the 'return' call or logic expressions
		are usually declared and commented as "Returners" wih no value;
		the subsequent `logicLabel do:' will assign the value.

	
Goal:
	- To make a single, mutable var 'cat list';
		this list contains immutable Cat instanaces that can battle one another.

Structs:
	- 'Cat' instances transform via constructor with
		default-parameters; a passed in "Old Cat" pram
		is used to copy from. 

		This is a psuedo-oop struct, but with FP principles.
		
		All methods use "Old Cat" pram to "update" self via
		passing in 'self' implicitly,	then returning a
		new instance with only the specified	data in the 
		pram as transformed 
		
		All non-specified prams will be copied from "Old Cat" automatically.
		This makes transforming just one value simple and clean via default prams.

	- 'CatList' is to be used as a singleton, but is handled
		in a similar way to Cat--but currently CatList
		has no methods (it is a data structure).
	
	- 'Battle' is not necessary, but was created to make handling CatList and Cat
		more easily and less verbosely. It is a "static func-struct" (no fields);
		essentially a "utility class" from Java, etc.

TODO: 
	- Make more enums (alive, dead, etc)
	- Implement random battles (unnamed cats)
	- Test performance
	- Make unit tests (not assertions)
	- Pull some code in from the far-right side
	- Remove some of the code from funcs in Battle;
		they are too simple or only used once.
	- Figure out a better way to reset a Cat's dmgToGive..
	- DONE: Convert '///' into '/** */' ... Add #Usage callouts

NOTE:
	- No, I'm wasn't high when I made this (or ever for that matter).
	- No, I don't wish cats to fight with each other IRL.
	- Yes, many, MANY, virtual cats were harmed in the making 
		of this program ;)
*/



/** Says meow... Then fires a rocket at your face: */
struct Cat {

	
/* Enums: */
	
	// TODO: Add enooms for Faction, Status, etc.
	
	
/* Fields: */

	// Transformable:
	let	age: 				 Int,
			name: 			 String,
			rockets: 		 Int, // Our kitty is srsbznz... bin' warn3d..
			lives: 			 Int,
			status: 		 String,
			hp: 			   Int,
			dmg_to_give: Int
	
	// Constants:
	let AP 		= 40,
		  DEF 	= 20,
			MAXHP = 50
	
	// Name Closures:
	let meow = { print($0) }
	
	
/* Inits: */
	
		/// Default init for new cat. Use 'init(fromOldCat:)' to transform.
		init(newCatWithName _name: String) {
			age = 5; name = _name; rockets = 5; lives = 9;
			dmg_to_give = 0; hp = self.MAXHP; status = "Alive"
			
			meow("  Nyaa! Watashi wa \(self.name) desu~!") // Purrrr...
		}
	
		/// Call for FP transformation:
		init(fromOldCat oc: 				 Cat,
										age: 				 Int? 	 = nil,
										name: 			 String? = nil,
										rockets:		 Int? 	 = nil,
										lives: 			 Int?		 = nil,
										status:			 String? = nil,
										hp: 				 Int?    = nil,
										dmg_to_give: Int? 	 = nil) {
		
			// Basics:
			age 		== nil 	 ? 	(self.age 		= oc.age)   	: (self.age = age!)
			name 		== nil 	 ? 	(self.name 		= oc.name) 		: (self.name = name!)
			rockets == nil 	 ?	(self.rockets = oc.rockets) : (self.rockets = rockets!)
			lives 	== nil 	 ? 	(self.lives 	= oc.lives) 	: (self.lives = lives!)
			status 	== nil   ?	(self.status 	= oc.status) 	: (self.status = status!)
			hp 			== nil 	 ?  (self.hp 			= oc.hp) 			:	(self.hp = hp!)
			
			// Battle:
			dmg_to_give == nil ? (self.dmg_to_give = oc.dmg_to_give):(self.dmg_to_give = dmg_to_give!)
			
			// New cat purrs...
			if (self.name != oc.name) { meow("  Nyaa! Watashi wa \(self.name) desu~!") }
		}
	
	
/* Methods: */  // NOTE: All methods pass 'self' into parameter "implicitly" (pseudo-pure).
	
/** Calculates damage to give (from $0's DEF), then stores it in own field:
	
	cat1 = cat1.fireRocket(at: cat2)
*/
	func fireRocket(at victim: Cat) -> Cat {
		
		// Returners:
		let dmg_to_give2 = (self.AP - victim.DEF)
		let rockets2 		 = (self.rockets - 1)
		
		// TODO: Add a self.rockets check before firing a rocket
		return Cat(fromOldCat: self, rockets: rockets2, dmg_to_give: dmg_to_give2)
	}


/** Decreases own HP from value stored in other cat, then updates

	cat2 = cat2.takeDamage(from: cat1)
*/
	func takeDamage(from attacker: Cat) -> Cat {
		
		// Returners:
		let hp2: 		 Int,
				lives2:  Int,
			  status2: String

		assignmentLogic: do {
			
			// Logic fodder:
			let dmg_taken = attacker.dmg_to_give
			let dam_left  = (self.hp - dmg_taken)
			
			// Our cat dies:
			if dam_left <= 0 {
				hp2 	 = self.MAXHP
				lives2 = (self.lives - 1)
				
				lives2 == 0 ? (status2 = "Dead") : (status2 = "Alive")
			}
			
			// Our cat lives:
			else {
				hp2 	  = dam_left
				lives2  = self.lives
				status2 = "Alive"
			}
		}
		
		return Cat(fromOldCat: self, hp: hp2, lives: lives2, status: status2 )
	}
	
	
/** Needs to called after attacking cat uses a .attack().
	
	cat1 = cat1.readyForNextBattle()
*/
	func readyForNextBattle(/* Uses 'self'*/) -> Cat {
		return Cat(fromOldCat: self, dmg_to_give: 0)
	}
	
	// End of Cat />
}


/* List of Cats: */

/// Holds our cats:
struct CatList {
	
	// TODO: Enum.case.rawValue seemed too verbose in the constructor, but Enum would be ideal..
	struct Names { static let fluffy="Fluffy", kitty="Kitty", boots="Boots"}
	
	// Known cats:
	let fluffy: Cat,
			kitty:  Cat,
			boots:  Cat
	
	// Unknown cats (random battles): 		// TODO: Implement random battles with unnamed cats
	let uk_cats: [Cat]

	// Default: (protected):
	private init(defaults: Int) {
		fluffy = Cat( newCatWithName: 				  Names.fluffy )
		kitty  = Cat( fromOldCat: fluffy, name: Names.kitty  )
		boots  = Cat( fromOldCat: kitty , name: Names.boots  )
		
		uk_cats = [] 												// TODO: Something with this..
	}
	
	// Add named cats here:
	init(ol: CatList, fluffy: Cat? = nil, kitty: Cat? = nil, boots: Cat? = nil, uk_cats: [Cat]? = nil) {
		fluffy  == nil ? (self.fluffy  = ol.fluffy)  : (self.fluffy  = fluffy! )
		kitty   == nil ? (self.kitty   = ol.kitty) 	 : (self.kitty   = kitty!  )
		boots   == nil ? (self.boots   = ol.boots)   : (self.boots   = boots!  )
		uk_cats == nil ? (self.uk_cats = ol.uk_cats) : (self.uk_cats = uk_cats!)
	}
}


/* GLOBAL: */

/// Instance to pass around:
var gCatList: CatList


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
	
	
/** Returns two new cats after battling.. Use them to update your CatList:
	
		results = doCombat()
*/
	private static func doCombat(attacker: Cat, _ const: Attacks, at victim: Cat) -> Combatants {
		
		// New func that make a new Cat:
		let attacker2: ()->(Cat) = const.becomeFunc((attacker, victim))
		
		// Returners
		let that_attacked:		   Cat = attacker2().readyForNextBattle()
		let that_was_victimized: Cat = victim.takeDamage(from: attacker2())
		
		return (attacker: that_attacked, victim: that_was_victimized)
	}
	
	
/** Mutates our gCatList automagically with the battle results:

		updated_cat_list = handleResults()
*/
	private static func handleResults(battled_cats battled_cats: Combatants,
																	 fromInitial   list:				 CatList)
		-> CatList {
		
		// Returner method:
		func matchName(this_cat:			  (name: String, is_attacker: Bool),
		               updateFrom list2: CatList
								/* battled_cats:	   Combatants */)
			-> CatList {
				
				// Returner:
				let new_cat: Cat
				
				// Logic1:
				this_cat.is_attacker ?
					(new_cat = battled_cats.attacker) : (new_cat = battled_cats.victim)
				
				// Logic2:
				typealias n=CatList.Names
				switch this_cat.name {
					case n.boots:  return CatList (ol: list2, boots:  new_cat)
					case n.fluffy: return CatList (ol: list2, fluffy: new_cat)
					case n.kitty:  return CatList (ol: list2, kitty:  new_cat)
					default: fatalError("cant find cat's name. Should use an Enum")
				}
		}
		
		// Returners:
		let attacker2 = (name: battled_cats.attacker.name, is_attacker: true)
		let victim2 	=	(name: battled_cats.victim.name  , is_attacker: false)
			
		// Attacker must present 'dmg_to_give' to victim;
		// therefore, attacker must be processed first (on the right):
		return matchName( victim2, updateFrom: (matchName(attacker2, updateFrom: list)) )
	}
	
	
/** Brings all private funcs together (in reverse order):
	
#### usage:
		gCatList = (start -> handleResults -> doCombat)

- NOTE:
 Reads from global in default pram for convenience (no mutate):
*/
	internal static func start(combatants: 						Combatants,
	                           initialList gcat_list: CatList = gCatList)
		-> CatList {
		
			let attacker = combatants.attacker
			let victim 	 = combatants.victim
		
			return handleResults(battled_cats: doCombat( attacker, .fires1Rocket, at: victim ),
													 fromInitial: gcat_list)
	}
}


/* TESTING: */

// Makes transformation more obvious than '=' operator.. lhs 'does' rhs (transforms into):
infix operator ->>{}; func ->> <T> (inout l: T, r: T) { l = r }


// Tests 1 - 4. Nyan and Fluffy are the Victims:
aBattleTests: do {
	
	let victim_hp = "Victim's HP after battle (should be 30): "
	let assertHP30 = { assert(gCatList.fluffy.hp == 30, "Failed") }
	
	test1: do {
		
		// Without 'Battle' or 'CatList': 3+SLOC vs 1SLOC for tests 2-4
		print("Test1: No Battle struct or CatList struct:")
		var mittens = Cat(newCatWithName: "Mittens")
		var nyan		= Cat(newCatWithName: "Nyan")
		
		mittens->>mittens.fireRocket(at: nyan)
		nyan->>nyan.takeDamage(from: mittens)
		mittens->>mittens.readyForNextBattle()
		
		assert(nyan.hp == 30, "Failed")
		print(victim_hp, nyan.hp, "\n")
	}
	
	test2: do {
		
		// Most verbose way (but has most clarity / readability):
		print("Test2: Verbose Battle Struct:")
		gCatList = CatList(defaults: 1)
		
		let test_attacker 		 = gCatList.boots
		let test_victim 			 = gCatList.fluffy
		let between_combatants = (test_attacker, test_victim)
		gCatList->>Battle.start(between_combatants)
		
		assertHP30()
		print(victim_hp, gCatList.fluffy.hp, "\n")
	}
	
	test3: do {
		
		// Verbose way:
		print("Test3: ")
		gCatList = CatList(defaults: 1)
		gCatList->>Battle.start((attacker: gCatList.boots, victim: gCatList.fluffy))
		
		assertHP30()
		print(victim_hp, gCatList.fluffy.hp, "\n")
	}
	
	test4: do	{
		
		// Least verbose way: (force error)
		print("Test4: Assertion Failure:")
		gCatList = CatList(defaults: 0)
		gCatList->>Battle.start((gCatList.boots, gCatList.boots))
		
		assertHP30()
		print(victim_hp, gCatList.fluffy.hp, "\n")
	}
}





