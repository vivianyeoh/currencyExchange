//
//  ViewController.swift
//  Rate Conversion
//
//  Created by Vivian on 17/08/2017.
//  Copyright © 2017 Vivian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cmyr: UITextField!
    @IBOutlet weak var cwon: UITextField!
    @IBOutlet weak var orimyr: UITextField!
    @IBOutlet weak var oriwon: UITextField!
    @IBOutlet weak var btnReset: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cmyr.text = "0.0"
        cwon.text = "0.0"
        orimyr.text = "1.0"
        oriwon.text = "1.0"
        
        
        let myrrate = UserDefaults.standard.string(forKey: "myrrate")
        let gbprate = UserDefaults.standard.string(forKey: "wonrate")
        let myrc = UserDefaults.standard.string(forKey: "myrc")
        let gbpc = UserDefaults.standard.string(forKey: "wonc")
        if myrrate != nil{
            orimyr.text = myrrate
        }
        if gbprate != nil{
            oriwon.text = gbprate
        }
        if myrc != nil{
            cmyr.text = myrc
        }
        if gbpc != nil{
            cwon.text = gbpc
        }

        
    }
    
    override func viewDidLayoutSubviews() {
        btnReset.layer.borderWidth = 1
        btnReset.layer.masksToBounds = false
        btnReset.layer.borderColor = UIColor.black.cgColor
        btnReset.layer.cornerRadius = btnReset.frame.height/2
        btnReset.clipsToBounds = true
    }
    
    @IBAction func reset(_ sender: Any) {
        cmyr.text = "0.0"
        cwon.text = "0.0"
        orimyr.text = "1.0"
        oriwon.text = "1.0"
        UserDefaults.standard.set(oriwon.text, forKey: "wonrate")
        UserDefaults.standard.set(orimyr.text, forKey: "myrrate")
        UserDefaults.standard.set(cmyr.text, forKey: "myrc")
        UserDefaults.standard.set(cwon.text, forKey: "wonc")
    }
    
    @IBAction func Con1(_ sender: Any) {
        guard let wonrate = cwon.text?.doubleValue , let myrval = orimyr.text?.doubleValue , let wonval = oriwon.text?.doubleValue else {
            cwon.text = "0.0"
            orimyr.text = "1.0"
            oriwon.text = "1.0"
            return
        }
        
        if wonrate != 0 {
            cmyr.text = String((myrval/wonval*wonrate).rounded(toPlaces: 4))
        }else{
            cmyr.text = "0.0"
        }
        
        UserDefaults.standard.set(wonval, forKey: "wonrate")
        UserDefaults.standard.set(myrval, forKey: "myrrate")
        UserDefaults.standard.set(cmyr.text, forKey: "myrc")
        UserDefaults.standard.set(cwon.text, forKey: "wonc")
    }
    
    
    @IBAction func con2(_ sender: Any) {
        guard let myrrate = cmyr.text?.doubleValue , let myrval = orimyr.text?.doubleValue , let wonval = oriwon.text?.doubleValue else{
            cmyr.text = "0.0"
            orimyr.text = "1.0"
            oriwon.text = "1.0"
            return
        }
        
        if myrrate != 0 {
            cwon.text = String((wonval/myrval*myrrate).rounded(toPlaces: 4))
        }else{
            cwon.text = "0.0"
        }
        
        UserDefaults.standard.set(wonval, forKey: "wonrate")
        UserDefaults.standard.set(myrval, forKey: "myrrate")
        UserDefaults.standard.set(cmyr.text, forKey: "myrc")
        UserDefaults.standard.set(cwon.text, forKey: "wonc")
    }
    
    @IBAction func FindMYR(_ sender: Any) {
        guard let myrrate = cmyr.text?.doubleValue , let wonval = cwon.text?.doubleValue else{
            cmyr.text = "0.0"
            cwon.text = "0.0"
            orimyr.text = "1.0"
            UserDefaults.standard.set(oriwon.text, forKey: "wonrate")
            UserDefaults.standard.set(orimyr.text, forKey: "myrrate")
            UserDefaults.standard.set(cmyr.text, forKey: "myrc")
            UserDefaults.standard.set(cwon.text, forKey: "wonc")
            return
        }
        
        if wonval != 0 && myrrate != 0 {
            oriwon.text = String((wonval/myrrate*1).rounded(toPlaces: 6))
            
        }else{
            oriwon.text = "1.0"
        }
        orimyr.text = "1.0"
        UserDefaults.standard.set(oriwon.text, forKey: "wonrate")
        UserDefaults.standard.set(orimyr.text, forKey: "myrrate")
        UserDefaults.standard.set(cmyr.text, forKey: "myrc")
        UserDefaults.standard.set(cwon.text, forKey: "wonc")

    }
    
    
    @IBAction func FindGBP(_ sender: Any) {
        guard let myrval = cmyr.text?.doubleValue , let wonrate = cwon.text?.doubleValue else{
            cmyr.text = "0.0"
            cwon.text = "0.0"
            oriwon.text = "1.0"
            UserDefaults.standard.set(oriwon.text, forKey: "wonrate")
            UserDefaults.standard.set(orimyr.text, forKey: "myrrate")
            UserDefaults.standard.set(cmyr.text, forKey: "myrc")
            UserDefaults.standard.set(cwon.text, forKey: "wonc")
            return
        }
        
        if myrval != 0 && wonrate != 0 {
            orimyr.text = String((myrval/wonrate*1).rounded(toPlaces: 6))
        }else{
            orimyr.text = "1.0"
        }
        
        oriwon.text = "1.0"
        UserDefaults.standard.set(oriwon.text, forKey: "wonrate")
        UserDefaults.standard.set(orimyr.text, forKey: "myrrate")
        UserDefaults.standard.set(cmyr.text, forKey: "myrc")
        UserDefaults.standard.set(cwon.text, forKey: "wonc")

    }
}

extension String {

    var doubleValue: Double? {
        return Double(self)
    }
}

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
