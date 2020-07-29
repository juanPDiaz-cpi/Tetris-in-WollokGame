import wollok.game.*
import directions.*
import tetris.*

class Cube inherits Tetrimino {
	const property cube0 = new BasicT(position = game.at(4,18), main = true)
	const property cube1 = new BasicT(position = game.at(5,18), main = false)
	const property cube2 = new BasicT(position = game.at(4,19), main = false)
	const property cube3 = new BasicT(position = game.at(5,19), main = false)
	//var property basicTs = [cube0, cube1, cube2, cube3]
	
	override method rotateLeft() {}
	override method rotateRight() {}
	
	override method move(dir) {
		if(self.canMove(dir)) {
			basicTs.forEach({ basicT => basicT.move(dir) })
		}
	}
	
	override method canMove(dir) {
		return basicTs.all({ basicT => dir.canMove(basicT) })
	}
	
	override method linesModified() {
		return basicTs.map({ basicT => basicT.height() }).asSet()
	}
}