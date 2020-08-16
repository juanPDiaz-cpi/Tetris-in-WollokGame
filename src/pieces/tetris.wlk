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
		//self.autoFall()
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
			const downPos = self.position().down(1)
			
			if(self.canBeAt(downPos)) {
				self.moveTo(downPos)
			} else {
				self.endAutoFall()
			}
		})
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
		const downPos = self.position().down(1)
		
		if(self.canBeAt(downPos)) {
			self.moveTo(downPos)
			self.goDown()
		} else {
			self.wait()
		}
	}
	
	method canBeAt(pos) {
		return basicTs.all({ b => b.canBeAt(pos) })
	}
	
	method moveTo(pos) {
		basicTs.forEach({ b => b.moveTo(pos) })
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
	
	//(self.cubeMain().height() + self.cubeMain().width() - basicT.height(),	  // Implementación del algoritmo de rotación.
	// self.cubeMain().height() - self.cubeMain().width() + basicT.width())
	
	method nextYPos(centerT) {
		return centerT.height() - centerT.width() + self.height()
	}
	
	method canBeAt(pos) {
		
		return !self.stillOn(game.at(
			(position.x() + pos.x()),
			(position.y() + pos.y())
		)) || self.nothingOn(game.at(
			(position.x() + pos.x()),
			(position.y() + pos.y())))
	}
	
	method nothingOn(pos) {
		return game.getObjectsIn(pos) == []
	}
	
	method moveTo(pos) {
		const diffX = position.x() - pos.x()
		const diffY = position.y() - pos.y()
		
		position = game.at(
			pos.x() - diffX,
			pos.y() - diffY
		)
	}
	
	method stillOn(pos) {
		return game.getObjectsIn(pos) != [] &&
			  !game.getObjectsIn(pos).head().moving()
	}
}

object noPiece {	
	method goDown() {}
	method rotateLeft() {}
	method rotateRight() {}
	method add() {}
	method endAutoFall() {}
}