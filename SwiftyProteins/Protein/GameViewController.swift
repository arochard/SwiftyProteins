//
//  GameViewController.swift
//  Protein
//
//  Created by Stefan-ciprian CIRCIU on 10/24/16.
//  Copyright (c) 2016 Stefan-ciprian CIRCIU. All rights reserved.
//

import UIKit
import Foundation
import QuartzCore
import SceneKit

class GameViewController: UIViewController, SCNSceneRendererDelegate {

    @IBOutlet weak var sceneview: SCNView!
    var lig:ligand? = nil
    let scene = SCNScene()
    
    
    @IBOutlet weak var atomsname: UILabel!
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        sceneview.sceneTime += 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        
        
        
        let Ligands = Molecules(formula: lig!)
        let child = Ligands.makeAtomswithSticks()
        child.name = "main"
        //Add child
        scene.rootNode.addChildNode(child)
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 50)
        
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLight.LightType.omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
       
        
        
        let lightNode2 = SCNNode()
        lightNode2.light = SCNLight()
        lightNode2.light!.type = SCNLight.LightType.omni
        lightNode2.position = SCNVector3(x: 0, y: -10, z: -10)
        scene.rootNode.addChildNode(lightNode2)
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLight.LightType.ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
        
        sceneview.scene = scene
        
        // allows the user to manipulate the camera
        sceneview.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        sceneview.showsStatistics = false
        
        // configure the view
        sceneview.backgroundColor = UIColor.white
        
        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneview.addGestureRecognizer(tapGesture)
    }
    
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        
        // check what nodes are tapped
        let p = gestureRecognize.location(in: self.sceneview)
        let hitResults = self.sceneview.hitTest(p, options: nil)
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result: AnyObject! = hitResults[0]
            let nameElem = result.node.name
            if nameElem != nil{
                let charElem = nameElem!.characters.first
                if charElem != nil {
                    print("\(charElem!)\n")
                    self.atomsname.text = "\(charElem!)"
                }
            }
            // get its material
            let material = result.node!.geometry!.firstMaterial!
            if result.node.geometry is SCNSphere{
            // highlight it
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                
                // on completion - unhighlight
                SCNTransaction.completionBlock = {
                    SCNTransaction.begin()
                    SCNTransaction.animationDuration = 0.5
                    
                    material.emission.contents = UIColor.black
                    
                    SCNTransaction.commit()
                }
                
                material.emission.contents = UIColor.red
                
                SCNTransaction.commit()
            }
        }
    }

    @IBAction func choosemodel(_ sender: UISegmentedControl) {
        atomsname.text = ""
        switch sender.selectedSegmentIndex {
        case 0:
            let thenode = self.scene.rootNode.childNode(withName: "main", recursively: true)
            let Ligands = Molecules(formula: lig!)
            let child = Ligands.makeAtomswithSticks()
            child.name = "main"
            self.scene.rootNode.replaceChildNode(thenode!, with: child)
        case 1:
            let thenode = self.scene.rootNode.childNode(withName: "main", recursively: true)
            let Ligands = Molecules(formula: lig!)
            let child = Ligands.makeAtoms()
            child.name = "main"
            self.scene.rootNode.replaceChildNode(thenode!, with: child)
        default:
            break
        }
        
    }
    
    override var shouldAutorotate : Bool {
        return true
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    func getScreenshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(sceneview.bounds.size, false, 0)
        sceneview.drawHierarchy(in: sceneview.bounds, afterScreenUpdates: true)
        let screenshotImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return screenshotImage;
    }
    @IBAction func shareButton(_ sender: AnyObject)
    {
        //message
        let postText: String = "Modelisation ligand \(lig!.id!)"
        //SceneView
        let postImage: UIImage = getScreenshot()
        //Item envoye
        let objectsToShare = [postText, postImage] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
}


