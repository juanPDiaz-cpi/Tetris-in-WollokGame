import wollok.game.*
import gameConfig.*
import directions.*
import dataBase.*

object lineChecker {
	const property lines = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]
	const property widths = [0,1,2,3,4,5,6,7,8,9]
	var property linesCleared = []
	
	method checkLines(linesToCheck) {
		linesToCheck.forEach({ line => self.checkLine(line) })
		self.goDownAbove(linesCleared) 							// Baja todos los bloques por encima.
		linesCleared.clear()
	}
	
	method checkLine(number) {
		if(self.isFull(number)) {
			console.println("It should print if the line is full")
			self.clearLine(number) 								// No está funcionando bien
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
				element.move(down)
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










