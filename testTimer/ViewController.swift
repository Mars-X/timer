//
//  ViewController.swift
//  testTimer
//
//  Created by lixun on 2017/3/19.
//  Copyright © 2017年 lixun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Btn_reset: UIButton!

    @IBOutlet weak var Btn_load: UIButton!
    @IBOutlet weak var Btn_save: UIButton!
    @IBOutlet weak var Btn_Show: UIButton!
    @IBOutlet weak var Label_Show: UILabel!
    var Int_Second = 0
    var Int_Minutes = 0
    var Int_Huor = 0
    var timer:Timer? = nil
    
    let fileManager = FileManager.default
    
    let Str_FileSave_homeDirectWithDocuments:String? = "\(NSHomeDirectory())/Documents/"
    let Str_FileSave_fileName:String? = "save"
    let Str_FileSave_suffix:String? = ".txt"
    var Str_FileSave_fullDirect:String? = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        print(Str_FileSave_homeDirectWithDocuments!)
        Str_FileSave_fullDirect = "\(Str_FileSave_homeDirectWithDocuments!)\(Str_FileSave_fileName!)\(Str_FileSave_suffix!)"
        print(Str_FileSave_fullDirect!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func Btn_Action_StartTimer(_ sender: Any) {
                    Btn_save.isEnabled = true
        if timer == nil {
            Btn_reset.isHidden = false
            Btn_Show.setTitle("暂停", for: .normal)
                     timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.testTick), userInfo: nil, repeats: true)
        }else{
            Btn_Show.setTitle("继续", for: .normal)
            timer?.invalidate()
            timer = nil
        }
    }
    
    func testTick()
    {
        if(Int_Second <= 58)
        {self.Int_Second = self.Int_Second + 1}
        else
        {
            if(self.Int_Minutes <= 58)
            {self.Int_Minutes = self.Int_Minutes + 1}
            else
            {
                self.Int_Huor = self.Int_Huor + 1
                self.Int_Minutes = 0
            }
            self.Int_Second = 0
        }
        
        var Str_Second = ""
        var Str_Minutes = ""
        var Str_Hour = ""
        if Int_Second < 10 {
            Str_Second = "0\(self.Int_Second)"
        }else
        {Str_Second = "\(self.Int_Second)"}
        if Int_Minutes < 10 {
            Str_Minutes = "0\(self.Int_Minutes)"
        }else{Str_Minutes = "\(self.Int_Minutes)"}
        if Int_Huor < 10 {
            Str_Hour = "0\(self.Int_Huor)"
        }else{Str_Hour = "\(self.Int_Huor)"}
        self.Label_Show.text = "\(Str_Hour):\(Str_Minutes):\(Str_Second)"
        
    }

    @IBAction func Btn_Action_reset(_ sender: Any) {
        timer?.invalidate()
        timer = nil
        
        Int_Huor = 0
        Int_Minutes = 0
        Int_Second = 0
        self.Label_Show.text = "00:00:00"
        Btn_reset.isHidden = true
        Btn_Show.setTitle("任务开始", for: .normal)
        Btn_save.isEnabled = false
    }
    
    @IBAction func Btn_Action_SAVE(_ sender: Any) {
        let Str_FileSave_filecontent = self.Label_Show.text
        do{
        try! Str_FileSave_filecontent?.write(toFile: Str_FileSave_fullDirect!, atomically: true, encoding: .utf8)
        }catch{}
    }
    
    @IBAction func Btn_Action_LOAD(_ sender: Any) {
    }
}

