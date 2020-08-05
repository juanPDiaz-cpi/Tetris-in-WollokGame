import wollok.game.*
import tetris.*
import pieces.square.*
import pieces.straight.*

object pieces {
	
	method t() {
		return
			new Tetrimino(basicTs = [
				new BasicT(position = game.at(4,19), color = "Blue", main = true, moving = true),
				new BasicT(position = game.at(3,19), color = "Blue", main = false, moving = true),
				new BasicT(position = game.at(4,18), color = "Blue", main = false, moving = true),
				new BasicT(position = game.at(5,19), color = "Blue", main = false, moving = true)
				//new BasicT(position = game.at(6,19), color = "Blue", main = false),
				//new BasicT(position = game.at(5,20), color = "Blue", main = false),
				//new BasicT(position = game.at(3,20), color = "Blue", main = false)	
			])
	}
	
	method longBar() {
		return
			new Tetrimino(basicTs = [
				new BasicT(position = game.at(3,19), color = "Blue", main = false, moving = true),
				new BasicT(position = game.at(4,19), color = "Blue", main = true, moving = true),
				new BasicT(position = game.at(5,19), color = "Blue", main = false, moving = true),
				new BasicT(position = game.at(6,19), color = "Blue", main = false, moving = true)
				//new BasicT(position = game.at(6,19), color = "Blue", main = false),
				//new BasicT(position = game.at(5,20), color = "Blue", main = false),
				//new BasicT(position = game.at(3,20), color = "Blue", main = false)	
			])
	}
	
	method square() {
		return 
			new Cube(basicTs = [
				new BasicT(position = game.at(4,18), color = "Yellow", main = true, moving = true),
				new BasicT(position = game.at(5,18), color = "Yellow", main = false, moving = true),
				new BasicT(position = game.at(4,19), color = "Yellow", main = false, moving = true),
				new BasicT(position = game.at(5,19), color = "Yellow", main = false, moving = true)	
			])
	}
	
	method straight() {
		return 
			new Straight(basicTs = [
				new BasicT(position = game.at(3,18), color = "Red", main = true, moving = true),
				new BasicT(position = game.at(4,18), color = "Red", main = false, moving = true),
				new BasicT(position = game.at(5,18), color = "Red", main = false, moving = true),
				new BasicT(position = game.at(6,18), color = "Red", main = false, moving = true)	
			])
	}
	
	method random() {
		return self.straight() //[self.square(), self.straight(), self.t()].anyOne()
	}
}

