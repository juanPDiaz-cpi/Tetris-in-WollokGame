import wollok.game.*
import gameConfig.*
import dataBase.*

object lineChecker {
	const property lines = (0..19)
	const property widths = (0..9)
	var property linesCleared = []
	
	method checkLines(linesToCheck) {
		linesToCheck.forEach({ line => self.checkLine(line) })
		self.goDownAbove(linesCleared) 							// Baja todos los bloques por encima.
		linesCleared.clear()
	}
	
	method checkLine(number) {
		if(self.isFull(number)) {
			console.println("It should print if the line is full")
			self.clearLine(number)
			self.addLineCleared(number)
		}
	}
	
	method addLineCleared(number) {
		linesCleared.add(number - linesCleared.size())	
	}
	
	method goDownAbove(linesToClear) {
		linesCleared.forEach({ line =>
			console.println(line.toString() + " hi")
			self.goDownEveryT(line)
			console.println("goDownAbove")
		})
	}
	
	method goDownEveryT(num) {
		dataBase.objsSaved().forEach({ element =>
			if(element.height() > num) {
				console.println("goDownEveryT")
				element.moveTo(element.position().down(1))
			}
		})	
	}
	
	method isFull(number) {
		return
			widths.all({
				n => self.hasVisualIn(game.at(n, number))
			})
	}
	
	method hasVisualIn(position) {
		return game.getObjectsIn(position).size() != 0
	}
	
	method clearLine(number) {
		dataBase.removeLine(number)
	}
}










