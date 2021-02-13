//
//  BoardSolver.swift
//  Match3Numbers
//
//  Created by Roman Madyanov on 13.02.2021.
//

final class BoardMatcher {
    private let equationValidator: EquationValidator

    init(equationValidator: EquationValidator) {
        self.equationValidator = equationValidator
    }

    func match(board: inout Board, equation: Equation) -> Int {
        var matches = 0

        for y in 0..<board.height {
            for x in 0..<board.width {
                if validateRow(equation: equation, x: x, y: y, width: board.width, values: board.values) {
                    matches += 1

                    for i in 0..<equation.size {
                        board.set(x: x - i, y: y, value: nil)
                    }
                }

                if validateColumn(equation: equation, x: x, y: y, width: board.width, values: board.values) {
                    matches += 1

                    for i in 0..<equation.size {
                        board.set(x: x, y: y - i, value: nil)
                    }
                }
            }
        }

        return matches
    }
}

private extension BoardMatcher {
    func validateRow(equation: Equation, x: Int, y: Int, width: Int, values: [Int?]) -> Bool {
        guard x >= equation.size else { return false }
        let operands = (0..<equation.size).map { values[(x - $0) + y * width] ?? 0 }
        return equationValidator.validate(equation, with: operands.reversed())
    }

    func validateColumn(equation: Equation, x: Int, y: Int, width: Int, values: [Int?]) -> Bool {
        guard y >= equation.size else { return false }
        let operands = (0..<equation.size).map { values[x + (y - $0) * width] ?? 0 }
        return equationValidator.validate(equation, with: operands.reversed())
    }
}
