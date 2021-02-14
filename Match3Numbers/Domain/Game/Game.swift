//
//  Game.swift
//  Match3Numbers
//
//  Created by Roman Madyanov on 13.02.2021.
//

final class Game {
    private(set) var equation: Equation
    private(set) var board: Board
    private(set) var score = 5

    private let valuesRange: Range<Int>
    private let boardMatcher: BoardMatcher

    var isOver: Bool { return score <= 0 }

    init(equation: Equation,
         board: Board,
         valuesRange: Range<Int>,
         boardMatcher: BoardMatcher) {

        self.equation = equation
        self.board = board
        self.valuesRange = valuesRange
        self.boardMatcher = boardMatcher
    }

    func swap(_ i: Int, _ j: Int) {
        board.swap(i, j)
        score -= 1
    }

    func match() -> Bool {
        let matches = boardMatcher.match(board: &board, equation: equation)
        score += matches
        return matches > 0
    }

    func fill() {
        board.fill { valuesRange.randomElement() }
    }
}
