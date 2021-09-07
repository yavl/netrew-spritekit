//
//  Terrain.swift
//  Netrew
//
//  Created by Vladislav Nikolaev on 08.09.2021.
//

import GameplayKit

class Terrain: GKEntity {
    
    override init() {
        super.init()
        
        let texture = SKTexture(imageNamed: "terrain")
        texture.filteringMode = .nearest
        let spriteComponent = SpriteComponent(texture: texture)
        addComponent(spriteComponent)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
