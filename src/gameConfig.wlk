import pieces.pieces.*
import wollok.game.*
import pieces.tetris.*
import lines.*
import pieces.straight.*
import pieces.square.*
import dataBase.*

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
		keyboard.left().onPressDo({ tetrinomiun.moveTo(tetrinomiun.position().left(1)) })
		keyboard.right().onPressDo({ tetrinomiun.moveTo(tetrinomiun.position().right(1)) })
		keyboard.down().onPressDo({ tetrinomiun.moveTo(tetrinomiun.position().down(1)) })
		keyboard.space().onPressDo({ tetrinomiun.goDown() })
		keyboard.z().onPressDo({ tetrinomiun.rotateACW() })
		keyboard.x().onPressDo({ tetrinomiun.rotateCW() })
		keyboard.r().onPressDo({ self.restartGame() })
		keyboard.backspace().onPressDo({ game.stop() })
		keyboard.l().onPressDo({ tetrinomiun.basicTs().forEach({
			b => console.println(b.position().toString())
		})
		console.println("---------")
		 })
	}
	
	method setSettings() {
		tetrinomiun.add()
	}
	
	method newElement() {
		tetrinomiun = pieces.random()
		self.setSettings()
	}
	
	method restartGame() {
		dataBase.clearGame()
		tetrinomiun.endAutoFall()
	}
}
