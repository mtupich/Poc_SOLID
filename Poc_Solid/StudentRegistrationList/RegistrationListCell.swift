//
//  RegistrationListCell.swift
//  Poc_Solid
//
//  Created by Maria Tupich on 24/07/24.
//

import UIKit

class RegistrationListCell: UITableViewCell {
    
    lazy var studentName: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupName(name: String) {
        studentName.text = name
    }
}

extension RegistrationListCell {
    func buildViewHierarchy() {
        addSubview(studentName)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: topAnchor),
            bottomAnchor.constraint(equalTo: bottomAnchor),
            leftAnchor.constraint(equalTo: leftAnchor),
            rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    func setupAditionalConfiguration() {}
    
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAditionalConfiguration()
    }
}

