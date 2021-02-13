//
//  Board.swift
//  Match3Numbers
//
//  Created by Roman Madyanov on 08.02.2021.
//

struct Board {
    let width: Int
    let height: Int

    private(set) var values: [Int?]

    mutating func swap(_ i: Int, _ j: Int) {
        values.swapAt(i, j)
    }

    mutating func set(x: Int, y: Int, value: Int?) {
        values[x + y * width] = value
    }
}
