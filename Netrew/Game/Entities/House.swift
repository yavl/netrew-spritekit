//
//  House.swift
//  Netrew
//
//  Created by Vladislav Nikolaev on 07.09.2021.
//

import GameplayKit

final class House: GKEntity {
    
    private let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: "house"))

    init(x: CGFloat, y: CGFloat) {
        super.init()
        
        spriteComponent.node.zPosition = 1
        spriteComponent.node.position = CGPoint(x: x, y: y)
        addComponent(spriteComponent)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
