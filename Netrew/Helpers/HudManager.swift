//
//  HudManager.swift
//  Netrew
//
//  Created by yavl on 27.12.2022.
//

import SpriteKit

final class HudManager {
    
    private weak var debugView: DebugView?
    private weak var camera: SKCameraNode?
    
    var cameraPosition: String {
        guard let camera = camera else { return "" }
        let x = Int(camera.position.x)
        let y = Int(camera.position.y)
        return "\(x), \(y)"
    }
    
    func configure(debugView: DebugView?, camera: SKCameraNode?) {
        self.debugView = debugView
        self.camera = camera
    }
}
