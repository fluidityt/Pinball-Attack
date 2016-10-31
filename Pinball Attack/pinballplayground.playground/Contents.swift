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
	lives: Int
	
	// Meth:
	func fireRocket() -> Cat {return Cat(fromOldCat: self, rockets: (self.rockets - 1))}
	func takeDamage() -> Cat {return Cat(fromOldCat: self, lives: (self.lives - 1))}
		
	// Init:
	init(age: Int, name: String) {
		self.age = age
		self.name = name
		rockets = 5
		lives = 9
		
	}
	
	// FP transformation:
	init(fromOldCat oc: Cat, age: Int? = nil, name: String? = nil, rockets: Int? = nil, lives: Int? = nil) {
		age ==  nil ? (self.age = oc.age)   : (self.age = age!)
		name == nil ? (self.name = oc.name) : (self.name = name!)
		rockets == nil ? (self.rockets = oc.rockets) : (self.rockets = rockets!)
		lives == nil ? (self.lives = oc.lives) : (self.lives = lives!)
	}
	
}

// Testing:
private let fluffy = Cat(age: 4, name: "Fluffy")

let kitty = Cat(fromOldCat: fluffy, age: 34, name: "Kitty")

print(kitty)
print(fluffy)

var boots = Cat(fromOldCat: kitty, name: "Boots")
boots ->> boots.fireRocket()
boots ->> boots.takeDamage()

print(boots)


