import wollok.game.*
import gameConfig.*
import directions.*
import lines.*
import dataBase.*


class Tetrimino {
	const property posibleTs = [0]
	var property basicTs
	
	method rotateLeft()
	method rotateRight()
	method linesModified()
	method canMove(dir)
	method move(dir)
	method notMoving()
	
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
	
	method goDown() {
		if(self.canMove(down)) {
			self.move(down)
			self.goDown()
		} else {
			self.wait()
		}
	}
	
		
}

class BasicT {
	const property main
	var property position
	var property moving = true
	var property color = "Blue"
	
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
}

object noPiece {	
	method move(dir) {}
	method goDown() {}
	method rotateLeft() {}
	method rotateRight() {}
	method add() {}
}