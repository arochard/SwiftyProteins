//
//  Ligands.swift
//  Protein
//
//  Created by Jean-philippe LABRO on 10/25/16.
//  Copyright © 2016 Stefan-ciprian CIRCIU. All rights reserved.
//

import Foundation
import SceneKit

class ligand:NSObject, NSCoding{
    var id:String?
    var name:String?
    var formula:NSString?
    var allPositions:[SCNVector3] = []      //x,y,z
    var elem:[String] = []                  //H
    var allName:[String] = []               //H44
    var allLinks:[link] = []
    
    override init(){
        super.init()
    }
    required init(coder aDecoder: NSCoder) {
        super.init()
        let count  = aDecoder.decodeObject(forKey: "countPosition") as! Int
        self.id = aDecoder.decodeObject(forKey: "id") as? String
        self.name = aDecoder.decodeObject(forKey: "name") as? String
        self.formula = aDecoder.decodeObject(forKey: "formula") as? String as NSString?
        for index in 0..<count{
            self.allPositions.append(SCNVector3Make(
                aDecoder.decodeObject(forKey: "x\(index)") as! Float,
                aDecoder.decodeObject(forKey: "y\(index)") as! Float,
                aDecoder.decodeObject(forKey: "z\(index)") as! Float
            ))
        }
        //print(self.allPositions)
        self.elem = aDecoder.decodeObject(forKey: "elem") as! Array
        self.allName = aDecoder.decodeObject(forKey: "allName") as! Array
        self.allLinks = aDecoder.decodeObject(forKey: "allLinks") as! [link]
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(formula, forKey: "formula")
        aCoder.encode(self.allPositions.count, forKey: "countPosition")
        for index in 0..<self.allPositions.count{
            aCoder.encode(self.allPositions[index].x, forKey: "x\(index)")
            aCoder.encode(self.allPositions[index].y, forKey: "y\(index)")
            aCoder.encode(self.allPositions[index].z, forKey: "z\(index)")
        }
        aCoder.encode(elem, forKey: "elem")
        aCoder.encode(allName, forKey: "allName")
        //Encoding tuple allLinks
        aCoder.encode(self.allLinks, forKey: "allLinks")
        
    }
}

class link:NSObject, NSCoding{
    var node1:String?
    var node2:String?
    var is_double:Bool?
    
    init(node1:String, node2:String, is_double:Bool){
        self.node1 = node1
        self.node2 = node2
        self.is_double = is_double
    }
    required init(coder aDecoder: NSCoder) {
        self.node1 = aDecoder.decodeObject(forKey: "node1") as? String
        self.node2 = aDecoder.decodeObject(forKey: "node2") as? String
        self.is_double = aDecoder.decodeObject(forKey: "is_double") as? Bool
        super.init()
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(node1, forKey: "node1")
        aCoder.encode(node2, forKey: "node2")
        aCoder.encode(is_double, forKey: "is_double")
    }
}

