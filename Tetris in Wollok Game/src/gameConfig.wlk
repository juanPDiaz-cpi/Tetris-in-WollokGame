import wollok.game.*
import tetris.*
import directions.*
import lines.*
import straight.*
import square.*

object gameConfig {
	const property widthMin = 0
	const property widthMax = 9
	const property heightMin = 0
	var property actualTime = 250
	
	var property tetrinomiun = new Straight()
	
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
	}
	
	method setSettings() {
		console.println("running?")
		tetrinomiun.add()
	}
	
	method newElement() {
		tetrinomiun = new Straight()
		self.setSettings() 
	}
}
