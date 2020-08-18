import pieces.pieces.*
import wollok.game.*
import pieces.tetris.*
import lines.*
import pieces.straight.*
import pieces.square.*
import dataBase.*

object gameConfig {
	const property widthMin = 9
	const property widthMax = 20
	const property heightMin = 1
	const property heightMax = 22
	var property actualTime = 250
	
	var property tetrinomiun = pieces.randomTetrimino()

	method setBoard() {
		(widthMin..widthMax).forEach({ n => game.addVisual(self.addBorderAt(n, heightMin)) })
		(widthMin..widthMax).forEach({ n => game.addVisual(self.addBorderAt(n, heightMax)) })
		((heightMin)..(heightMax)).forEach({ n => game.addVisual(self.addBorderAt(widthMin, n)) })
		((heightMin)..(heightMax)).forEach({ n => game.addVisual(self.addBorderAt(widthMax, n)) })
	}

	method addBorderAt(x, y) {
		return new BasicT(main = false, position = game.at(x,y), color = "Transparent", moving = false)
	}
	
	method start() {
		self.keys()
		self.setBoard()
		self.setSettings()
	}
	
	method keys() {
		keyboard.left().onPressDo({ tetrinomiun.moveIfPossible(tetrinomiun.position().left(1)) })
		keyboard.right().onPressDo({ tetrinomiun.moveIfPossible(tetrinomiun.position().right(1)) })
		keyboard.down().onPressDo({ tetrinomiun.moveIfPossible(tetrinomiun.position().down(1)) })
		keyboard.space().onPressDo({ tetrinomiun.goDown() })
		keyboard.z().onPressDo({ tetrinomiun.rotateACW() })
		keyboard.x().onPressDo({ tetrinomiun.rotateCW() })
		keyboard.r().onPressDo({ self.restartGame() })
		keyboard.backspace().onPressDo({ game.stop() })
	}
	
	method setSettings() {
		tetrinomiun.add()
	}
	
	method newElement() {
		tetrinomiun = pieces.randomTetrimino()
		self.setSettings()
	}
	
	method restartGame() {
		dataBase.clearGame()
		tetrinomiun.endAutoFall()
	}
}
