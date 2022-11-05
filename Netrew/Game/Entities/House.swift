//
//  House.swift
//  Netrew
//
//  Created by Vladislav Nikolaev on 07.09.2021.
//

import GameplayKit

final class House: GKEntity {
    
    override init() {
        super.init()
        
        let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: "house"))
        spriteComponent.node.zPosition = 1
        addComponent(spriteComponent)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
