import wollok.game.*
import rotationsys.*
import gameConfig.*
import directions.*
import lines.*
import dataBase.*


class Tetrimino {
	var property rotation = 0
	var property basicTs
	
	method rotateCW() {
		self.rotateCWS()
		rotationSys.executeRotationTestsCW(self)
	}
	
	method rotateACW() {
		self.rotateACWS()
		rotationSys.executeRotationTestsACW(self)
	}
	
	
	method rotateCWS() {
		basicTs.forEach({ basicT =>
			basicT.position(game.at
			   (self.cubeMain().width() - self.cubeMain().height() + basicT.height(),
				self.cubeMain().height() + self.cubeMain().width() - basicT.width())
			)
		})
		self.increaseRotation()
	}
	
	method rotateACWS() {
		basicTs.forEach({ basicT =>
			basicT.position(game.at
				(self.cubeMain().height() + self.cubeMain().width() - basicT.height(),
				self.cubeMain().height() - self.cubeMain().width() + basicT.width())
			)
		})
		self.decreaseRotation()
	}
	
	method increaseRotation() {
		console.println(rotation)
		rotation = (rotation + 1)%(4)
		console.println("Done: new rotation is " + rotation.toString())
	}
	
	method decreaseRotation() {
		console.println(rotation)
		rotation = (rotation + 3)%(4)
		console.println("Done: new rotation is " + rotation.toString())
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
	
	method canBeAt(pos) {
		return basicTs.all({ b => b.canBeAt(pos.x(), pos.y()) })
	}
	
	method moveTo(pos) {
		basicTs.forEach({ b => b.moveTo(pos.x(), pos.y()) })
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
	
	//(self.cubeMain().height() + self.cubeMain().width() - basicT.height(),	  // Implementación del algoritmo de rotación.
	// self.cubeMain().height() - self.cubeMain().width() + basicT.width())
	
	method nextYPos(centerT) {
		return centerT.height() - centerT.width() + self.height()
	}
	
	method canBeAt(valueX, valueY) {
		
		return !self.stillOn(game.at(
			(position.x() + valueX),
			(position.y() + valueY)
		)) || self.nothingOn(game.at(
			(position.x() + valueX),
			(position.y() + valueY)))
	}
	
	method nothingOn(pos) {
		return game.getObjectsIn(pos) == []
	}
	
	method moveTo(valueX, valueY) {
		position = game.at(
			(position.x() + valueX),
			(position.y() + valueY)
		)
	}
	
	method stillOn(pos) {
		return game.getObjectsIn(pos) != [] &&
			  !game.getObjectsIn(pos).head().moving()
	}
}

object noPiece {	
	method move(dir) {}
	method goDown() {}
	method rotateLeft() {}
	method rotateRight() {}
	method add() {}
	method endAutoFall() {}
}