import wollok.game.*
import directions.*
import tetris.*

class Cube inherits Tetrimino {
	
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