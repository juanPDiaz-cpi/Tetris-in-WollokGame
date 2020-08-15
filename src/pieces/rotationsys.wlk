import wollok.game.*

object rotationSys {
	var rotationCW = null
	
	const cwRotationTests = [
		new RotationTest(position = game.at(0,0)),
		new RotationTest(position = game.at(-1,0)),
		new RotationTest(position = game.at(-1,-1)),
		new RotationTest(position = game.at(0,2)),
		new RotationTest(position = game.at(-1,2))
	]
	
	const acwRotationTests = [
		new RotationTest(position = game.at(0,0)),
		new RotationTest(position = game.at(1,0)),
		new RotationTest(position = game.at(1,-1)),
		new RotationTest(position = game.at(0,2)),
		new RotationTest(position = game.at(1,2))
	]

	method executeRotationTestsCW(tetrimino) {
		rotationCW = true
		const rotation = tetrimino.rotation()
		
		self.tryModifiedTests(tetrimino, self.cwx(rotation), self.cwy(rotation))
	}
	
	method executeRotationTestsACW(tetrimino) {
		rotationCW = false
		const rotation = tetrimino.rotation()
		
		self.tryModifiedTests(tetrimino, self.acwx(rotation), self.acwy(rotation))
	}
	
	method tryModifiedTests(tetrimino, valueX, valueY) {
		self.tryPositions(tetrimino, self.modifiedTests(valueX, valueY))
	}
	
	method tryPositions(tetrimino, positions) {		
		try {
			tetrimino.moveTo(positions.find({ pos => tetrimino.canBeAt(pos) }))
			//console.println("I'm here")
    	}
    	catch e : ElementNotFoundException {
    		if(rotationCW) {
				tetrimino.rotateACWS()
			} else {
				tetrimino.rotateCWS()
			}
			//console.println("I'm here instead")
		}
	}
	
	method modifiedTests(valueX, valueY) {
		return
			if(rotationCW) {
				cwRotationTests.map({ rTest => rTest.modified(valueX, valueY) })
			} else {
				acwRotationTests.map({ rTest => rTest.modified(valueX, valueY) })
			}
	}
		
	// Math functions to determine the value which modifies the rotation tests in function of the rotation number of the tetrimino. 
	method cwx(number) { return (2*(number - 3/2).abs()) - 2 }
	
	method cwy(number) { return (-1)**number }
	
	method acwx(number) { return ((2*(number - 5/2).abs()) - 2).min(1) }
	
	method acwy(number) { return (-1)**number }
	
	// Math functions that determine the offSet value in function of the rotation number of the tetrimino.
	method iOffSetX(number) { return (number - 1).abs() - 1 }
	
	method iOffSetY(number) { return - (number % 2) + 1 }
}

class RotationTest {
	const property position
	
	method modified(valueX, valueY) {
		//console.println("x = " + valueX.toString() + " and y = " + valueY.toString())
		/*console.println(
			"x = " + position.x().toString() + //(position.x() * valueX).toString() + 
			" and y = " + position.y().toString() //(position.y() * valueY).toString()
		)*/
		
		return game.at(
			position.x() * valueX,
			position.y() * valueY
		)
	}
}














