import wollok.game.*
import t.*
import tetris.*

object pieces {
	
	method t() {
		return 
			new T(basicTs = [
			new BasicT(position = game.at(4,19), main = true),
			new BasicT(position = game.at(3,19), main = false),
			new BasicT(position = game.at(4,18), main = false),
			new BasicT(position = game.at(5,19), main = false)	
		])
	}
	
	method square() {
		return 
			new T(basicTs = [
			new BasicT(position = game.at(4,18), main = true),
			new BasicT(position = game.at(5,18), main = false),
			new BasicT(position = game.at(4,19), main = false),
			new BasicT(position = game.at(5,19), main = false)	
		])
	}
	
	method straight() {
		return 
			new T(basicTs = [
			new BasicT(position = game.at(3,18), main = true),
			new BasicT(position = game.at(4,18), main = false),
			new BasicT(position = game.at(5,18), main = false),
			new BasicT(position = game.at(6,18), main = false)	
		])
	}
	
	method random() {
		return [self.square(), self.straight(), self.t()].anyOne()
	}
}

