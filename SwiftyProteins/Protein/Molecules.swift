//
//  Molecules.swift
//  Protein
//
//  Created by Stefan-ciprian CIRCIU on 10/25/16.
//  Copyright © 2016 Stefan-ciprian CIRCIU. All rights reserved.
//

import Foundation
import SceneKit

class Molecules {
    var formula:ligand?
    
    init(formula:ligand){
        self.formula = formula
    }
    class func Molecule() -> SCNNode {
        let Molecule = SCNNode()
        return Molecule
    }
    
    func nodeWithAtom(_ atom: SCNGeometry, molecule: SCNNode, position: SCNVector3, name: String) -> SCNNode {
        let node = SCNNode(geometry: atom)
        node.position = position
        node.name = "\(name)"
        node.description
        molecule.addChildNode(node)
        return node
    }
    func cylinderEulear(_ vec1:SCNVector3, vec2:SCNVector3) -> SCNVector3 {
        let dir:SCNVector3 = SCNVector3Make(vec1.x - vec2.x, vec1.y - vec2.y, vec1.z - vec2.z)
        let mag = pow(pow(dir.x,2.0) + pow(dir.y,2.0) + pow(dir.z,2.0), 0.5)
        return SCNVector3Make(dir.x/mag, dir.y/mag, dir.z/mag)
    }
    func    makeAtoms() -> SCNNode{
        let a = Atoms()
        //TI FE
        let transitionmetals = ["Sc", "V","CR","MN","CO","NI","CU","Y","ZR","NB",
                                "Mo","TC","RU","RH","PD","AG","HF","TA", "W","RE","OS",
                                "IR","PT","AU","RF","DB","SG","BH","HS","MT","DS","RG"]
        let atomsNode = SCNNode()
        if formula!.allPositions.count == 0 {
            formula!.allPositions.append(SCNVector3Make( 0.0,0.0,0.0))
            formula!.elem.append(formula!.id!)
            formula!.allName.append(formula!.id!)
        }
        for index in 0..<formula!.allPositions.count{
            if let _ = transitionmetals.index(where: {$0 == self.formula!.elem[index]}){
                let newNode = SCNNode(geometry: a.B())
                newNode.position = SCNVector3Make(formula!.allPositions[index].x, formula!.allPositions[index].y, formula!.allPositions[index].z)
                newNode.name = formula!.allName[index]
                atomsNode.addChildNode(newNode)
            }
            else{
                if a.responds(to: NSSelectorFromString(self.formula!.elem[index])){
                let element = a.perform(NSSelectorFromString(self.formula!.elem[index])).takeUnretainedValue() as? SCNGeometry
                    let newNode = SCNNode(geometry: element)
                    newNode.position = SCNVector3Make(self.formula!.allPositions[index].x, self.formula!.allPositions[index].y, self.formula!.allPositions[index].z)
                    newNode.name = self.formula!.allName[index]
                    atomsNode.addChildNode(newNode)
                }
                else{
                    let newNode = SCNNode(geometry: a.OTHER())
                    newNode.position = SCNVector3Make(self.formula!.allPositions[index].x, self.formula!.allPositions[index].y, self.formula!.allPositions[index].z)
                    newNode.name = self.formula!.allName[index]
                    atomsNode.addChildNode(newNode)
                }
            }
        }
        
        
        return atomsNode
        
    }

