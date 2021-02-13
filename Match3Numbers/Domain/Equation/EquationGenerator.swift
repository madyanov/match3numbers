//
//  EquationGenerator.swift
//  Match3Numbers
//
//  Created by Roman Madyanov on 08.01.2021.
//

final class EquationGenerator {
    func generate(numberOfOperands: Int,
                  allowedOperators: [Equation.Operator],
                  resultRange: Range<Int>) -> Equation {

        assert(numberOfOperands > 1, "Number of operands must be greater than 1")
        assert(allowedOperators.isEmpty == false, "Number of operators must be greater than 0")

        let operators = (1..<numberOfOperands).compactMap { _ in allowedOperators.randomElement() }

        return Equation(operators: operators, result: resultRange.randomElement() ?? 0)
    }
}
