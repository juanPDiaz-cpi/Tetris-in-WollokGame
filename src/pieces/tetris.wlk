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
			self.findNewPosition(left)
		}
	}
	
	method findNewPosition(dir) {
		self.moveTo(self.findPosition(self.possiblePositions(dir), dir))
	}
	
	method possiblePositions(dir) {
		const possPos = []
		
		if(dir == left) {
			self.addPositions()
		} else {
			
		}
		
		return possPos
	}
	
	method moveTo(pos) {
		const diffX = self.cubeMain().diffX(pos)
		const diffY = self.cubeMain().diffY(pos)
		basicTs.forEach({ b =>
			b.position(game.at(
				b.position().x() - diffX,
				b.position().y() - diffY
			))
		})
	}
	
	method findPosition(possPos, dir) {
		return possPos.findOrElse({ pos => self.canBeAt(pos) }, { dir.opposite().rotate(self) })
	}
	
	method canBeAt(pos) {
		return basicTs.all({ b => b.canBeAt(pos) })
	}
	
	method rotateRight() {
		self.rotateRightS()
		if(self.overlap()) {
			// self.executeTests(right)
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
	
	method testMove(dir) {
		basicTs.forEach({ b => dir.move(b) })
		self.checkOverlap(dir.opposite())
	}
	
	method testMove(n, dir) {
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
	}
	
	method canMove(n, dir) {
		return basicTs.all({ basicT => dir.nothingOn(basicT.position(), n) }) 
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
	
	method diffX(pos) {
		return self.width() - pos.x()
	}
	
	method diffY(pos) {
		return self.height() - pos.y()
	}
	
	method canBeAt(pos) {
		return self.nothingOn(game.at(
			(position.x() - self.diffX(pos)),
			(position.y() - self.diffY(pos))
		))
	}
	
	method nothingOn(pos) {
		return game.getObjectsIn(pos) == []
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