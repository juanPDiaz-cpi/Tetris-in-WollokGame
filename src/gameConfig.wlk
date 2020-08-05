import pieces.pieces.*
import wollok.game.*
import pieces.tetris.*
import directions.*
import lines.*
import pieces.straight.*
import pieces.square.*

object gameConfig {
	const property widthMin = -1
	const property widthMax = 10
	const property heightMin = -1
	const property heightMax = 20
	var property actualTime = 250
	
	var property tetrinomiun = pieces.random()

	method setBoard() {
		(widthMin..widthMax).forEach({ n => game.addVisual(self.basicT(n, heightMin)) })
		(widthMin..widthMax).forEach({ n => game.addVisual(self.basicT(n, heightMax)) })
		((heightMin-1)..(heightMax-1)).forEach({ n => game.addVisual(self.basicT(widthMin, n)) })
		((heightMin-1)..(heightMax-1)).forEach({ n => game.addVisual(self.basicT(widthMax, n)) })
	}

	method basicT(x, y) {
		return new BasicT(main = false, position = game.at(x,y), color = "Blue", moving = false)
	}
	
	method start() {
		self.keys()
		self.setBoard()
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
		//console.println("running?")
		tetrinomiun.add()
	}
	
	method newElement() {
		tetrinomiun = pieces.random()
		self.setSettings() 
	}
}
