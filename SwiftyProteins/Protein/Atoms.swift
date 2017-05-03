//
//  Atoms.swift
//  Protein
//
//  Created by Stefan-ciprian CIRCIU on 10/24/16.
//  Copyright © 2016 Stefan-ciprian CIRCIU. All rights reserved.
//

import Foundation
import SceneKit

class Atoms :NSObject{
    var scale:Float = 1.0
    func H() -> SCNGeometry {
        let hydrogenAtom = SCNSphere(radius: 1.20)
        hydrogenAtom.firstMaterial!.diffuse.contents = UIColor.lightGray
        hydrogenAtom.firstMaterial!.specular.contents = UIColor.white
        return hydrogenAtom
    }
    
    func C() -> SCNGeometry {
        let carbonAtom = SCNSphere(radius: 1.70)
        carbonAtom.firstMaterial!.diffuse.contents = UIColor.black
        carbonAtom.firstMaterial!.specular.contents = UIColor.white
        return carbonAtom
    }
    func N() -> SCNGeometry {
        let carbonAtom = SCNSphere(radius: 1.70)
        carbonAtom.firstMaterial!.diffuse.contents = UIColor.blue //dark blue color
        carbonAtom.firstMaterial!.specular.contents = UIColor.white
        return carbonAtom
    }
    
    func O() -> SCNGeometry {
        let oxygenAtom = SCNSphere(radius: 1.52)
        oxygenAtom.firstMaterial!.diffuse.contents = UIColor.red
        oxygenAtom.firstMaterial!.specular.contents = UIColor.white
        return oxygenAtom
    }
    
    func CL() -> SCNGeometry {
        let chlorineAtom = SCNSphere(radius: 1.70)
        chlorineAtom.firstMaterial!.diffuse.contents = UIColor.green
        chlorineAtom.firstMaterial!.specular.contents = UIColor.white
        return chlorineAtom
    }
    
    func F() -> SCNGeometry {
        let fluorineAtom = SCNSphere(radius: 1.52)
        fluorineAtom.firstMaterial!.diffuse.contents = UIColor.green
        fluorineAtom.firstMaterial!.specular.contents = UIColor.white
        return fluorineAtom
    }
    
    func BR() -> SCNGeometry {
        let bromineAtom = SCNSphere(radius: 1.52)
        bromineAtom.firstMaterial!.diffuse.contents = UIColor(red: 0x8B, green: 0x00, blue: 0x00)
        bromineAtom.firstMaterial!.specular.contents = UIColor.white
        return bromineAtom
    }
    func I() -> SCNGeometry {
        let iodineAtom = SCNSphere(radius: 1.52)
        iodineAtom.firstMaterial!.diffuse.contents = UIColor(red: 0x94, green: 0x00, blue: 0xD3)
        iodineAtom.firstMaterial!.specular.contents = UIColor.white
        return iodineAtom
    }
    
    
    func HE() -> SCNGeometry {
        let helliumAtom = SCNSphere(radius: 1.52)
        helliumAtom.firstMaterial!.diffuse.contents = UIColor.cyan
        helliumAtom.firstMaterial!.specular.contents = UIColor.white
        return helliumAtom
    }
    
    func NE() -> SCNGeometry {
        let neonAtom = SCNSphere(radius: 1.52)
        neonAtom.firstMaterial!.diffuse.contents = UIColor.cyan
        neonAtom.firstMaterial!.specular.contents = UIColor.white
        return neonAtom
    }
    
