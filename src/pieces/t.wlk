import pieces.tetris.*
import wollok.game.*

class T inherits Tetrimino {
	const property cube0 = new BasicT(position = game.at(4,19), main = true)
	const property cube1 = new BasicT(position = game.at(3,19), main = false)
	const property cube2 = new BasicT(position = game.at(4,18), main = false)
	const property cube3 = new BasicT(position = game.at(5,19), main = false)
	var property basicTs = [cube0, cube1, cube2, cube3]
	
	override method rotateLeft() {
		basicTs.forEach({ basicT =>
			//const tmpWidth = basicT.width()
			basicT.position(game.at
				(cube0.height() + cube0.width() - basicT.height(),	  // Implementación del algoritmo de rotación.
				 cube0.height() - cube0.width() + basicT.width())
			)		
		})
	}
	
	override method rotateRight() {}
	
	override method move(dir) {
		if(self.canMove(dir)) {
			basicTs.forEach({ basicT => basicT.move(dir) })
		}
	}
	
	override method canMove(dir) {
		return true //rotation.canMove(dir, cube0, cube1, cube2, cube3)
	}
	
	override method add() {
		basicTs.forEach({ basicT => basicT.add() })
		self.autoFall()
	}
	
	override method linesModified() {
		return basicTs.map({ basicT => basicT.height() }).asSet()
	}
}