//
//  GameViewController.swift
//  Match3Numbers
//
//  Created by Roman Madyanov on 08.01.2021.
//

import UIKit

final class GameViewController: UIViewController, AlertProvider {
    private let presenter: GamePresenter

    private lazy var gameView: GameView = {
        let gameView = GameView()
        gameView.translatesAutoresizingMaskIntoConstraints = false
        return gameView
    }()

    init(presenter: GamePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = gameView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.didLoad(ui: gameView, alertProvider: self)
    }
}
