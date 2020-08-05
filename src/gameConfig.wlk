import pieces.pieces.*
import wollok.game.*
import pieces.tetris.*
import directions.*
import lines.*
import pieces.straight.*
import pieces.square.*

object gameConfig {
	const property widthMin = 0
	const property widthMax = 9
	const property heightMin = 0
	var property actualTime = 250
	
	var property tetrinomiun = pieces.random()
	
	method start() {
		self.keys()
		self.setSettings()
	}
	
	method keys() {
		keyboard.left().onPressDo({ tetrinomiun.move(left) })
		keyboard.right().onPressDo({ tetrinomiun.move(right) })
		keyboard.down().onPressDo({ tetrinomiun.move(down) })
		keyboard.space().onPressDo({ tetrinomiun.goDown() })
		keyboard.z().onPressDo({ tetrinomiun.rotateLeft() })
		keyboard.x().onPressDo({ tetrinomiun.rotateRight() })
	}
	
	method setSettings() {
		console.println("running?")
		tetrinomiun.add()
	}
	
	method newElement() {
		tetrinomiun = pieces.random()
		self.setSettings() 
	}
}
