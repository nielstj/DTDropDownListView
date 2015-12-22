//
//  ViewController.swift
//  DTDropDownListView
//
//  Created by Daniel Tjuatja on 12/22/2015.
//  Copyright (c) 2015 Daniel Tjuatja. All rights reserved.
//

import UIKit
import DTDropDownListView


class ViewController: UIViewController, DTDropDownListViewDelegate {

    @IBOutlet weak var dropDownBtn : UIButton!
    @IBOutlet weak var dropUpBtn : UIButton!
    
    
    var dropDownMenu : DTDropDownListView?
    var dropUpMenu : DTDropDownListView?
    
    let list = ["12345","67890","abcdef","!@#$%^","^&*()","{}|~!@","<>?:","!@#$%^&*()"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func dropBtnTapped(sender : UIButton) {
        if sender == dropDownBtn {
            setupDropDownMenu()
        }
        else if sender == dropUpBtn {
            setupDrowUpMenu()
        }
        
    }
    

    private func setupDropDownMenu() {
        
        if dropDownMenu == nil {
            dropDownMenu = DTDropDownListView(sender: dropDownBtn, parent : dropDownBtn.superview ,height:200 , list: list, direction: "down")
            dropDownMenu?.delegate = self
        }
        else {
            dropDownMenu!.hideDropDown(dropDownBtn)
            dropDownMenu = nil
        }
    }
    
    
    private func setupDrowUpMenu() {
        if dropUpMenu == nil {
            dropUpMenu = DTDropDownListView(sender: dropUpBtn, parent : dropUpBtn.superview ,height:200 , list: list, direction: "up")
            dropUpMenu?.delegate = self
            tableView.userInteractionEnabled = false
        }
        else {
            dropUpMenu!.hideDropDown(dropDownBtn)
            dropUpMenu = nil
        }
    }
    

}

