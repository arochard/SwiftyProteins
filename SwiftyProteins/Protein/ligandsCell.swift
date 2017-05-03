//
//  ligandsCell.swift
//  Protein
//
//  Created by Jean-philippe LABRO on 10/25/16.
//  Copyright © 2016 Stefan-ciprian CIRCIU. All rights reserved.
//

import UIKit
import SceneKit

class ligandClass:UITableViewCell {
    
    var colorCPK:[(name: String, color:UIColor)] = [
        (name:"H", color:UIColor.lightGray),
        (name:"C", color:UIColor.black),
        (name:"N", color:UIColor.blue),
        (name:"O", color:UIColor.red),
        (name:"F", color:UIColor.green),
        (name:"Cl", color:UIColor.green),
        (name:"B", color:UIColor(red:1.00, green:0.67, blue:0.47, alpha:1.0)),
        (name:"Br", color:UIColor(red:0.60, green:0.13, blue:0.00, alpha:1.0)),
        (name:"I", color:UIColor(red:0.40, green:0.00, blue:0.73, alpha:1.0)),
        (name:"He", color:UIColor(red:0.00, green:1.00, blue:0.98, alpha:1.0)),
        (name:"Ne", color:UIColor(red:0.00, green:1.00, blue:0.98, alpha:1.0)),
        (name:"Ar", color:UIColor(red:0.00, green:1.00, blue:0.98, alpha:1.0)),
        (name:"Xe", color:UIColor(red:0.00, green:1.00, blue:0.98, alpha:1.0)),
        (name:"Kr", color:UIColor(red:0.00, green:1.00, blue:0.98, alpha:1.0)),
        (name:"P", color:UIColor(red:1.00, green:0.60, blue:0.00, alpha:1.0)),
        (name:"S", color:UIColor(red:0.87, green:0.87, blue:0.00, alpha:1.0)),
        (name:"Li", color:UIColor(red:0.47, green:0.00, blue:1.00, alpha:1.0)),
        (name:"Na", color:UIColor(red:0.47, green:0.00, blue:1.00, alpha:1.0)),
        (name:"K", color:UIColor(red:0.47, green:0.00, blue:1.00, alpha:1.0)),
        (name:"Rb", color:UIColor(red:0.47, green:0.00, blue:1.00, alpha:1.0)),
        (name:"Cs", color:UIColor(red:0.47, green:0.00, blue:1.00, alpha:1.0)),
        (name:"Fr", color:UIColor(red:0.47, green:0.00, blue:1.00, alpha:1.0)),
        (name:"Be", color:UIColor(red:0.00, green:0.47, blue:0.00, alpha:1.0)),
        (name:"Mg", color:UIColor(red:0.00, green:0.47, blue:0.00, alpha:1.0)),
        (name:"Ca", color:UIColor(red:0.00, green:0.47, blue:0.00, alpha:1.0)),
        (name:"Sr", color:UIColor(red:0.00, green:0.47, blue:0.00, alpha:1.0)),
        (name:"Ba", color:UIColor(red:0.00, green:0.47, blue:0.00, alpha:1.0)),
        (name:"Ra", color:UIColor(red:0.00, green:0.47, blue:0.00, alpha:1.0)),
        (name:"Ti", color:UIColor(red:0.60, green:0.60, blue:0.60, alpha:1.0)),
        (name:"Fe", color:UIColor(red:0.87, green:0.47, blue:0.00, alpha:1.0)),
        (name:"other", color:UIColor(red:0.87, green:0.47, blue:1.00, alpha:1.0))
        
    ]
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var formula: UILabel!
    @IBOutlet weak var name: UILabel!
    var allPositions:[SCNVector3] = []
    var elem:[String] = []
    var allName:[String] = []
    var allLinks:[link] = []
    
    var ligands: ligand?
    {
        didSet
        {
            if let d = ligands
            {
                id.text = d.id
                formula.attributedText = self.addColorFormula(d.formula! as String as String as NSString)
                name.text = d.name
                allPositions = d.allPositions
                elem = d.elem
                allName = d.allName
                allLinks = d.allLinks
            }
        }
    }
    func addColorFormula(_ formula:NSString) -> NSAttributedString{
        let formulaAttrib = NSMutableAttributedString(string:formula as String)
        let splitFormula = formula.components(separatedBy: " ")
        for value in splitFormula{
            let seperateValue = (value.components(separatedBy: CharacterSet.decimalDigits) as NSArray).componentsJoined(by: "")
            let range = formula.range(of: seperateValue)
            for color in colorCPK{
                if (seperateValue == color.name){
                    formulaAttrib.addAttribute(NSForegroundColorAttributeName, value: color.color , range: range)
                    break;
                }
                if (color.name == colorCPK.last!.name){
                    formulaAttrib.addAttribute(NSForegroundColorAttributeName, value: color.color , range: range)
                }
            }
        }
        return formulaAttrib
    }
}

