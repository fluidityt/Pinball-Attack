//: Playground - noun: a place where people can play

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
	damage_to_take: Int
	
	
	// Meth:
	func fireRocket() -> Cat {return Cat(fromOldCat: self, rockets: (self.rockets - 1))}
	func takeDamage() -> Cat {return Cat(fromOldCat: self, lives: (self.lives - 1))}
	
	// FP transformation:
	init(fromOldCat oc: Cat, age: Int? = nil, name: String? = nil, rockets: Int? = nil, lives: Int? = nil, damage_to_give: Int? = nil, damage_to_take: Int? = nil) {
		
		// Basics:
		age ==  nil ? (self.age = oc.age)   : (self.age = age!)
		name == nil ? (self.name = oc.name) : (self.name = name!)
		rockets == nil ? (self.rockets = oc.rockets) : (self.rockets = rockets!)
		lives == nil ? (self.lives = oc.lives) : (self.lives = lives!)
		
		// Battle:
		if damage_to_give == nil { self.damage_to_give = oc.damage_to_give}
		else { self.damage_to_give = damage_to_give! }
		
		if damage_to_take == nil { self.damage_to_give = oc.damage_to_take }
		else { self.damage_to_take = oc.damage_to_take }
	}
	
}

// Testing:
private let fluffy = Cat()

let kitty = Cat(fromOldCat: fluffy, age: 34, name: "Kitty")

print(kitty)
print(fluffy)

var boots = Cat(fromOldCat: kitty, name: "Boots")

boots ->> boots.fireRocket()

boots ->> boots.takeDamage()

print(boots)


