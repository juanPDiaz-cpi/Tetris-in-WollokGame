import wollok.game.*
import t.*
import tetris.*
import pieces.square.*
import pieces.straight.*

object pieces {
	
	method t() {
		return 
			new T(basicTs = [
			new BasicT(position = game.at(4,19), color = "Blue", main = true),
			new BasicT(position = game.at(3,19), color = "Blue", main = false),
			new BasicT(position = game.at(4,18), color = "Blue", main = false),
			new BasicT(position = game.at(5,19), color = "Blue", main = false)	
		])
	}
	
	method square() {
		return 
			new Cube(basicTs = [
			new BasicT(position = game.at(4,18), color = "Yellow", main = true),
			new BasicT(position = game.at(5,18), color = "Yellow", main = false),
			new BasicT(position = game.at(4,19), color = "Yellow", main = false),
			new BasicT(position = game.at(5,19), color = "Yellow", main = false)	
		])
	}
	
	method straight() {
		return 
			new Straight(basicTs = [
			new BasicT(position = game.at(3,18), color = "Red", main = true),
			new BasicT(position = game.at(4,18), color = "Red", main = false),
			new BasicT(position = game.at(5,18), color = "Red", main = false),
			new BasicT(position = game.at(6,18), color = "Red", main = false)	
		])
	}
	
	method random() {
		return [self.square(), self.straight(), self.t()].anyOne()
	}
}

