import wollok.game.*
import directions.*
import tetris.*
import gameConfig.*

class Straight inherits Tetrimino {
	/*var property cube0 = basicTs.get(0)
	var property cube1 = basicTs.get(1)
	var property cube2 = basicTs.get(2)
	var property cube3 = basicTs.get(3)*/
	var property rotation = rotation0
	
	override method rotateLeft() {
		//if(rotation.canRotate(cube0, cube1, cube2, cube3)) {
			rotation = rotation.nextRotation()
			rotation.reposition(basicTs)
			console.println("rotateLeft" + rotation.toString())
		//}
	}
	
	override method rotateRight() {}
	
	override method move(dir) {
		if(self.canMove(dir)) {
			basicTs.forEach({ basicT => basicT.move(dir) })
		}
	}
	
	override method add() {
		basicTs.forEach({ basicT => basicT.add() })
		self.autoFall()
	}
	
	override method linesModified() {
		return basicTs.map({ basicT => basicT.height() }).asSet()
	}
}

class Rotation {
	method reposition(basicTs)
	method nextRotation()
}

object rotation0 inherits Rotation {
	
	override method reposition(basicTs) {
		const cube0 = basicTs.get(0)
		const cube1 = basicTs.get(1)
		const cube2 = basicTs.get(2)
		const cube3 = basicTs.get(3)
		
		cube3.position(cube3.position().up(2))
		cube3.position(cube3.position().right(1))
		
		cube2.position(cube2.position().up(1))
		
		cube1.position(cube1.position().left(1))
		
		cube0.position(cube0.position().left(2))
		cube0.position(cube0.position().down(1))
	}
	
	override method nextRotation() {
		return rotation1
	}
}

object rotation1 inherits Rotation {
	
	override method reposition(basicTs) {
		const cube0 = basicTs.get(0)
		const cube1 = basicTs.get(1)
		const cube2 = basicTs.get(2)
		const cube3 = basicTs.get(3)
		
		console.println(cube0.height().toString())
		cube3.position(cube3.position().left(2))
		cube3.position(cube3.position().up(1))

		cube2.position(cube2.position().left(1))

		cube1.position(cube1.position().down(1))

		cube0.position(cube0.position().down(2))
		cube0.position(cube0.position().right(1))
	}

	override method nextRotation() {
		return rotation2
	}
}

object rotation2 inherits Rotation {
	
	override method reposition(basicTs) {
		const cube0 = basicTs.get(0)
		const cube1 = basicTs.get(1)
		const cube2 = basicTs.get(2)
		const cube3 = basicTs.get(3)
		
		console.println(cube0.height().toString())
		cube3.position(cube3.position().down(2))
		cube3.position(cube3.position().left(1))
		
		cube2.position(cube2.position().down(1))
		
		cube1.position(cube1.position().right(1))
		
		cube0.position(cube0.position().right(2))
		cube0.position(cube0.position().up(1))
	}
	
	override method nextRotation() {
		return rotation3
	}
}

object rotation3 inherits Rotation {
	
	override method reposition(basicTs) {
		const cube0 = basicTs.get(0)
		const cube1 = basicTs.get(1)
		const cube2 = basicTs.get(2)
		const cube3 = basicTs.get(3)
		
		console.println(cube0.height().toString())
		cube3.position(cube3.position().down(1))
		cube3.position(cube3.position().right(2))
		
		cube2.position(cube2.position().right(1))
		
		cube1.position(cube1.position().up(1))
		
		cube0.position(cube0.position().up(2))
		cube0.position(cube0.position().left(1))
	}
	
	override method nextRotation() {
		return rotation0
	}
}

















