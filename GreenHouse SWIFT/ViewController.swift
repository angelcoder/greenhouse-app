/*//
//  ViewController.swift
//  GreenHouse SWIFT
//
//  Created by Anhelina Lohvina on 25.05.2018.
//  Copyright © 2018 Anhelina Lohvina. All rights reserved.
//

import UIKit

class V
: UIViewController {
    var windows:Int = 4
    var n_open:Int = 0
    var heaters:Int = 1
    var n_heater_on:Int = 0
    var temp:Double = 19.6
    var hum:Double = 50.0
    var switcher:Bool = true
    var state:String = "yes"
    var condition:Bool = true

    func setGreenhouse() {
        windows=4
        n_open=0
        heaters=1
        n_heater_on=0
        temp=19.6
        hum=50.0
        switcher=true
    }
    func openWind() {
        if switcher == false {
            infobox.text = "Can't open because it's an emergency condition"
        }
        else {
            if n_open < windows
            {
            n_open=n_open+1
            infobox.text = "YOU HAVE OPENED A WINDOW" + "\n"
                        + "Windows total \(windows)" + "\n" + "Windows opened \(n_open)"
            }
            else {infobox.text = "ALL WINDOWS ARE OPENED"}
        }
    }
 
    func closeWind() {
        if n_open > 0 {
            n_open=n_open-1
            infobox.text = "YOU HAVE CLOSED A WINDOW" + "\n"
                + "Windows total \(windows)" + "\n" + "Windows opened \(n_open)"
        }
        else {infobox.text = "ALL WINDOWS ARE CLOSED"}
    }
    
    func heaterOn() {
        if switcher == false {
            infobox.text = "Can't turn on because it's an emergency condition"
        }
        else {
            if n_heater_on < heaters
            {
                n_heater_on=n_heater_on+1;
                infobox.text = "YOU HAVE TURNED ON A HEATER" + "\n"
                    + "Heaters total \(heaters)" + "\n" + "Heaters on \(n_heater_on)"
            }
            else {infobox.text = "ALL HEATERS ARE ON"}
        }
    }
    func heaterOff() {
        if n_heater_on > 0 {
            n_heater_on=n_heater_on-1
            infobox.text = "YOU HAVE TURNED OFF A HEATER" + "\n"
                + "Heaters total \(heaters)" + "\n" + "Heaters on \(n_heater_on)"
        }
        else {infobox.text = "ALL HEATERS ARE OFF"}
    }
    func climateChange(){
        let temp_old:Double = temp
        let hum_old:Double = hum
        if hum_old<65 { temp=temp-4.8-Double(n_open)*1.1+Double(n_heater_on)*1.8}
        else {temp=temp-3.2-Double(n_open)*1.2+Double(n_heater_on)*1.6+Double(hum_old)*0.016}
        if temp_old>15.0 {hum=hum-3.4*log10(abs(Double(n_open)-Double(n_heater_on))+1)/log10(2)}
        else {hum=hum+(Double(n_open)-Double(n_heater_on))*3.0}
    }
    func checkCondition(){
        if temp<(3.0+hum*0.11) || temp>50.0 || hum<6.8 || hum>80.7
           {
            switcher=false
            n_open=0
            n_heater_on=0
        }
    }
    
    func timePassModel(){
        if switcher == true {
            climateChange()
            checkCondition()
            infobox.text = "Windows total \(windows)" + "\n"
                + "Windows opened \(n_open)" + "\n"
                + "Heaters total \(heaters)" + "\n"
                + "Heaters on \(n_heater_on)" + "\n"
                + "Temperature \(temp)" + "\n"
                + "Humidity \(hum)"
 
        }
        else {infobox.text = "Emergency condition!"
            myImage.image = UIImage(named: "Burning.png")
        }
    }
 
    func greenhouseState() -> String {
        if switcher != false {state = "working"}
        else {state = "not working"}
        return state
    }
    
    @IBOutlet weak var infobox: UILabel!
    @IBOutlet weak var output: UILabel!
    @IBOutlet weak var inputPas: UITextField!
    @IBOutlet weak var myImage: UIImageView!

    let image1 = UIImage(named: "yourImage.png")
    
    @IBAction func start(_ sender: UIButton) {
        output.text = (inputPas.text)!
        if output.text == "" { infobox.text = "please, enter your password"}
        else if output.text != "angelina" { infobox.text = "your password is incorrect" }
        else if output.text == "angelina" {infobox.text = "YOU HAVE A FULL ACCESS"
            myImage.image = UIImage(named: "Normal.png")
        }
    }
    @IBAction func buttons(_ sender: UIButton) {
        output.text = (inputPas.text)!
        if output.text == "" { infobox.text = "please, enter your password"}
        else if output.text != "angelina" { infobox.text = "your password is incorrect" }
        else if output.text == "angelina" {
            if sender.tag == 1 //open window
            {
                openWind()
            }
            else if sender.tag == 2 //close window
            {
                closeWind()
            }
            else if sender.tag == 3 //heater on
            {
                heaterOn()
            }
            else if sender.tag == 4 //heater off
            {
                heaterOff()
            }
            else if sender.tag == 5 //time
            {
                infobox.text = "Greenhouse condition: " + greenhouseState() + "\n"
                    + "Windows total \(windows)" + "\n"
                    + "Windows opened \(n_open)" + "\n"
                    + "Heaters total \(heaters)" + "\n"
                    + "Heaters on \(n_heater_on)" + "\n"
                    + "Temperature \(temp)" + "\n"
                    + "Humidity \(hum)"
            }
            else if sender.tag == 6 //finish
            {
                timePassModel()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//
//  ViewController.swift
//  GreenHouse SWIFT
//
//  Created by Anhelina Lohvina on 25.05.2018.
//  Copyright © 2018 Anhelina Lohvina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var windows:Int = 4
    var n_open:Int = 0
    var heaters:Int = 1
    var n_heater_on:Int = 0
    var temp:Double = 19.6
    var hum:Double = 50.0
    var switcher:Bool = true
    var state:String = "yes"
    var condition:Bool = true
    
    func setGreenhouse() {
        windows=4
        n_open=0
        heaters=1
        n_heater_on=0
        temp=19.6
        hum=50.0
        switcher=true
    }
    func openWind() {
        if switcher == false {
            infobox.text = "Can't open because it's an emergency condition"
        }
        else {
            if n_open < windows
            {
                n_open=n_open+1
                infobox.text = "YOU HAVE OPENED A WINDOW" + "\n"
                    + "Windows total \(windows)" + "\n" + "Windows opened \(n_open)"
            }
            else {infobox.text = "ALL WINDOWS ARE OPENED"}
        }
    }
    
    func closeWind() {
        if n_open > 0 {
            n_open=n_open-1
            infobox.text = "YOU HAVE CLOSED A WINDOW" + "\n"
                + "Windows total \(windows)" + "\n" + "Windows opened \(n_open)"
        }
        else {infobox.text = "ALL WINDOWS ARE CLOSED"}
    }
    
    func heaterOn() {
        if switcher == false {
            infobox.text = "Can't turn on because it's an emergency condition"
        }
        else {
            if n_heater_on < heaters
            {
                n_heater_on=n_heater_on+1;
                infobox.text = "YOU HAVE TURNED ON A HEATER" + "\n"
                    + "Heaters total \(heaters)" + "\n" + "Heaters on \(n_heater_on)"
            }
            else {infobox.text = "ALL HEATERS ARE ON"}
        }
    }
    func heaterOff() {
        if n_heater_on > 0 {
            n_heater_on=n_heater_on-1
            infobox.text = "YOU HAVE TURNED OFF A HEATER" + "\n"
                + "Heaters total \(heaters)" + "\n" + "Heaters on \(n_heater_on)"
        }
        else {infobox.text = "ALL HEATERS ARE OFF"}
    }
    func climateChange(){
        let temp_old:Double = temp
        let hum_old:Double = hum
        if hum_old<65 { temp=temp-4.8-Double(n_open)*1.1+Double(n_heater_on)*1.8}
        else {temp=temp-3.2-Double(n_open)*1.2+Double(n_heater_on)*1.6+Double(hum_old)*0.016}
        if temp_old>15.0 {hum=hum-3.4*log10(abs(Double(n_open)-Double(n_heater_on))+1)/log10(2)}
        else {hum=hum+(Double(n_open)-Double(n_heater_on))*3.0}
    }
    func checkCondition(){
        if temp<(3.0+hum*0.11) || temp>50.0 || hum<6.8 || hum>80.7
        {
            switcher=false
            n_open=0
            n_heater_on=0
        }
    }
    
    func timePassModel(){
        if switcher == true {
            climateChange()
            checkCondition()
            infobox.text = "Windows total \(windows)" + "\n"
                + "Windows opened \(n_open)" + "\n"
                + "Heaters total \(heaters)" + "\n"
                + "Heaters on \(n_heater_on)" + "\n"
                + "Temperature \(temp)" + "\n"
                + "Humidity \(hum)"
            
        }
        else {infobox.text = "Emergency condition!"
            myImage.image = UIImage(named: "Burning.png")
        }
    }
    
    func greenhouseState() -> String {
        if switcher != false {state = "working"}
        else {state = "not working"}
        return state
    }
    
    @IBOutlet weak var infobox: UILabel!
    @IBOutlet weak var output: UILabel!
    @IBOutlet weak var inputPas: UITextField!
    @IBOutlet weak var myImage: UIImageView!
    
    let image1 = UIImage(named: "yourImage.png")
    
    @IBAction func start(_ sender: UIButton) {
        output.text = (inputPas.text)!
        if output.text == "" { infobox.text = "please, enter your password"}
        else if output.text != "angelina" { infobox.text = "your password is incorrect" }
        else if output.text == "angelina" {infobox.text = "YOU HAVE A FULL ACCESS"
            myImage.image = UIImage(named: "Normal.png")
        }
    }
    @IBAction func buttons(_ sender: UIButton) {
        output.text = (inputPas.text)!
        if output.text == "" { infobox.text = "please, enter your password"}
        else if output.text != "angelina" { infobox.text = "your password is incorrect" }
        else if output.text == "angelina" {
            if sender.tag == 1 //open window
            {
                openWind()
            }
            else if sender.tag == 2 //close window
            {
                closeWind()
            }
            else if sender.tag == 3 //heater on
            {
                heaterOn()
            }
            else if sender.tag == 4 //heater off
            {
                heaterOff()
            }
            else if sender.tag == 5 //time
            {
                infobox.text = "Greenhouse condition: " + greenhouseState() + "\n"
                    + "Windows total \(windows)" + "\n"
                    + "Windows opened \(n_open)" + "\n"
                    + "Heaters total \(heaters)" + "\n"
                    + "Heaters on \(n_heater_on)" + "\n"
                    + "Temperature \(temp)" + "\n"
                    + "Humidity \(hum)"
            }
            else if sender.tag == 6 //finish
            {
                timePassModel()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



 */



