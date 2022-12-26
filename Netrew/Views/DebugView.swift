//
//  DebugView.swift
//  Netrew
//
//  Created by yavl on 26.12.2022.
//

import UIKit

final class DebugView: UIView {
    
    var positionText = "" {
        didSet {
            positionLabel.text = positionText
        }
    }
    
    private let getPositionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get camera position", for: .normal)
        return button
    }()
    
    private let positionLabel: UILabel = {
        let label = UILabel()
        label.text = "sample text"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(getPositionButton)
        addSubview(positionLabel)
        
        getPositionButton.addTarget(self, action: #selector(getPositionTapped), for: .touchUpInside)
    }
    
    private func setupLayout() {
        getPositionButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        positionLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func getPositionTapped() {
        positionLabel.text = env.hud.cameraPosition
    }
}
