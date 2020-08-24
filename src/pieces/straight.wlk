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
		self.moveTo(
			game.at(valueX, valueY)
		)
	}
		
	// Math functions that determine the offSet value in function of the rotation number of self.
	// Clockwise
	method cwOffSetX(number) { return (number - 2).abs() - 1 }
	
	method cwOffSetY(number) { return (number - 1).abs() - 1 }
	
	// Counter-clockwise	
	method acwOffSetX(number) { return - (number - 1).abs() + 1 }
	
	method acwOffSetY(number) { return (number - 2).abs() - 1 }
	
	
	// Math functions that determine the x position in function of the rotation number of self.
	method f(x, y) {
		return (self.g(y) - self.t(y)*self.h(x))*self.s(x)
	}
	
	method g(x) {
		return ((5*x/2) - (x**3)/2)
	}
	
	method t(x) {
		return x*(3 - x**2)/2
	}
	
	method h(x) {
		return 1 - (x%2)
	}
	
	method s(x) {
		return (3 - 2*x).abs() - 2
	}
}








