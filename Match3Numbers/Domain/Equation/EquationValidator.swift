//
//  EquationValidator.swift
//  Match3Numbers
//
//  Created by Roman Madyanov on 08.02.2021.
//

final class EquationValidator {
    func validate(_ equation: Equation, with operands: [Int]) -> Bool {
        assert(operands.count == equation.size, "Wrong number of operands for provided equation")

        var stack = operands

        for `operator` in equation.operators {
            let left = stack.removeLast()
            let right = stack.removeLast()

            switch `operator` {
            case .add: stack.append(left + right)
            }
        }

        return stack.removeLast() == equation.result
    }
}
