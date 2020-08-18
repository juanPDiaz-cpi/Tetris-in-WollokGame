import wollok.game.*
import tetris.*
import pieces.square.*
import pieces.straight.*

object pieces {
	var actualTetriminoBag = self.fullBag()
	
	method t() {
		return
			new Tetrimino(basicTs = [
				new BasicT(position = game.at(15,19), color = "Pink", main = true, moving = true),
				new BasicT(position = game.at(14,19), color = "Pink", main = false, moving = true),
				new BasicT(position = game.at(15,20), color = "Pink", main = false, moving = true),
				new BasicT(position = game.at(16,19), color = "Pink", main = false, moving = true)	
			])
	}
	
	method square() {
		return 
			new Cube(basicTs = [
				new BasicT(position = game.at(15,18), color = "Yellow", main = true, moving = true),
				new BasicT(position = game.at(16,18), color = "Yellow", main = false, moving = true),
				new BasicT(position = game.at(15,19), color = "Yellow", main = false, moving = true),
				new BasicT(position = game.at(16,19), color = "Yellow", main = false, moving = true)	
			])
	}
	
	method i() {
		return 
			new Straight(basicTs = [
				new BasicT(position = game.at(14,18), color = "Red", main = false, moving = true),
				new BasicT(position = game.at(15,18), color = "Red", main = false, moving = true),
				new BasicT(position = game.at(16,18), color = "Red", main = true, moving = true),
				new BasicT(position = game.at(17,18), color = "Red", main = false, moving = true)	
			])
	}
	
	method s() {
		return
			new Tetrimino(basicTs = [
				new BasicT(position = game.at(15,19), color = "Green", main = false, moving = true),
				new BasicT(position = game.at(16,19), color = "Green", main = false, moving = true),
				new BasicT(position = game.at(14,18), color = "Green", main = false, moving = true),
				new BasicT(position = game.at(15,18), color = "Green", main = true, moving = true)
			])
	}
	
	method z() {
		return
			new Tetrimino(basicTs = [
				new BasicT(position = game.at(14,19), color = "Red", main = false, moving = true),
				new BasicT(position = game.at(15,19), color = "Red", main = false, moving = true),
				new BasicT(position = game.at(15,18), color = "Red", main = true, moving = true),
				new BasicT(position = game.at(16,18), color = "Red", main = false, moving = true)
			])
	}
	
	method l() {
		return
			new Tetrimino(basicTs = [
				new BasicT(position = game.at(14,18), color = "Orange", main = false, moving = true),
				new BasicT(position = game.at(15,18), color = "Orange", main = true, moving = true),
				new BasicT(position = game.at(16,18), color = "Orange", main = false, moving = true),
				new BasicT(position = game.at(16,19), color = "Orange", main = false, moving = true)
			])
	}
	
	method j() {
		return
			new Tetrimino(basicTs = [
				new BasicT(position = game.at(14,19), color = "Blue", main = false, moving = true),
				new BasicT(position = game.at(14,18), color = "Blue", main = false, moving = true),
				new BasicT(position = game.at(15,18), color = "Blue", main = true, moving = true),
				new BasicT(position = game.at(16,18), color = "Blue", main = false, moving = true)
			])
	}
	
	method randomTetrimino() {
		const size = actualTetriminoBag.size()
		var element
		
		if(actualTetriminoBag.isEmpty()) {
			actualTetriminoBag = self.fullBag()
		}
		element = actualTetriminoBag.get((0.randomUpTo(size)).max(size - 1).truncate(0))
		actualTetriminoBag.remove(element)
		
		return element
	}
	
	method fullBag() {
		return [self.square(), self.t(), self.l(), self.j(), self.s(), self.z()]		
	}	
}

