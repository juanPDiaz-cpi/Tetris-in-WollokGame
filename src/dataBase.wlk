import wollok.game.*

object dataBase {
	var property objsSaved = []
	
	method clearGame() {
		objsSaved.forEach({ element =>  
			objsSaved.remove(element)
			game.removeVisual(element)
		})
	}
	
	method add(obj) {
		objsSaved.add(obj)
	}
	
	method removeWidths(num) {
		objsSaved.forEach({ element =>
			if(element.width() == num) {
				objsSaved.remove(element)
			}
		})
	}
	
	method remove(element) {
		objsSaved.remove(element)
	}
	
	method removeLine(number) {
		objsSaved.forEach({ element =>
			if(element.height() == number) {
				game.removeVisual(element)
				objsSaved.remove(element)
			}
		})
	}
}
