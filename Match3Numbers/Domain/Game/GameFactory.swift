//
//  GameFactory.swift
//  Match3Numbers
//
//  Created by Roman Madyanov on 14.02.2021.
//

final class GameFactory {
    private let equationGenerator: EquationGenerator
    private let boardGenerator: BoardGenerator
    private let boardMatcher: BoardMatcher

    private let valuesRange = 1..<10
    private let resultRange = 10..<21

    init(equationGenerator: EquationGenerator,
         boardGenerator: BoardGenerator,
         boardMatcher: BoardMatcher) {

        self.equationGenerator = equationGenerator
        self.boardGenerator = boardGenerator
        self.boardMatcher = boardMatcher
    }

    func makeGame() -> Game {
        let equation = equationGenerator.generate(numberOfOperands: 3,
                                                  allowedOperators: [.add],
                                                  resultRange: resultRange)

        let board = boardGenerator.generate(width: 8,
                                            height: 10,
                                            valuesRange: valuesRange,
                                            equation: equation)

        return Game(equation: equation,
                    board: board,
                    valuesRange: valuesRange,
                    boardMatcher: boardMatcher)
    }
}
