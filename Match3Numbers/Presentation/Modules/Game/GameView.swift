//
//  GameView.swift
//  Match3Numbers
//
//  Created by Roman Madyanov on 08.01.2021.
//

import UIKit

final class GameView: UIView {
    var didSwipeHandler: ((Int, Int) -> Void)? {
        didSet { boardView?.didSwipeHandler = didSwipeHandler }
    }

    var score: String = "" {
        didSet { scoreLabel.text = score }
    }

    var equation: String = "" {
        didSet { equationLabel.text = equation }
    }

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 32
        return stackView
    }()

    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .rounded(ofSize: 24)
        return label
    }()

    private lazy var equationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .rounded(ofSize: 32)
        return label
    }()

    private var boardView: BoardView?

    init() {
        super.init(frame: .zero)

        backgroundColor = .backgroundPrimary

        addSubview(stackView)

        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(scoreLabel)
        stackView.addArrangedSubview(equationLabel)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -32),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -32),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createBoard(width: Int, height: Int) {
        boardView?.removeFromSuperview()
        boardView = BoardView(width: width, height: height)
        boardView?.didSwipeHandler = didSwipeHandler

        boardView.map { stackView.insertArrangedSubview($0, at: 3) }
    }

    func fillBoard(with values: [Int?], completion: @escaping () -> Void = {}) {
        boardView?.fill(with: values, completion: completion)
    }

    func swapCells(from sourceIndex: Int, to destinationIndex: Int, completion: (() -> Void)? = nil) {
        boardView?.swapCells(from: sourceIndex, to: destinationIndex, completion: completion)
    }
}
