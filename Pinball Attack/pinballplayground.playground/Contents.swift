//: Playground - noun: a place where people can play

// BATTLE CATS!!

var global: Any

private let globalName = "Flufferton"
let fps: Any = ()
typealias FPS = Any

prefix operator <*{}
prefix func <*<T>(inout l: T) {  }

postfix operator *>{}
postfix func *><T>(r: T) -> T {	return r }

infix operator ->>{}
func ->><T>(inout l: T, r: T){
	l = r
}

/// Says meow:
struct Cat {

	// Field:
	let
	age: Int,
	name: String,
	rockets: Int, // Our kitty is srsbznz... been wraned..
	lives: Int,
	
	// Battle!!

	damage_to_give: Int,
	damage_to_take: Int,
	damage_left: Int,
	status: String
	
	let AP = 40
	let DEF = 20
	let MAXHP = 50
	
	// Meth:
	func fireRocket(at target_cat: Cat) -> Cat {
		let damtogive = (self.AP - target_cat.DEF)
		let rock_ets = (self.rockets - 1)
		
		return Cat(fromOldCat: self, rockets: rock_ets, damage_to_give: damtogive)
	}
	
	func takeDamage(from that_cat: Cat) -> Cat {
		let damtaken = that_cat.damage_to_give
		let damleft = (self.damage_left - damtaken)
		
		// returners:
		let damleft2: Int
		let li_ves: Int
		let sta_tus: String
		
		if damleft <= 0 {
			damleft2 = self.MAXHP
			li_ves = (self.lives - 1)
			li_ves == 0 ? (sta_tus = "Dead") : (sta_tus = "Alive")
		}
			
		else {
			damleft2 = damleft
			li_ves = self.lives
			sta_tus = "Alive"
		}
		
		return Cat(fromOldCat: self, lives: li_ves, damage_left: damleft2, status: sta_tus)
	}
	
	// FP transformation:
	init(fromOldCat oc: Cat, age: Int? = nil, name: String? = nil, rockets: Int? = nil, lives: Int? = nil, damage_to_give: Int? = nil, damage_to_take: Int? = nil, damage_left: Int? = nil, status: String? = nil) {
		
		// Basics:
		age ==  nil ? 		(self.age = oc.age)   : (self.age = age!)
		name == nil ? 		(self.name = oc.name) : (self.name = name!)
		rockets == nil ?	(self.rockets = oc.rockets) : (self.rockets = rockets!)
		lives == nil ? 		(self.lives = oc.lives) : (self.lives = lives!)
		
		// Battle:
		if damage_to_give == nil { self.damage_to_give = oc.damage_to_give}
		 else { self.damage_to_give = damage_to_give! }
		
		if damage_to_take == nil { self.damage_to_take = oc.damage_to_take }
		 else { self.damage_to_take = oc.damage_to_take }
		
		damage_left == nil ? (self.damage_left = oc.damage_left) : (self.damage_left = damage_left!)
		status == nil ? (self.status = oc.status) : (self.status = status!)
	}
	
	init() { age = 5; name = ""; rockets = 5; lives = 9; damage_to_give = 0; damage_to_take = 0; damage_left = self.MAXHP; status = "Alive"}
	
}

// List of Cats:

/// Holds our cats:
struct CatList {
	
	private static var list = CatList(defaults: 0)
	
	// Known cats:
	let fluffy: Cat
	let kitty:  Cat
	let boots:  Cat
	
	// Unknown cats (random battles):
	let uk_cats: [Cat]

	// Default: (protected)
	private init(defaults: Int) {
		fluffy = Cat()
		kitty = Cat(fromOldCat: fluffy, age: 34, name: "Kitty")
		boots = Cat(fromOldCat: kitty, name: "Boots")
		
		uk_cats = []
	}
	
	init(oldList ol1: CatList = CatList.list, fluffy: Cat? = nil, kitty: Cat? = nil, boots: Cat? = nil, uk_cats: [Cat]? = nil) { let ol = CatList.list
		// Inits:
		
		fluffy == nil ?  (self.fluffy = ol.fluffy ) : (self.fluffy = fluffy!)
		kitty == nil ?   (self.kitty = ol.kitty ) : ( self.kitty = kitty! )
		boots == nil ? 	 (self.boots = ol.boots ) : (self.boots = boots! )
		uk_cats == nil ? (self.uk_cats = ol.uk_cats) : (self.uk_cats = uk_cats! )
	}
}

var clist = CatList()

// Combat:

enum Attacks { case fireRocket
	func becomeFunc(atk: Cat, vic: Cat) -> ()->(Cat) {
		switch self {
		case fireRocket:
			return {atk.fireRocket(at: vic)}
		}
	}
}

func doCombat(attacker: Cat, _ y: Attacks, at victim: Cat) -> (attacker: Cat, victim: Cat) {
	
	let attack = y.becomeFunc(attacker, vic: victim)
	let defend = { victim.takeDamage(from: attacker) }
	
	// Combat
	//attacker ->> attack()
	//victim ->> defend()
	
	print(victim.damage_left)
	
	return (attack(), defend())
}

	// Testing
let boots = clist.boots
let fluffy = clist.fluffy

let results = doCombat(boots, .fireRocket, at: fluffy)
clist = CatList(boots: results.attacker)





