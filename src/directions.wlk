import wollok.game.*
import gameConfig.*

class Direction {
	method move(element)
	method canMove(element)
}

object down inherits Direction {
	
	override method move(element) {
		element.position(element.position().down(1))
	}
	
	override method canMove(element) {
		return element.height() > gameConfig.heightMin() &&
			   game.getObjectsIn(element.position().down(1)) == []
	}	
}

object left inherits Direction {
	
	override method move(element) {
		element.position(element.position().left(1))
	}
	
	override method canMove(element) {
		return element.width() > gameConfig.widthMin() &&
			   game.getObjectsIn(element.position().left(1)) == []
	}
}

object right inherits Direction {
	
	override method move(element) {
		element.position(element.position().right(1))
	}
	
	override method canMove(element) {
		return element.width() < gameConfig.widthMax() &&
			   game.getObjectsIn(element.position().right(1)) == []
	}	
}









