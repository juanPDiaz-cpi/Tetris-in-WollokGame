import wollok.game.*
import gameConfig.*
import directions.*
import lines.*
import dataBase.*


class Tetrimino {
	var property basicTs
	
	method rotateRight() {
		basicTs.forEach({ basicT =>
			basicT.position(game.at
			   (self.cubeMain().width() - self.cubeMain().height() + basicT.height(),	  // Implementación del algoritmo de rotación.
				self.cubeMain().height() + self.cubeMain().width() - basicT.width())
			    //(basicT.nextXPos(self.cubeMain()),
				//basicT.nextYPos(self.cubeMain()))
			)		
		})
	}
	
	method rotateLeft() {
		if(self.canRotateL()) {
			basicTs.forEach({ basicT =>
				basicT.position(game.at
					(self.cubeMain().height() + self.cubeMain().width() - basicT.height(),	  // Implementación del algoritmo de rotación.
					self.cubeMain().height() - self.cubeMain().width() + basicT.width())
				     //(basicT.nextXPos(self.cubeMain()),
					//basicT.nextYPos(self.cubeMain()))
				)		
			})
		}
	}
	
	method canRotateL() {
		return basicTs.all({ basicT =>
			self.nothingOn(game.at(basicT.nextXPos(self.cubeMain()), basicT.nextYPos(self.cubeMain()))) &&
			basicT.nextXPos(self.cubeMain()) >= gameConfig.widthMin() &&
			basicT.nextXPos(self.cubeMain()) <= gameConfig.widthMax() &&
			basicT.nextYPos(self.cubeMain()) >= gameConfig.heightMin()
		})
	}
	
	method nothingOn(pos) {
		return game.getObjectsIn(pos) == []
	}
	
	method add() {
		basicTs.forEach({ basicT => basicT.add() })
		self.autoFall()
	}
	
	method wait() {
		gameConfig.tetrinomiun(noPiece)
		game.schedule(gameConfig.actualTime(), {})
	}
	
	method cubeMain() {
		return basicTs.find({ basicT => basicT.main() })
	}
	
	method autoFall() {
		game.onTick(gameConfig.actualTime(), "autoFall", { 
			if(self.canMove(down)) {
				self.move(down)
			} else {
				self.endAutoFall()
			}
			//console.println("running?")
			//console.println("Width: " + width.toString())
		})
	}
	
	method endAutoFall() {
		game.removeTickEvent("autoFall")
		lineChecker.checkLines(self.linesModified())
		gameConfig.newElement()
		self.notMoving()
	}
	
	method notMoving() {
		basicTs.forEach({ basicT => basicT.stopMoving() })
	}
	
	method goDown() {
		if(self.canMove(down)) {
			self.move(down)
			self.goDown()
		} else {
			self.wait()
		}
	}
	
	method canMove(dir) {
		return basicTs.all({ basicT => dir.canMove(basicT) })
	}
	
	method move(dir) {
		if(self.canMove(dir)) {
			basicTs.forEach({ basicT => basicT.move(dir) })
		}
	}

	method linesModified() {
		return basicTs.map({ basicT => basicT.height() }).asSet()
	}
}

class BasicT {
	const property main
	const property centerId = null
	var property position
	var property moving = true
	var property color
	
	method image() { 
		return "basicT" + color + ".png"
	}
	
	method move(dir) {
		dir.move(self)
	}
	
	method add() {
		game.addVisual(self)
		dataBase.add(self)
	}
	
	method width() {
		return position.x()
	}
	
	method height() {
		return position.y()
	}
	
	method stopMoving() {
		moving = false
	}
	
	method nextXPos(centerT) {
		return centerT.height() + centerT.width() - self.height()
	}
	
	//(self.cubeMain().height() + self.cubeMain().width() - basicT.height(),	  // Implementación del algoritmo de rotación.
	// self.cubeMain().height() - self.cubeMain().width() + basicT.width())
	
	method nextYPos(centerT) {
		return centerT.height() - centerT.width() + self.height()
	}
}

object noPiece {	
	method move(dir) {}
	method goDown() {}
	method rotateLeft() {}
	method rotateRight() {}
	method add() {}
}