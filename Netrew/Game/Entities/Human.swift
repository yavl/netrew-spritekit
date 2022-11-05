//
//  Human.swift
//  Netrew
//
//  Created by Vladislav Nikolaev on 08.09.2021.
//

import GameplayKit

final class Human: GKEntity {
    
    init(x: CGFloat, y: CGFloat) {
        super.init()
        
        let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: "circle"))
        spriteComponent.node.zPosition = 2
        spriteComponent.node.position = CGPoint(x: x, y: y)
        addComponent(spriteComponent)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
