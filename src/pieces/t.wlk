import pieces.tetris.*
import wollok.game.*

class T inherits Tetrimino {
	//const property cube0 = self.basicTs().get(0)
	//const property cube1 = new BasicT(position = game.at(3,19), main = false)
	//const property cube2 = new BasicT(position = game.at(4,18), main = false)
	//const property cube3 = new BasicT(position = game.at(5,19), main = false)
	//var property basicTs = [cube0, cube1, cube2, cube3]
	
	override method rotateLeft() {
		basicTs.forEach({ basicT =>
			basicT.position(game.at
				(self.cubeMain().height() + self.cubeMain().width() - basicT.height(),	  // Implementación del algoritmo de rotación.
				 self.cubeMain().height() - self.cubeMain().width() + basicT.width())
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
		return basicTs.all({ basicT => dir.canMove(basicT) })
		//rotation.canMove(dir, cube0, cube1, cube2, cube3)
	}
	
	/*override method add() {
		basicTs.forEach({ basicT => basicT.add() })
		self.autoFall()
	}*/
	
	override method linesModified() {
		return basicTs.map({ basicT => basicT.height() }).asSet()
	}
	
	override method notMoving() {
		basicTs.forEach({ basicT => basicT.stopMoving() })
	}
}