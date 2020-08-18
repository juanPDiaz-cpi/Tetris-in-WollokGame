import wollok.game.*
import rotationsys.*
import gameConfig.*
import lines.*
import dataBase.*


class Tetrimino {
	var property rotation = 0
	var property basicTs
	
	method position() { return self.cubeMain().position() }
	
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
		self.tickFall()
	}
	
	method wait() {
		gameConfig.tetrinomiun(noPiece)
		game.schedule(gameConfig.actualTime(), {})
	}
	
	method cubeMain() {
		return basicTs.find({ basicT => basicT.main() })
	}
	
	method tickFall() {		
		game.onTick(gameConfig.actualTime(), "autoFall", { self.autoFall() })
	}
	
	method autoFall() {
		if(self.canBeAt(self.position().down(1))) {
			self.moveTo(self.position().down(1))
		} else {
			self.endAutoFall()
		}
	}
	
	method endAutoFall() {
		game.removeTickEvent("autoFall")
		lineChecker.checkLines(self.linesModified())
		gameConfig.newElement()
		self.stopMoving()
	}
	
	method stopMoving() {
		basicTs.forEach({ basicT => basicT.stopMoving() })
	}
	
	method goDown() {	
		
		if(self.canBeAt(self.position().down(1))) {
			self.moveTo(self.position().down(1))
			self.goDown()
		} else {
			self.wait()
		}
	}
	
	method canBeAt(pos) {

		const x = pos.x() - self.cubeMain().width()
		const y = pos.y() - self.cubeMain().height()
				
		return basicTs.all({ b => b.canChangePos(x, y) })
	}
	
	method moveTo(pos) {
		const valueX = pos.x() - self.cubeMain().width()
		const valueY = pos.y() - self.cubeMain().height()
		
		basicTs.forEach({ b => b.moveTo(valueX, valueY) })
	}
	
	method moveIfPossible(pos) {
		
		if(self.canBeAt(pos)) {
			self.moveTo(pos)
		}
	}

	method linesModified() {
		return basicTs.map({ basicT => basicT.height() }).asSet()
	}
}

class BasicT {
	const property main
	var property position
	var property moving
	var property color
	
	method image() { 
		return "basicT" + color + ".png"
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
	
	method nextYPos(centerT) {
		return centerT.height() - centerT.width() + self.height()
	}
	
	method canChangePos(x, y) {
		
		return self.thereIsSomethingMovingOn(game.at(
			(position.x() + x),
			(position.y() + y)
		)) || !self.thereIsSomethingOn(game.at(
			(position.x() + x),
			(position.y() + y)))
	}
	
	method moveTo(x, y) {
		position = game.at(
			position.x() + x,
			position.y() + y
		)
	}
	
	method moveTo(pos) {
		position = pos
	}
	
	method thereIsSomethingOn(pos) {
		return game.getObjectsIn(pos) != []
	}
	
	method thereIsSomethingMovingOn(pos) {
		return self.thereIsSomethingOn(pos) &&
			   game.getObjectsIn(pos).head().moving()			// Re-do this
	}
}

object noPiece {	
	method goDown() {}
	method rotateLeft() {}
	method rotateRight() {}
	method add() {}
	method endAutoFall() {}
}