//
//  GameScene.swift
//  Netrew
//
//  Created by Vladislav Nikolaev on 07.09.2021.
//

import SpriteKit
import GameplayKit

final class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    private var entityManager: EntityManager!
    private var previousCameraPoint = CGPoint.zero
    private var previousCameraScale = CGFloat.zero
    private let cameraSpeed = CGFloat(1.6)
    
    override func didMove(to view: SKView) {
        let panGesture = UIPanGestureRecognizer()
        panGesture.addTarget(self, action: #selector(panGestureAction(_:)))
        panGesture.delegate = self
        view.addGestureRecognizer(panGesture)
        
        let pinchGesture = UIPinchGestureRecognizer()
        pinchGesture.addTarget(self, action: #selector(pinchGestureAction(_:)))
        pinchGesture.delegate = self
        view.addGestureRecognizer(pinchGesture)
    }
    
    override func sceneDidLoad() {
        entityManager = EntityManager(scene: self)
        
        let cameraNode = SKCameraNode()
        scene?.addChild(cameraNode)
        scene?.camera = cameraNode
        
        let terrain = Terrain()
        entityManager.add(terrain)
        
        let house = House(x: 0, y: 0)
        entityManager.add(house)
        
        let human = Human(x: -100, y: 0)
        entityManager.add(human)
        
        entityManager.calculateObstacles()

        self.lastUpdateTime = 0
    }
    
    override func update(_ currentTime: TimeInterval) {
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        let dt = currentTime - self.lastUpdateTime
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        self.lastUpdateTime = currentTime
    }
    
    @objc private func panGestureAction(_ sender: UIPanGestureRecognizer) {
        guard let camera = camera else {
            return
        }
        if sender.state == .began {
            previousCameraPoint = camera.position
        }
        let translation = sender.translation(in: self.view)
        let newPosition = CGPoint(
            x: previousCameraPoint.x + translation.x * cameraSpeed * -camera.xScale,
            y: previousCameraPoint.y + translation.y * cameraSpeed * camera.yScale
        )
        camera.position = newPosition
    }
    
    @objc private func pinchGestureAction(_ sender: UIPinchGestureRecognizer) {
        guard let camera = self.camera else {
            return
        }
        if sender.state == .began {
            previousCameraScale = camera.xScale
        }
        camera.setScale(previousCameraScale * 1 / sender.scale)
    }
}

extension GameScene: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
