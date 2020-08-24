import wollok.game.*
import pieces.tetris.*

object board {
	var property position = game.at(9,1)
	var property image = "board.png"
	
	method addVisuals(widthMin, widthMax, heightMin, heightMax) {
		self.addBorders(widthMin, widthMax, heightMin, heightMax)
		game.addVisual(self)
	}
	
	method addBorders(widthMin, widthMax, heightMin, heightMax) {
		(widthMin..widthMax).forEach({ n => game.addVisual(self.addBorderAt(n, heightMin)) })
		(widthMin..widthMax).forEach({ n => game.addVisual(self.addBorderAt(n, heightMax)) })
		((heightMin)..(heightMax)).forEach({ n => game.addVisual(self.addBorderAt(widthMin, n)) })
		((heightMin)..(heightMax)).forEach({ n => game.addVisual(self.addBorderAt(widthMax, n)) })
	}

	method addBorderAt(x, y) {
		return new BasicT(main = false, position = game.at(x,y), color = "Transparent", moving = false)
	}
}

