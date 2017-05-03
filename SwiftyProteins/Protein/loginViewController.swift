//
//  loginViewController.swift
//  Protein
//
//  Created by Jean-philippe LABRO on 10/26/16.
//  Copyright © 2016 Stefan-ciprian CIRCIU. All rights reserved.
//

import UIKit
import LocalAuthentication
import SceneKit

class loginViewController: UIViewController {
    
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var bgLoginView: UIImageView!
    let dataApp = UserDefaults.standard
    var allLigands:[ligand] = []
    let alertController = UIAlertController(title: nil, message: "Chargement des ligands\n\n", preferredStyle: UIAlertControllerStyle.alert)
    var countFailDownloaded:Int = 0
    
    //Authentification effectue ?
    var islogged:Bool = false{
        didSet{
            if self.downloaded == true{
                self.alertWait(true)
            }
            else{
                
                    self.alertWait(false)
            }
            if self.downloaded == false && islogged == true{
                self.performSegue(withIdentifier: "showLigandList", sender: self)
            }
        }
    }
    //Chargement des ligands ?
    var downloaded:Bool = false {
        didSet{
            if self.downloaded == false && islogged == true{
                self.performSegue(withIdentifier: "showLigandList", sender: self)
            }
            
        }
    }
    let group:DispatchGroup = DispatchGroup();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Si deja charge
        if let data = self.dataApp.object(forKey: "allLigands") as? Data {
            self.allLigands = (NSKeyedUnarchiver.unarchiveObject(with: data) as? Array)!
        }
        else{
            self.downloaded = true
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            self.getFileData()
        }
        self.authenticateUser()
        self.loginButton.layer.cornerRadius = 10
        self.loginButton.tintColor = UIColor(red:0.07, green:0.13, blue:0.47, alpha:1.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func loginActionButton(_ sender: AnyObject) {
        self.authenticateUser()
    }
    
    func authenticateUser() {
        
        let context : LAContext = LAContext()
        var error: NSError?
        let reasonString = "Authentication is needed to access application."
        
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reasonString){
                (success, error) in
                if success {
                    OperationQueue.main.addOperation({ () -> Void in
                        self.islogged = true
                    })
                }
                else{
                    DispatchQueue.main.async(execute: {
                        self.showPasswordAlert()
                    })
                    switch error!._code{
                    case LAError.Code.systemCancel.rawValue:
                        print("Authentication was cancelled by the system")
                    case LAError.Code.userCancel.rawValue:
                        print("Authentication was cancelled by the user")
                    case LAError.Code.userFallback.rawValue:
                        print("User selected to enter custom password")
                    default:
                        print("Authentication failed")
                        break
                    }
                }
            }
        }
        else if (context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthentication, error: &error)){
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reasonString){
                (success, error) in
                if success {
                    OperationQueue.main.addOperation({ () -> Void in
                        self.islogged = true
                    })
                }
                else{
                    DispatchQueue.main.async(execute: {
                        self.showPasswordAlert()
                    })
                    switch error!._code{
                    case LAError.Code.systemCancel.rawValue:
                        print("Authentication was cancelled by the system")
                        
                    case LAError.Code.userCancel.rawValue:
                        print("Authentication was cancelled by the user")
                    default:
                        print("Authentication failed")
                    }
                }
            }
        }
        else{
            self.showPasswordAlert()
        }
    }
    
    override   func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLigandList"
        {
            let navC = segue.destination as! UINavigationController
            let targetController = navC.topViewController as! searchListController
            targetController.allLigands = self.allLigands
            targetController.countFailDownloaded = self.countFailDownloaded
        }
    }
    
    func getFileData()
    {
        let queue:DispatchQueue = DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default);

        if let path = Bundle.main.path(forResource: "ligands", ofType: "txt") {
            do {
                let content = try NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue)
                let data = content.components(separatedBy: "\n")
                queue.async {
                    for item in data{
                        self.group.enter()
                        self.getDetailsLigand(item)
                    }
                    
                    self.group.notify(queue: DispatchQueue.main) {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let dataLig = NSKeyedArchiver.archivedData(withRootObject: self.allLigands)
                        if (self.countFailDownloaded == 0){
                            self.dataApp.set(dataLig, forKey:"allLigands")
                            self.dataApp.synchronize()
                        }
                        self.downloaded = false
                    }
                }
                
            }
            catch {
                print("error")
            }
        }
        else{
            print("ligands.txt not found!")
        }
    }
    
    func getDetailsLigand(_ item:String)
    {
        var fg:Int = 0
        let tmp = "https://files.rcsb.org/ligands/view/\(item).cif".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        guard let url = URL(string: tmp!) else{
            print("ligandDetails not Found")
            self.group.leave()
            countFailDownloaded += 1
            return;
        }
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            //print(response)
            if let err = error{
                print("\(err)")
                self.countFailDownloaded += 1
                self.group.leave()
                
            }
            else if let d = data
            {
                do
                {
                    if let  strData = NSString(data: d, encoding: String.Encoding.utf8.rawValue)
                    {
                        let splitData = strData.condenseWhitespace()
                        //print (splitData)
                        let lig = ligand()
                        lig.id = item
                        for line in splitData
                        {
                            //INfo ==> name, formula, id
                            if (line as! NSString).contains("_chem_comp.formula ") {
                                if ((line as AnyObject).components(separatedBy: "\"").count > 2){
                                    let formula = (line as AnyObject).components(separatedBy: "\"")
                                    if (formula.count >= 2){
                                        lig.formula = formula[1] as NSString?
                                    }
                                }
                                else{
                                    let formula = (line as AnyObject).components(separatedBy: " ")
                                    if (formula.count >= 2){
                                        lig.formula = formula[1] as NSString?
                                    }
                                }
                            }
                            else if (line as! NSString).contains("_chem_comp.name ") {
                                if ((line as AnyObject).components(separatedBy: "\"").count > 2){
                                    let name = (line as AnyObject).components(separatedBy: "\"")
                                    if (name.count >= 2){
                                        lig.name = name[1]
                                    }
                                }
                                else{
                                    let name = (line as AnyObject).components(separatedBy: " ")
                                    if (name.count >= 2){
                                        lig.name = name[1]
                                    }
                                }
                            }
                            //Position
                            if (fg <= 1 && strncmp((line as! String), item, 3) == 0){
                                var info = (line as AnyObject).components(separatedBy: " ")
                                if (info.count >= 15){
                                    info[12] = (info[12] as String != "?" ? info[12]:(info[9] as String != "?" ? info[9]:"0"))
                                    info[13] = (info[13] as String != "?" ? info[13]:(info[10] as String != "?" ? info[10]:"0"))
                                    info[14] = (info[14] as String != "?" ? info[14]:(info[11] as String != "?" ? info[11]:"0"))
                                    lig.allPositions.append(SCNVector3Make(Float(info[12])!, Float(info[13])!, Float(info[14])!))
                                    lig.elem.append(info[3] as String)
                                    lig.allName.append(info[1] as String)
                                }
                                fg = 1
                            }
                            else if (fg == 1 && line as! String == "#"){
                                fg = 2
                            }
                            //Link
                            else if (fg > 1 && fg <= 3 && strncmp((line as! String), item, 3) == 0){
                                let info = (line as AnyObject).components(separatedBy: " ")
                                //print(info)
                                if (info.count >= 6){
                                    let is_double = (info[3] as String == "DOUB" ? true:false)
                                    lig.allLinks.append(link(node1: info[1], node2: info[2], is_double: is_double))
                                }
                                fg = 3
                            }
                            else if (fg == 3 && line as! String == "#"){
                                fg = 4
                            }
                        }
                        self.allLigands.append(lig)
                        self.group.leave()
                    }
                }
            }
        }
        task.resume()
    }
    //Alert wait activity monitor
    func alertWait(_ animated: Bool)
    {
        if (animated == false){
            self.alertController.dismiss(animated: true, completion: nil)
            return;
        }
        let spinnerIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        
       
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        
        self.alertController.view.addSubview(spinnerIndicator)
        self.present(alertController, animated: false, completion: nil)
        
    }
    //Alert error login
    func showPasswordAlert() {
        let passwordAlert = UIAlertController(title: "Sorry !", message: "You can't access to application :(", preferredStyle: UIAlertControllerStyle.alert)
        passwordAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
        }))
        present(passwordAlert, animated: true, completion: nil)
    }
}

