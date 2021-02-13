//
//  BoardView.swift
//  Match3Numbers
//
//  Created by Roman Madyanov on 08.01.2021.
//

import UIKit

final class BoardView: UIView {
    var didSwipeHandler: ((Int, Int) -> Void)?

    private let width: Int
    private let height: Int

    private lazy var upSwipeGestureRecognizer = makeSwipeGestureRecognizer(for: .up)
    private lazy var downSwipeGestureRecognizer = makeSwipeGestureRecognizer(for: .down)
    private lazy var rightSwipeGestureRecognizer = makeSwipeGestureRecognizer(for: .right)
    private lazy var leftSwipeGestureRecognizer = makeSwipeGestureRecognizer(for: .left)

    private var cellViews: [CellView] = []

    private var laidOut = false

    private var cellSize: CGFloat {
        return bounds.width / CGFloat(width)
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: bounds.width, height: cellSize * CGFloat(height))
    }

    init(width: Int, height: Int) {
        self.width = width
        self.height = height

        super.init(frame: .zero)

        addGestureRecognizers()
        addCells()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if bounds != .zero && laidOut == false {
            layoutCells()
            invalidateIntrinsicContentSize()
            laidOut = true
        }
    }

    func fill(with values: [Int?], completion: @escaping () -> Void) {
        assert(values.isEmpty == false, "Number of values must me greater than 0")
        assert(values.count == width * height,
               "Number of values must be equal to board width * board height")

        self.isUserInteractionEnabled = false

        UIView.animate(withDuration: 0.2) {
            for y in 0..<self.height {
                for x in 0..<self.width {
                    let index = x + y * self.width

                    if let value = values[index] {
                        self.cellViews[index].text = "\(value)"
                        self.cellViews[index].alpha = 1
                        self.cellViews[index].transform = .identity
                    } else {
                        self.cellViews[index].alpha = 0
                        self.cellViews[index].transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    }
                }
            }
        } completion: { _ in
            self.isUserInteractionEnabled = true
            completion()
        }
    }

    func swapCells(from sourceIndex: Int, to destinationIndex: Int, completion: (() -> Void)? = nil) {
        let sourceCellView = cellViews[sourceIndex]
        let destinationCellView = cellViews[destinationIndex]

        bringSubviewToFront(sourceCellView)

        cellViews.swapAt(sourceIndex, destinationIndex)

        UIView.animate(withDuration: 0.2) {
            let sourceFrame = sourceCellView.frame
            sourceCellView.frame = destinationCellView.frame
            destinationCellView.frame = sourceFrame
        } completion: { _ in
            completion?()
        }
    }
}

private extension BoardView {
    func addGestureRecognizers() {
        addGestureRecognizer(upSwipeGestureRecognizer)
        addGestureRecognizer(downSwipeGestureRecognizer)
        addGestureRecognizer(rightSwipeGestureRecognizer)
        addGestureRecognizer(leftSwipeGestureRecognizer)
    }

    func addCells() {
        for _ in 0..<width * height {
            let cellView = CellView()
            cellViews.append(cellView)
            addSubview(cellView)
        }
    }

    func layoutCells() {
        for y in 0..<height {
            for x in 0..<width {
                let cellView = cellViews[x + y * width]
                cellView.frame.size = CGSize(width: cellSize, height: cellSize)
                cellView.frame.origin  = CGPoint(x: CGFloat(x) * cellSize, y: CGFloat(y) * cellSize)
            }
        }
    }

    func makeSwipeGestureRecognizer(for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        let recognizer = UISwipeGestureRecognizer(target: self,
                                                  action: #selector(didSwipe(_:)))
        recognizer.direction = direction
        return recognizer
    }

    @objc
    func didSwipe(_ recognizer: UISwipeGestureRecognizer) {
        let location = recognizer.location(in: self)
        let x = Int(location.x / cellSize)
        let y = Int(location.y / cellSize)

        let offset: (dx: Int, dy: Int) = {
            switch recognizer.direction {
            case .up: return (0, -1)
            case .down: return (0, 1)
            case .left: return (-1, 0)
            case .right: return (1, 0)
            default: return (0, 0)
            }
        }()

        guard x + offset.dx >= 0, x + offset.dx < width,
              y + offset.dy >= 0, y + offset.dy < height
        else {
            return
        }

        let sourceIndex = x + y * width
        let destinationIndex = x + offset.dx + (y + offset.dy) * width

        swapCells(from: sourceIndex, to: destinationIndex) {
            self.didSwipeHandler?(sourceIndex, destinationIndex)
        }
    }
}
