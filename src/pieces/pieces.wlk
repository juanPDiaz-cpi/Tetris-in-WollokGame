import wollok.game.*
import tetris.*
import pieces.square.*
import pieces.straight.*

object pieces {
	
	method t() {
		return
			new Tetrimino(basicTs = [
				new BasicT(position = game.at(4,19), color = "Pink", main = true, moving = true),
				new BasicT(position = game.at(3,19), color = "Pink", main = false, moving = true),
				new BasicT(position = game.at(4,20), color = "Pink", main = false, moving = true),
				new BasicT(position = game.at(5,19), color = "Pink", main = false, moving = true)	
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
	
	method i() {
		return 
			new Straight(basicTs = [
				new BasicT(position = game.at(3,18), color = "Red", main = false, moving = true),
				new BasicT(position = game.at(4,18), color = "Red", main = false, moving = true),
				new BasicT(position = game.at(5,18), color = "Red", main = true, moving = true),
				new BasicT(position = game.at(6,18), color = "Red", main = false, moving = true)	
			])
	}
	
	method s() {
		return
			new Tetrimino(basicTs = [
				new BasicT(position = game.at(4,19), color = "Green", main = false, moving = true),
				new BasicT(position = game.at(5,19), color = "Green", main = false, moving = true),
				new BasicT(position = game.at(3,18), color = "Green", main = false, moving = true),
				new BasicT(position = game.at(4,18), color = "Green", main = true, moving = true)
			])
	}
	
	method z() {
		return
			new Tetrimino(basicTs = [
				new BasicT(position = game.at(3,19), color = "Red", main = false, moving = true),
				new BasicT(position = game.at(4,19), color = "Red", main = false, moving = true),
				new BasicT(position = game.at(4,18), color = "Red", main = true, moving = true),
				new BasicT(position = game.at(5,18), color = "Red", main = false, moving = true)
			])
	}
	
	method l() {
		return
			new Tetrimino(basicTs = [
				new BasicT(position = game.at(3,18), color = "Orange", main = false, moving = true),
				new BasicT(position = game.at(4,18), color = "Orange", main = true, moving = true),
				new BasicT(position = game.at(5,18), color = "Orange", main = false, moving = true),
				new BasicT(position = game.at(5,19), color = "Orange", main = false, moving = true)
			])
	}
	
	method j() {
		return
			new Tetrimino(basicTs = [
				new BasicT(position = game.at(3,19), color = "Blue", main = false, moving = true),
				new BasicT(position = game.at(3,18), color = "Blue", main = false, moving = true),
				new BasicT(position = game.at(4,18), color = "Blue", main = true, moving = true),
				new BasicT(position = game.at(5,18), color = "Blue", main = false, moving = true)
			])
	}
	
	method random() {
		return [self.square(), self.t(), self.l(), self.j(), self.s(), self.z(), self.i()].anyOne()
	}
}

