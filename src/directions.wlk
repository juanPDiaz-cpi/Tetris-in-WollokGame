import wollok.game.*
import gameConfig.*

class Direction {
	method move(element)
	method canMove(element)
	method thereIsBasicTStill(element)
}

object down inherits Direction {
	
	override method move(element) {
		element.position(element.position().down(1))
	}
	
	override method canMove(element) {
		return element.height() > gameConfig.heightMin() &&
			  !self.thereIsBasicTStill(element)
	}
	
	override method thereIsBasicTStill(element) {
		return game.getObjectsIn(element.position().down(1)) != [] &&
			  !game.getObjectsIn(element.position().down(1)).head().moving()
			   //true
			   // se puede mover si:
			   //	- no hay nada
			   //	- hay algo que se mueve
	}
}

object left inherits Direction {
	
	override method move(element) {
		element.position(element.position().left(1))
	}
	
	override method canMove(element) {
		return element.width() > gameConfig.widthMin() &&
			  !self.thereIsBasicTStill(element)
	}
	
	override method thereIsBasicTStill(element) {
		return game.getObjectsIn(element.position().left(1)) != [] &&
			  !game.getObjectsIn(element.position().left(1)).head().moving()
	}
}

object right inherits Direction {
	
	override method move(element) {
		element.position(element.position().right(1))
	}
	
	override method canMove(element) {
		return element.width() < gameConfig.widthMax() &&
			  !self.thereIsBasicTStill(element)
	}
	
	override method thereIsBasicTStill(element) {
		return game.getObjectsIn(element.position().right(1)) != [] &&
			  !game.getObjectsIn(element.position().right(1)).head().moving()
	}
}









