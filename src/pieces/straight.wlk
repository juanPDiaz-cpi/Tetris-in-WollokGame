import wollok.game.*
import directions.*
import tetris.*

class Straight inherits Tetrimino {
	const property cube0 = new BasicT(position = game.at(3,18), main = true)
	const property cube1 = new BasicT(position = game.at(4,18), main = false)
	const property cube2 = new BasicT(position = game.at(5,18), main = false)
	const property cube3 = new BasicT(position = game.at(6,18), main = false)
	//var property basicTs = [cube0, cube1, cube2, cube3]
	var property rotation = rotation0
	
	override method rotateLeft() {
		//if(rotation.canRotate(cube0, cube1, cube2, cube3)) {
			rotation = rotation.nextRotation()
			rotation.reposition(cube0, cube1, cube2, cube3)
			console.println("rotateLeft" + rotation.toString())
			//basicTs.forEach({ cube => cube.rotateVertex })
		//}
	}
	
	override method rotateRight() {}
	
	override method move(dir) {
		if(self.canMove(dir)) {
			basicTs.forEach({ basicT => basicT.move(dir) })
		}
	}
	
	override method canMove(dir) {
		return rotation.canMove(dir, cube0, cube1, cube2, cube3)
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
	method allCanMove(dir, cube0, cube1, cube2, cube3) {
		return dir.canMove(cube0) &&
			   dir.canMove(cube1) &&
			   dir.canMove(cube2) &&
			   dir.canMove(cube3)
	}
	
	method canRotate(cube0, cube1, cube2, cube3) {
		return true
	}
}

object rotation0 inherits Rotation {
	method canMove(dir, cube0, cube1, cube2, cube3) {
		if(dir == right) {
			return right.canMove(cube3)
		} else if(dir == left) {
			return left.canMove(cube0)
		} else {
			return self.allCanMove(down, cube0, cube1, cube2, cube3)
		}
	}
	
	method nextRotation() {
		return rotation1
	}
	
	method reposition(cube0, cube1, cube2, cube3) {
		console.println(cube0.height().toString())
		cube3.position(cube3.position().up(2))
		cube3.position(cube3.position().right(1))
		
		cube2.position(cube2.position().up(1))
		
		cube1.position(cube1.position().left(1))
		
		cube0.position(cube0.position().left(2))
		cube0.position(cube0.position().down(1))
	}
}

object rotation1 inherits Rotation {
	method canMove(dir, cube0, cube1, cube2, cube3) {
		if(dir == right) {
			return self.allCanMove(dir, cube0, cube1, cube2, cube3)
		} else if(dir == left) {
			return self.allCanMove(dir, cube0, cube1, cube2, cube3)
		} else {
			return down.canMove(cube0)
		}
	}
	
	method reposition(cube0, cube1, cube2, cube3) {
		console.println(cube0.height().toString())
		cube3.position(cube3.position().left(2))
		cube3.position(cube3.position().up(1))

		cube2.position(cube2.position().left(1))

		cube1.position(cube1.position().down(1))

		cube0.position(cube0.position().down(2))
		cube0.position(cube0.position().right(1))
	}

	method nextRotation() {
		return rotation2
	}
}

object rotation2 inherits Rotation {
	method canMove(dir, cube0, cube1, cube2, cube3) {
		if(dir == right) {
			return right.canMove(cube0)
		} else if(dir == left) {
			return left.canMove(cube3)
		} else {
			return self.allCanMove(down, cube0, cube1, cube2, cube3)
		}
	}
	
	method nextRotation() {
		return rotation3
	}
	
	method reposition(cube0, cube1, cube2, cube3) {
		console.println(cube0.height().toString())
		cube3.position(cube3.position().down(2))
		cube3.position(cube3.position().left(1))
		
		cube2.position(cube2.position().down(1))
		
		cube1.position(cube1.position().right(1))
		
		cube0.position(cube0.position().right(2))
		cube0.position(cube0.position().up(1))
	}
}

object rotation3 inherits Rotation {
	method canMove(dir, cube0, cube1, cube2, cube3) {
		if(dir == right) {
			return self.allCanMove(dir, cube0, cube1, cube2, cube3)
		} else if(dir == left) {
			return self.allCanMove(dir, cube0, cube1, cube2, cube3)
		} else {
			return down.canMove(cube3)
		}
	}
	
	method nextRotation() {
		return rotation0
	}
	
	method reposition(cube0, cube1, cube2, cube3) {
		console.println(cube0.height().toString())
		cube3.position(cube3.position().down(1))
		cube3.position(cube3.position().right(2))
		
		cube2.position(cube2.position().right(1))
		
		cube1.position(cube1.position().up(1))
		
		cube0.position(cube0.position().up(2))
		cube0.position(cube0.position().left(1))
	}
}

















