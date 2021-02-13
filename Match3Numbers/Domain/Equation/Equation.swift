//
//  Equation.swift
//  Match3Numbers
//
//  Created by Roman Madyanov on 08.01.2021.
//

struct Equation {
    enum Operator {
        case add
    }

    let operators: [Operator]
    let result: Int

    var size: Int { operators.count + 1 }
}

extension Equation: CustomStringConvertible {
    var description: String {
        var stack = Array(repeating: "?", count: size)

        for `operator` in operators {
            let left = stack.removeLast()
            let right = stack.removeLast()

            switch `operator` {
            case .add: stack.append("\(left) + \(right)")
            }
        }

        return stack.removeLast() + " = \(result)"
    }
}
