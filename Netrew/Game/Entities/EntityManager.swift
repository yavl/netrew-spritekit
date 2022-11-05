//
//  EntityManager.swift
//  Netrew
//
//  Created by Vladislav Nikolaev on 07.09.2021.
//

import GameplayKit

final class EntityManager {
    
    let scene: SKScene
    
    var entities = Set<GKEntity>()
    var obstacleSpriteNodes: [SKSpriteNode] = []
    var polygonObstacles: [GKPolygonObstacle] = []
    
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
    
    func calculateObstacles() {
        for entity in entities {
            guard entity is House else { continue }
            guard let spriteNode = entity.component(ofType: SpriteComponent.self)?.node else { continue }
            obstacleSpriteNodes.append(spriteNode)
        }
        polygonObstacles = SKNode.obstacles(fromNodeBounds: obstacleSpriteNodes)
        var graph: GKObstacleGraph = GKObstacleGraph(obstacles: polygonObstacles, bufferRadius: 1)
        
        if let human = entities.first(where: { $0 is Human }), let spriteNode = human.component(ofType: SpriteComponent.self)?.node {
            let start = GKGraphNode2D(point: vector_float2(x: Float(spriteNode.position.x), y: Float(spriteNode.position.y)))
            let end = GKGraphNode2D(point: vector_float2(x: 100, y: 0))
            graph.connectUsingObstacles(node: start)
            graph.connectUsingObstacles(node: end)
            if let noda = graph.nodes {
                for each in noda {
                    print("noda")
                }
            }
            let paths = graph.findPath(from: start, to: end)
            for path in paths {
                print("\(path.findPath(to: end))")
            }
            print(paths.count)
        }
    }
}