//
//  ViewController.swift
//  GreenHouse SWIFT
//
//  Created by Anhelina Lohvina on 25.05.2018.
//  Copyright © 2018 Anhelina Lohvina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var windows:Int = 4
    var n_open:Int = 0
    var heaters:Int = 1
    var n_heater_on:Int = 0
    var temp:Double = 19.6
    var hum:Double = 50.0
    var switcher:Bool = true
    var state:String = "yes"
    var condition:Bool = true
    
    func setGreenhouse() {
        windows=4
        n_open=0
        heaters=1
        n_heater_on=0
        temp=19.6
        hum=50.0
        switcher=true
    }
    func openWind() {
        if switcher == false {
            infobox.text = "Can't open because it's an emergency condition"
        }
        else {
            if n_open < windows
            {
                n_open=n_open+1
                infobox.text = "YOU HAVE OPENED A WINDOW" + "\n"
                    + "Windows total \(windows)" + "\n" + "Windows opened \(n_open)"
            }
            else {infobox.text = "ALL WINDOWS ARE OPENED"}
        }
    }
    
    func closeWind() {
        if n_open > 0 {
            n_open=n_open-1
            infobox.text = "YOU HAVE CLOSED A WINDOW" + "\n"
                + "Windows total \(windows)" + "\n" + "Windows opened \(n_open)"
        }
        else {infobox.text = "ALL WINDOWS ARE CLOSED"}
    }
    
    func heaterOn() {
        if switcher == false {
            infobox.text = "Can't turn on because it's an emergency condition"
        }
        else {
            if n_heater_on < heaters
            {
                n_heater_on=n_heater_on+1;
                infobox.text = "YOU HAVE TURNED ON A HEATER" + "\n"
                    + "Heaters total \(heaters)" + "\n" + "Heaters on \(n_heater_on)"
            }
            else {infobox.text = "ALL HEATERS ARE ON"}
        }
    }
    func heaterOff() {
        if n_heater_on > 0 {
            n_heater_on=n_heater_on-1
            infobox.text = "YOU HAVE TURNED OFF A HEATER" + "\n"
                + "Heaters total \(heaters)" + "\n" + "Heaters on \(n_heater_on)"
        }
        else {infobox.text = "ALL HEATERS ARE OFF"}
    }
    func climateChange(){
        let temp_old:Double = temp
        let hum_old:Double = hum
        if hum_old<65 { temp=temp-4.8-Double(n_open)*1.1+Double(n_heater_on)*1.8}
        else {temp=temp-3.2-Double(n_open)*1.2+Double(n_heater_on)*1.6+Double(hum_old)*0.016}
        if temp_old>15.0 {hum=hum-3.4*log10(abs(Double(n_open)-Double(n_heater_on))+1)/log10(2)}
        else {hum=hum+(Double(n_open)-Double(n_heater_on))*3.0}
    }
    func checkCondition(){
        if temp<(3.0+hum*0.11) || temp>50.0 || hum<6.8 || hum>80.7
        {
            switcher=false
            n_open=0
            n_heater_on=0
        }
    }
    
    func timePassModel(){
        if switcher == true {
            climateChange()
            checkCondition()
            infobox.text = "Windows total \(windows)" + "\n"
                + "Windows opened \(n_open)" + "\n"
                + "Heaters total \(heaters)" + "\n"
                + "Heaters on \(n_heater_on)" + "\n"
                + "Temperature \(temp)" + "\n"
                + "Humidity \(hum)"
            
        }
        else {infobox.text = "Emergency condition!"
            myImage.image = UIImage(named: "Burning.png")
        }
    }
    
    func greenhouseState() -> String {
        if switcher != false {state = "working"}
        else {state = "not working"}
        return state
    }
    
    @IBOutlet weak var infobox: UILabel!
    @IBOutlet weak var output: UILabel!
    @IBOutlet weak var inputPas: UITextField!
    @IBOutlet weak var myImage: UIImageView!
    
    let image1 = UIImage(named: "yourImage.png")
    
    @IBAction func start(_ sender: UIButton) {
        output.text = (inputPas.text)!
        if output.text == "" { infobox.text = "please, enter your password"}
        else if output.text != "angelina" { infobox.text = "your password is incorrect" }
        else if output.text == "angelina" {infobox.text = "YOU HAVE A FULL ACCESS"
            myImage.image = UIImage(named: "Normal.png")
        }
    }
    @IBAction func buttons(_ sender: UIButton) {
        output.text = (inputPas.text)!
        if output.text == "" { infobox.text = "please, enter your password"}
        else if output.text != "angelina" { infobox.text = "your password is incorrect" }
        else if output.text == "angelina" {
            if sender.tag == 1 //open window
            {
                openWind()
            }
            else if sender.tag == 2 //close window
            {
                closeWind()
            }
            else if sender.tag == 3 //heater on
            {
                heaterOn()
            }
            else if sender.tag == 4 //heater off
            {
                heaterOff()
            }
            else if sender.tag == 5 //time
            {
                infobox.text = "Greenhouse condition: " + greenhouseState() + "\n"
                    + "Windows total \(windows)" + "\n"
                    + "Windows opened \(n_open)" + "\n"
                    + "Heaters total \(heaters)" + "\n"
                    + "Heaters on \(n_heater_on)" + "\n"
                    + "Temperature \(temp)" + "\n"
                    + "Humidity \(hum)"
            }
            else if sender.tag == 6 //finish
            {
                timePassModel()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