    func AR() -> SCNGeometry {
        let argonAtom = SCNSphere(radius: 1.52)
        argonAtom.firstMaterial!.diffuse.contents = UIColor.cyan
        argonAtom.firstMaterial!.specular.contents = UIColor.white
        return argonAtom
    }
    func XE() -> SCNGeometry {
        let xenonAtom = SCNSphere(radius: 1.52)
        xenonAtom.firstMaterial!.diffuse.contents = UIColor.cyan
        xenonAtom.firstMaterial!.specular.contents = UIColor.white
        return xenonAtom
    }
    func KR() -> SCNGeometry {
        let kryptonAtom = SCNSphere(radius: 1.52)
        kryptonAtom.firstMaterial!.diffuse.contents = UIColor.cyan
        kryptonAtom.firstMaterial!.specular.contents = UIColor.white
        return kryptonAtom
    }
    func P() -> SCNGeometry {
        let phosphorusAtom = SCNSphere(radius: 1.52)
        phosphorusAtom.firstMaterial!.diffuse.contents = UIColor.orange
        phosphorusAtom.firstMaterial!.specular.contents = UIColor.white
        return phosphorusAtom
    }
    func S() -> SCNGeometry {
        let sulfurAtom = SCNSphere(radius: 1.52)
        sulfurAtom.firstMaterial!.diffuse.contents = UIColor.yellow
        sulfurAtom.firstMaterial!.specular.contents = UIColor.white
        return sulfurAtom
    }
    func B() -> SCNGeometry {
        let boronAtom = SCNSphere(radius: 1.52)
        boronAtom.firstMaterial!.diffuse.contents = UIColor(red:0xFA, green: 0x80, blue: 0x72)
        boronAtom.firstMaterial!.specular.contents = UIColor.white
        return boronAtom
    }
    //alkali metals
    func LI() -> SCNGeometry {
        let lithiumAtom = SCNSphere(radius: 1.52)
        lithiumAtom.firstMaterial!.diffuse.contents = UIColor(red:0xEE, green: 0x82, blue: 0xEE)
        lithiumAtom.firstMaterial!.specular.contents = UIColor.white
        return lithiumAtom
    }
    func NA() -> SCNGeometry {
        let sodiumAtom = SCNSphere(radius: 1.52)
        sodiumAtom.firstMaterial!.diffuse.contents = UIColor(red:0xEE, green: 0x82, blue: 0xEE)
        sodiumAtom.firstMaterial!.specular.contents = UIColor.white
        return sodiumAtom
    }
    func K() -> SCNGeometry {
        let kryptonAtom = SCNSphere(radius: 1.52)
        kryptonAtom.firstMaterial!.diffuse.contents = UIColor(red:0xEE, green: 0x82, blue: 0xEE)
        kryptonAtom.firstMaterial!.specular.contents = UIColor.white
        return kryptonAtom
    }
    func RB() -> SCNGeometry {
        let rubidiumAtom = SCNSphere(radius: 1.52)
        rubidiumAtom.firstMaterial!.diffuse.contents = UIColor(red:0xEE, green: 0x82, blue: 0xEE)
        rubidiumAtom.firstMaterial!.specular.contents = UIColor.white
        return rubidiumAtom
    }
    func CS() -> SCNGeometry {
        let caesiumAtom = SCNSphere(radius: 1.52)
        caesiumAtom.firstMaterial!.diffuse.contents = UIColor(red:0xEE, green: 0x82, blue: 0xEE)
        caesiumAtom.firstMaterial!.specular.contents = UIColor.white
        return caesiumAtom
    }
    func FR() -> SCNGeometry {
        let franciumAtom = SCNSphere(radius: 1.52)
        franciumAtom.firstMaterial!.diffuse.contents = UIColor(red:0xEE, green: 0x82, blue: 0xEE)
        franciumAtom.firstMaterial!.specular.contents = UIColor.white
        return franciumAtom
    }
    //alkaline earth metals
    func BE() -> SCNGeometry {
        let berylliumAtom = SCNSphere(radius: 1.52)
        berylliumAtom.firstMaterial!.diffuse.contents = UIColor(red:0x00, green: 0x64, blue: 0x00)
        berylliumAtom.firstMaterial!.specular.contents = UIColor.white
        return berylliumAtom
    }
    func MG() -> SCNGeometry {
        let magnesiumAtom = SCNSphere(radius: 1.52)
        magnesiumAtom.firstMaterial!.diffuse.contents = UIColor(red:0x00, green: 0x64, blue: 0x00)
        magnesiumAtom.firstMaterial!.specular.contents = UIColor.white
        return magnesiumAtom
    }
    func CA() -> SCNGeometry {
        let calciumAtom = SCNSphere(radius: 1.52)
        calciumAtom.firstMaterial!.diffuse.contents = UIColor(red:0x00, green: 0x64, blue: 0x00)
        calciumAtom.firstMaterial!.specular.contents = UIColor.white
        return calciumAtom
    }
    func SR() -> SCNGeometry {
        let strontiumAtom = SCNSphere(radius: 1.52)
        strontiumAtom.firstMaterial!.diffuse.contents = UIColor(red:0x00, green: 0x64, blue: 0x00)
        strontiumAtom.firstMaterial!.specular.contents = UIColor.white
        return strontiumAtom
    }
    func BA() -> SCNGeometry {
        let bariumAtom = SCNSphere(radius: 1.52)
        bariumAtom.firstMaterial!.diffuse.contents = UIColor(red:0x00, green: 0x64, blue: 0x00)
        bariumAtom.firstMaterial!.specular.contents = UIColor.white
        return bariumAtom
    }
    func RA() -> SCNGeometry {
        let radiumAtom = SCNSphere(radius: 1.52)
        radiumAtom.firstMaterial!.diffuse.contents = UIColor(red:0x00, green: 0x64, blue: 0x00)
        radiumAtom.firstMaterial!.specular.contents = UIColor.white
        return radiumAtom
    }
    //
    func TI() -> SCNGeometry {
        let titaniumAtom = SCNSphere(radius: 1.70)
        titaniumAtom.firstMaterial!.diffuse.contents = UIColor.gray
        titaniumAtom.firstMaterial!.specular.contents = UIColor.white
        return titaniumAtom
    }
    
    
    func FE() -> SCNGeometry {
        let ironAtom = SCNSphere(radius: 1.70)
        ironAtom.firstMaterial!.diffuse.contents = UIColor.orange
        ironAtom.firstMaterial!.specular.contents = UIColor.white
        return ironAtom
    }
    //other elements cpk coloring pink
    
    func OTHER() -> SCNGeometry {
        let otherAtom = SCNSphere(radius: 1.70)
        otherAtom.firstMaterial!.diffuse.contents = UIColor(red:0.87, green:0.47, blue:1.00, alpha:1.0)
        otherAtom.firstMaterial!.specular.contents = UIColor.white
        return otherAtom
    }
}


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}
