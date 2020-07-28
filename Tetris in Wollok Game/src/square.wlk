import wollok.game.*
import directions.*
import tetris.*

class Cube inherits Tetrimino {
	const property cube0 = new BasicT(position = game.at(4,18), main = true)
	const property cube1 = new BasicT(position = game.at(5,18), main = false)
	const property cube2 = new BasicT(position = game.at(4,19), main = false)
	const property cube3 = new BasicT(position = game.at(5,19), main = false)
	var property basicTs = [cube0, cube1, cube2, cube3]
	
	override method rotateLeft() {}
	override method rotateRight() {}
	
	override method move(dir) {
		if(self.canMove(dir)) {
			basicTs.forEach({ basicT => basicT.move(dir) })
		}
	}
	
	override method canMove(dir) {
		if(dir == right) {
			return dir.canMove(cube1) &&
				   dir.canMove(cube3)
		} else if(dir == left) {
			return dir.canMove(cube0) &&
				   dir.canMove(cube2)
		} else {
			return dir.canMove(cube0) &&
				   dir.canMove(cube1)
		}
	}
	
	method add() {
		basicTs.forEach({ basicT => basicT.add() })
		self.autoFall()
	}
	
	override method linesModified() {
		return basicTs.map({ basicT => basicT.height() }).asSet()
	}
}