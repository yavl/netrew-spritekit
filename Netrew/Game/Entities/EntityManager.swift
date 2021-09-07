//
//  EntityManager.swift
//  Netrew
//
//  Created by Vladislav Nikolaev on 07.09.2021.
//

import GameplayKit

class EntityManager {
    
    var entities = Set<GKEntity>()
    let scene: SKScene
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    func add(_ entity: GKEntity) {
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            scene.addChild(spriteNode)
        }
        entities.insert(entity)
    }
    
    func remove(_ entity: GKEntity) {
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            spriteNode.removeFromParent()
        }
        entities.remove(entity)
    }
}