    func    makeAtomswithSticks() -> SCNNode{
        let a = Atoms()
        //TI FE
        let transitionmetals = ["Sc", "V","CR","MN","CO","NI","CU","Y","ZR","NB",
                                "Mo","TC","RU","RH","PD","AG","HF","TA", "W","RE","OS",
                                "IR","PT","AU","RF","DB","SG","BH","HS","MT","DS","RG"]
        let atomsNode = SCNNode()
        if formula!.allPositions.count == 0 {
            formula!.allPositions.append(SCNVector3Make( 0.0,0.0,0.0))
            formula!.elem.append(formula!.id!)
            formula!.allName.append(formula!.id!)
        }
        for index in 0..<formula!.allPositions.count{
            var newGeometry:SCNSphere!
            if let _ = transitionmetals.index(where: {$0 == self.formula!.elem[index]}){
                newGeometry = a.B() as! SCNSphere
                newGeometry.radius = newGeometry.radius * 0.2
                let newNode = SCNNode(geometry: newGeometry as SCNGeometry)
                newNode.position = SCNVector3Make(formula!.allPositions[index].x, formula!.allPositions[index].y, formula!.allPositions[index].z)
                newNode.name = formula!.allName[index]
                atomsNode.addChildNode(newNode)
            }
            else{
                if a.responds(to: NSSelectorFromString(self.formula!.elem[index])){
                    let element = a.perform(NSSelectorFromString(self.formula!.elem[index])).takeUnretainedValue() as? SCNGeometry
                    newGeometry = element as! SCNSphere
                    newGeometry.radius = newGeometry.radius * 0.2
                    let newNode = SCNNode(geometry: newGeometry as SCNGeometry)
                    newNode.position = SCNVector3Make(self.formula!.allPositions[index].x, self.formula!.allPositions[index].y, self.formula!.allPositions[index].z)
                    newNode.name = self.formula!.allName[index]
                    atomsNode.addChildNode(newNode)
                }
                else{
                    newGeometry = a.OTHER() as! SCNSphere
                    newGeometry.radius = newGeometry.radius * 0.2
                    let newNode = SCNNode(geometry: newGeometry as SCNGeometry)
                    newNode.position = SCNVector3Make(self.formula!.allPositions[index].x, self.formula!.allPositions[index].y, self.formula!.allPositions[index].z)
                    newNode.name = self.formula!.allName[index]
                    atomsNode.addChildNode(newNode)
                }
            }
        }
        for index in 0..<formula!.allLinks.count{
            stickWithAtoms((formula?.allLinks[index].node1)!, atom2: (formula?.allLinks[index].node2)!, molecule: atomsNode, is_double: (formula!.allLinks[index].is_double!))
        }
        
        return atomsNode
        
    }
    func stickWithAtoms(_ atom1: String ,atom2: String, molecule: SCNNode, is_double: Bool) {
        let node1 = molecule.childNode(withName: "\(atom1)", recursively: true)
        let node2 = molecule.childNode(withName: "\(atom2)", recursively: true)
        var pos1 = node1!.position
        var pos2 = node2!.position
        var posmiddle:SCNVector3!
        
            posmiddle = SCNVector3Make((pos1.x + pos2.x) / 2,
                                       (pos1.y + pos2.y) / 2,
                                       (pos1.z + pos2.z) / 2)
        if is_double == false{
        molecule.addChildNode( CylinderLine(parent: molecule,v1: pos1,v2: posmiddle,radius: 0.05, radSegmentCount: 1,  color: node1!.geometry!.firstMaterial!))
        molecule.addChildNode( CylinderLine(parent: molecule,v1: pos2,v2: posmiddle,radius: 0.05, radSegmentCount: 1,  color: node2!.geometry!.firstMaterial!))
        }
        else {
            pos1 = SCNVector3Make(pos1.x + 0.055, pos1.y + 0.055, pos1.z)
            pos2 = SCNVector3Make(pos2.x + 0.055, pos2.y + 0.055, pos2.z)
            posmiddle = SCNVector3Make((pos1.x + pos2.x) / 2,
                                       (pos1.y + pos2.y) / 2,
                                       (pos1.z + pos2.z) / 2)
            molecule.addChildNode( CylinderLine(parent: molecule,v1: pos1,v2: posmiddle,radius: 0.05, radSegmentCount: 1,  color: node1!.geometry!.firstMaterial!))
            molecule.addChildNode( CylinderLine(parent: molecule,v1: pos2,v2: posmiddle,radius: 0.05, radSegmentCount: 1,  color: node2!.geometry!.firstMaterial!))
            pos1 = SCNVector3Make(pos1.x - 0.11, pos1.y - 0.11, pos1.z)
            pos2 = SCNVector3Make(pos2.x - 0.11, pos2.y - 0.11, pos2.z)
            posmiddle = SCNVector3Make((pos1.x + pos2.x) / 2,
                                       (pos1.y + pos2.y) / 2,
                                       (pos1.z + pos2.z) / 2)
            molecule.addChildNode( CylinderLine(parent: molecule,v1: pos1,v2: posmiddle,radius: 0.05, radSegmentCount: 1,  color: node1!.geometry!.firstMaterial!))
            molecule.addChildNode( CylinderLine(parent: molecule,v1: pos2,v2: posmiddle,radius: 0.05, radSegmentCount: 1,  color: node2!.geometry!.firstMaterial!))
        }
    }
    
}
