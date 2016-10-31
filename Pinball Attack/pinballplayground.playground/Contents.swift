//: Playground - noun: a place where people can play

private let globalName = "Flufferton"

/// Says meow:
struct Cat {
	
	// Ooper convenience:
	var lastCat: Any = Cat(age: 3, name: "")
	mutating func islastCat(lc: Cat) { lastCat = lc }
	
	// Field:
	let
	age: Int,
	name: String,
	num_rockets: Int
	
	
	
	// Init:
	init(age: Int, name: String) {
		self.age = age
		self.name = name
		num_rockets = 5
	}
	
	// FP transformation:
	init(fromOldCat oc: Cat, age: Int? = nil, name: String? = nil) {
		age ==  nil ? (self.age = oc.age)   : (self.age = age!)
		name == nil ? (self.name = oc.name) : (self.name = name!)
		
		num_rockets = oc.num_rockets
		//self.islastCat(<#T##lc: Cat##Cat#>)
	}
	
}

// Testing:
private let fluffy = Cat(age: 4, name: "Fluffy")

let kitty = Cat(fromOldCat: fluffy, age: 34)

print(kitty)
print(fluffy)



