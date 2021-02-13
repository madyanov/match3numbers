//
//  GameAssembly.swift
//  Match3Numbers
//
//  Created by Roman Madyanov on 08.01.2021.
//

import UIKit

enum GameAssembly {
    static func makeViewController() -> UIViewController {
        let gameFactory = makeGameFactory()
        let presenter = GamePresenter(gameFactory: gameFactory)
        return GameViewController(presenter: presenter)
    }
}

private extension GameAssembly {
    static func makeGameFactory() -> GameFactory {
        let equationGenerator = EquationGenerator()
        let equationValidator = EquationValidator()
        let boardGenerator = BoardGenerator(equationValidator: equationValidator)
        let boardMatcher = BoardMatcher(equationValidator: equationValidator)

        return GameFactory(equationGenerator: equationGenerator,
                           boardGenerator: boardGenerator,
                           boardMatcher: boardMatcher)
    }
}
