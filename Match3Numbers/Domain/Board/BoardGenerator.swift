//
//  BoardGenerator.swift
//  Match3Numbers
//
//  Created by Roman Madyanov on 08.02.2021.
//

final class BoardGenerator {
    private let equationValidator: EquationValidator

    init(equationValidator: EquationValidator) {
        self.equationValidator = equationValidator
    }

    func generate(width: Int, height: Int, valuesRange: Range<Int>, equation: Equation) -> Board {
        var values: [Int] = []

        for y in 0..<height {
            for x in 0..<width {
                var value: Int

                repeat {
                    value = valuesRange.randomElement() ?? 0
                } while
                    validateRow(value: value, equation: equation, x: x, y: y, width: width, values: values) ||
                    validateColumn(value: value, equation: equation, x: x, y: y, width: width, values: values)

                values.append(value)
            }
        }

        return Board(width: width, height: height, values: values)
    }
}

private extension BoardGenerator {
    func validateRow(value: Int, equation: Equation, x: Int, y: Int, width: Int, values: [Int]) -> Bool {
        guard x >= equation.size - 1 else { return false }
        let operands = (1...equation.size - 1).map { values[(x - $0) + y * width] }
        return equationValidator.validate(equation, with: operands.reversed() + [value])
    }

    func validateColumn(value: Int, equation: Equation, x: Int, y: Int, width: Int, values: [Int]) -> Bool {
        guard y >= equation.size - 1 else { return false }
        let operands = (1...equation.size - 1).map { values[x + (y - $0) * width] }
        return equationValidator.validate(equation, with: operands.reversed() + [value])
    }
}
