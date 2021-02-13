//
//  GamePresenter.swift
//  Match3Numbers
//
//  Created by Roman Madyanov on 08.01.2021.
//

final class GamePresenter {
    private weak var ui: GameView?
    private weak var alertProvider: AlertProvider?

    private let gameFactory: GameFactory

    init(gameFactory: GameFactory) {
        self.gameFactory = gameFactory
    }

    func didLoad(ui: GameView, alertProvider: AlertProvider) {
        self.ui = ui
        self.alertProvider = alertProvider

        startGame()
    }
}

private extension GamePresenter {
    func startGame() {
        let game = gameFactory.makeGame()

        ui?.equation = "\(game.equation)"

        ui?.createBoard(width: game.board.width, height: game.board.height)
        ui?.fillBoard(with: game.board.values)

        ui?.didSwipeHandler = { [weak self] from, to in
            game.swap(from, to)
            self?.matchAndFillBoard(game: game)
        }

        updateScore(game: game)
    }

    func matchAndFillBoard(game: Game) {
        updateScore(game: game)

        if game.match() == false {
            if game.isOver {
                alertProvider?.showAlert(title: "GAME OVER",
                                         message: nil,
                                         actions: [.init(title: "OK", handler: { [weak self] in self?.startGame() })])
            }

            return
        }

        ui?.fillBoard(with: game.board.values) { [weak self] in
            game.fill()

            self?.ui?.fillBoard(with: game.board.values) {
                self?.matchAndFillBoard(game: game)
            }
        }
    }

    func updateScore(game: Game) {
        ui?.score = "Score: \(game.score)"
    }
}
