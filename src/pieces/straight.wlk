import wollok.game.*
import tetris.*
import gameConfig.*
import rotationsys.*

class Straight inherits Tetrimino {
	
	override method rotateCW() {
		self.rotateCWS()
		self.adjust(self.cwOffSetX(rotation), self.cwOffSetY(rotation))
		rotationSys.executeRotationTestsCW(self)
	}
	
	override method rotateACW() {
		self.rotateACWS()
		self.adjust(self.acwOffSetX(rotation), self.acwOffSetY(rotation))
		rotationSys.executeRotationTestsACW(self)
	}
	
	method adjust(valueX, valueY) {
		console.println("x = " + valueX)
		console.println("y = " + valueY)
		
		self.moveTo(
			game.at(valueX, valueY)
		)
	}
		
	// Math functions that determine the offSet value in function of the rotation number of the tetrimino.
	// Clockwise
	method cwOffSetX(number) { return (number - 2).abs() - 1 }
	
	method cwOffSetY(number) { return (number - 1).abs() - 1 }
	
	// Counter-clockwise	
	method acwOffSetX(number) { return - (number - 1).abs() + 1 }
	
	method acwOffSetY(number) { return (number - 2).abs() - 1 }
}








