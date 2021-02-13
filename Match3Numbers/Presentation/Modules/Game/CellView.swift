//
//  CellView.swift
//  Match3Numbers
//
//  Created by Roman Madyanov on 08.01.2021.
//

import UIKit

final class CellView: UIView {
    var text = "" {
        didSet { label.text = text }
    }

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.backgroundColor = .backgroundSecondary
        return label
    }()

    var edgeConstraints: [NSLayoutConstraint] = []

    init() {
        super.init(frame: .zero)

        addSubview(label)

        edgeConstraints = [
            label.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 2),
            label.rightAnchor.constraint(equalTo: rightAnchor, constant: -2),
        ]
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        label.font = .rounded(ofSize: bounds.width / 2)
        label.layer.cornerRadius = bounds.width / 4

        NSLayoutConstraint.activate(edgeConstraints)
    }
}
