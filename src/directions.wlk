import wollok.game.*
import gameConfig.*
import pieces.tetris.*

class Direction {
	method move(element)
	method thereIsBasicTStill(element)
	method canMove(element)
	method opposite()
}

object down inherits Direction {
	
	override method opposite() { return up }

	override method move(element) {
		element.position(element.position().down(1))
	}
	
	override method canMove(element) {
		return !self.thereIsBasicTStill(element)
	}
	
	override method thereIsBasicTStill(element) {
		return game.getObjectsIn(element.position().down(1)) != [] &&
			  !game.getObjectsIn(element.position().down(1)).head().moving()
	}
}

object left inherits Direction {

	override method opposite() { return right }
	
	override method move(element) {
		element.position(element.position().left(1))
	}
	
	override method canMove(element) {
		return !self.thereIsBasicTStill(element)
	}
	
	override method thereIsBasicTStill(element) {
		return game.getObjectsIn(element.position().left(1)) != [] &&
			  !game.getObjectsIn(element.position().left(1)).head().moving()
	}
	
	method rotate(tetrimino) {
		tetrimino.rotateRightS()
	}
}

object right inherits Direction {
	
	override method opposite() { return left }

	override method move(element) {
		element.position(element.position().right(1))
	}
	
	override method canMove(element) {
		return !self.thereIsBasicTStill(element)
	}
	
	override method thereIsBasicTStill(element) {
		return game.getObjectsIn(element.position().right(1)) != [] &&
			  !game.getObjectsIn(element.position().right(1)).head().moving()
	}
	
	method rotate(tetrimino) {
		tetrimino.rotateLeftS()
	}
}

object up inherits Direction {
	
	override method opposite() { return down }

	override method move(element) {
		element.position(element.position().up(1))
	}
	
	override method canMove(element) {
		return !self.thereIsBasicTStill(element)
	}
	
	override method thereIsBasicTStill(element) {
		return game.getObjectsIn(element.position().up(1)) != [] &&
			  !game.getObjectsIn(element.position().up(1)).head().moving()
	}
}




