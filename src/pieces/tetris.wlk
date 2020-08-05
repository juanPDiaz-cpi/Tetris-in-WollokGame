import wollok.game.*
import gameConfig.*
import directions.*
import lines.*
import dataBase.*


class Tetrimino {
	var property basicTs
	
	method rotateLeft() {
		self.rotateLeftS()
		if(self.overlap()) {
			self.executeTests(left)
		}
	}
	
	method rotateRight() {
		self.rotateRightS()
		if(self.overlap()) {
			self.executeTests(right)
		}
	}
	
	method overlap() {
		return basicTs.any({ basicT =>
			self.overlaped(basicT)
		})
	}
	
	method overlaped(basicT) {
		return game.colliders(basicT) != []
	}
	
	method executeTests(dir) {
		if(self.canMove(right)) {
			self.testMove(right)
		} else if(self.canMove(up)) {
			self.testMove(up)
		} else if(self.canMove(left)) {
			self.testMove(left)
		} else if(self.canMove(down)) {
			self.testMove(down)
		} else {
			dir.rotate(self)
		}
	}
	
	method testMove(dir) {
		basicTs.forEach({ b => dir.move(b) })
		self.checkOverlap(dir.opposite())
	}
	
	method checkOverlap(dir) {
		if(self.overlap()) {
			basicTs.forEach({ b => dir.move(b) })
		}
	}
	
	method rotateRightS() {
		basicTs.forEach({ basicT =>
			basicT.position(game.at
				(self.cubeMain().height() + self.cubeMain().width() - basicT.height(),
				self.cubeMain().height() - self.cubeMain().width() + basicT.width())
			)		
		})
	}
	
	method rotateLeftS() {
		basicTs.forEach({ basicT =>
			basicT.position(game.at
			   (self.cubeMain().width() - self.cubeMain().height() + basicT.height(),
				self.cubeMain().height() + self.cubeMain().width() - basicT.width())
			)		
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
		//&& basicT.inLimits() })
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
	var property moving
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