//
//  cylinder.swift
//  Protein
//
//  Created by Stefan-ciprian CIRCIU on 10/27/16.
//  Copyright © 2016 Stefan-ciprian CIRCIU. All rights reserved.
//

import Foundation
import SceneKit

class   CylinderLine: SCNNode
{
    init( parent: SCNNode,//Needed to line to your scene
        v1: SCNVector3,//Source
        v2: SCNVector3,//Destination
        radius: CGFloat,// Radius of the cylinder
        radSegmentCount: Int, // Number of faces of the cylinder
        color: SCNMaterial)
    {
        super.init()
        
        //Calcul the height of our line
        let  height = v1.distance(v2)
        
        //set position to v1 coordonate
        position = v2
        
        //Create the second node to draw direction vector
        let nodeV2 = SCNNode()
        
        //define his position
        nodeV2.position = v1
        //add it to parent
        parent.addChildNode(nodeV2)
        
        //Align Z axis
        let zAlign = SCNNode()
        zAlign.eulerAngles.x = Float(M_PI_2)
        
        //create our cylinder
        let cyl = SCNCylinder(radius: radius, height: CGFloat(height))
        //cyl.radialSegmentCount = radSegmentCount
        cyl.firstMaterial?.diffuse.contents = color.diffuse.contents
        cyl.firstMaterial?.specular.contents = color.specular.contents
        
        //Create node with cylinder
        let nodeCyl = SCNNode(geometry: cyl )
        nodeCyl.position.y = Float(-height/2)
        zAlign.addChildNode(nodeCyl)
        
        //Add it to child
        addChildNode(zAlign)
        
        //set constraint direction to our vector
        constraints = [SCNLookAtConstraint(target: nodeV2)]
    }
    
    override init() {
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

private extension SCNVector3{
    func distance(_ receiver:SCNVector3) -> Float{
        let xd = receiver.x - self.x
        let yd = receiver.y - self.y
        let zd = receiver.z - self.z
        let distance = Float(sqrt(xd * xd + yd * yd + zd * zd))
        
        if (distance < 0){
            return (distance * -1)
        } else {
            return (distance)
        }
    }
}
