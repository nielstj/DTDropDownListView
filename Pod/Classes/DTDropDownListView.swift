//
//  DTDropDownListView.swift
//  FindMe
//
//  Created by Daniel Tjuatja on 22/12/15.
//  Copyright © 2015 Russell Ong. All rights reserved.
//

import Foundation
import UIKit

@objc protocol DTDropDownListViewDelegate {
    optional func DropDownDidSelect(sender : DTDropDownListView, value : AnyObject)
}

class DTDropDownListView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    
    var delegate : DTDropDownListViewDelegate?
    
    let kDropDownCellID = "DropDownCell"
    
    var tableView : UITableView!
    var listArr = [String]()
    var animationDir = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    init(sender : UIButton, parent : UIView, height : CGFloat, list : [String], direction : String) {
        super.init(frame: CGRectMake(0, 0, 0, 0))
        
        let btn = sender.frame
        listArr = list
        animationDir = direction
        
        if direction == "up" {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y, btn.size.width, 0)
            self.layer.shadowOffset = CGSizeMake(-5, -5)
        }
        else if direction == "down" {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y + btn.size.height, btn.size.width, 0)
            self.layer.shadowOffset = CGSizeMake(5,5)
        }
        
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 8
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
        
        tableView = UITableView(frame: CGRectMake(0, 0, btn.size.width, 0))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 5
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        
        UIView.animateWithDuration(
            0.5, animations: { () -> Void in
                
                if direction == "up" {
                    self.frame = CGRectMake(btn.origin.x, btn.origin.y - height, btn.size.width, height)
                }
                else if direction == "down" {
                    self.frame = CGRectMake(btn.origin.x, btn.origin.y + btn.size.height, btn.size.width, height)
                }
                self.tableView.frame = CGRectMake(0, 0, btn.size.width, height)
                
            }) { (completion) -> Void in
                
        }
        
        sender.superview?.superview?.addSubview(self)
        sender.superview?.superview?.bringSubviewToFront(self)
        self.addSubview(tableView)
    }
    
    func hideDropDown(sender : UIButton) {
        let btn = sender.frame
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            if self.animationDir == "up" {
                self.frame = CGRectMake(btn.origin.x, btn.origin.y, btn.size.width, 0)
            }
            else  if self.animationDir == "down" {
                self.frame = CGRectMake(btn.origin.x, btn.origin.y + btn.size.height, btn.size.width, 0)
            }
            self.tableView.frame = CGRectMake(0, 0, btn.size.width, 0)
            
            }) { (completion) -> Void in
                self.removeFromSuperview()
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(kDropDownCellID)
        if(cell == nil) {
            cell = UITableViewCell(style: .Default, reuseIdentifier: kDropDownCellID)
        }
        cell?.textLabel?.text = listArr[indexPath.row]
        cell?.textLabel?.textAlignment = .Center
        return cell!
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if delegate != nil {
            delegate?.DropDownDidSelect!(self, value: listArr[indexPath.row])
        }
    }
    
    
    
    
    
    
    
    
}
