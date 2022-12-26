//
//  GameViewController.swift
//  Netrew
//
//  Created by Vladislav Nikolaev on 07.09.2021.
//

import UIKit
import SnapKit
import SpriteKit
import GameplayKit

final class GameViewController: UIViewController {
    
    private let debugView = DebugView()
    
    private let crossView: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate))
        view.tintColor = .lightGray
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                // Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    view.ignoresSiblingOrder = true
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
                
                env.hud.configure(debugView: debugView, camera: sceneNode.camera)
            }
        }
        
        setupViews()
        setupLayout()
    }
    
    private func setupViews() {
        view.addSubview(debugView)
        view.addSubview(crossView)
    }
    
    private func setupLayout() {
        crossView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        debugView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalToSuperview().dividedBy(3)
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
