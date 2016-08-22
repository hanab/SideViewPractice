//
//  SideBar.swift
//  SideViewPractice
//
//  Created by Hana  Demas on 20/08/16.
//  Copyright © 2016 ___HANADEMAS___. All rights reserved.
//

import UIKit
 @objc protocol SideBarDelegate {
    
    func sideBarDidSelectRowCellAtIndex(index:Int)
    optional func sideBarWillClose()
    optional func sideBarWillOpen()
}

class SideBar: NSObject,SideBarTableViewDelegate {
    
    // MARK: Properties
    let barWidth:CGFloat = 150.0
    let sideBarTableViewTopInset:CGFloat = 64.0
    let sideBarContainerView:UIView = UIView()
    let sideBarTableViewController:SideBarTableViewController = SideBarTableViewController()
    var originView:UIView = UIView()
    var animator:UIDynamicAnimator = UIDynamicAnimator()
    var delegate:SideBarDelegate?
    var isSideBarOpen:Bool = false
    
    //MARK : Init
    override init() {
        super.init()
    }
    
    init(sourceView:UIView, menuItems:Array<String>) {
        super.init()
        
        originView = sourceView
        sideBarTableViewController.tableData = menuItems
        setUpSideBar()
        animator = UIDynamicAnimator(referenceView: originView)
        
        let showGestureRegongnizer:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(SideBar.handleSwipe(_:)))
        showGestureRegongnizer.direction = UISwipeGestureRecognizerDirection.Right
        originView.addGestureRecognizer(showGestureRegongnizer)
        let hideGestureRegognizer:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(SideBar.handleSwipe(_:)))
        hideGestureRegognizer.direction = UISwipeGestureRecognizerDirection.Left
        originView.addGestureRecognizer(hideGestureRegognizer)
    }
    
    //MARK: custom methods
    func setUpSideBar(){
        sideBarContainerView.frame = CGRectMake(-barWidth - 1, originView.frame.origin.y, barWidth, originView.frame.size.height)
        sideBarContainerView.backgroundColor = UIColor.clearColor()
        sideBarContainerView.clipsToBounds = false
        originView.addSubview(sideBarContainerView)
        let blureView:UIVisualEffectView = UIVisualEffectView(effect:UIBlurEffect(style: UIBlurEffectStyle.Light))
        blureView.frame = sideBarContainerView.bounds
        sideBarContainerView.addSubview(blureView)
        sideBarTableViewController.delegate = self
        sideBarTableViewController.tableView.frame = sideBarContainerView.bounds
        sideBarTableViewController.tableView.clipsToBounds = false
        sideBarTableViewController.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        sideBarTableViewController.tableView.backgroundColor = UIColor.clearColor()
        sideBarTableViewController.tableView.scrollsToTop = false
        sideBarTableViewController.tableView.contentInset = UIEdgeInsetsMake(sideBarTableViewTopInset, 0, 0,0)
        sideBarTableViewController.tableView.reloadData()
        sideBarContainerView.addSubview(sideBarTableViewController.tableView)
    }
    
    func handleSwipe(regognizer:UISwipeGestureRecognizer) {
        if(regognizer.direction == UISwipeGestureRecognizerDirection.Left) {
            showSideBar(false)
            delegate?.sideBarWillClose?()
        } else {
            showSideBar(true)
            delegate?.sideBarWillOpen?()
        }
    }
    
    func showSideBar(shouldOpen:Bool) {
        animator.removeAllBehaviors()
        isSideBarOpen = shouldOpen
        let gravityX:CGFloat = (shouldOpen) ? 0.5 : -0.5
        let magnitude:CGFloat = (shouldOpen) ? 20 : 20
        let boundryX:CGFloat  = (shouldOpen) ? barWidth : -barWidth-1
        
        let gravityBehaviour:UIGravityBehavior = UIGravityBehavior(items: [sideBarContainerView])
        gravityBehaviour.gravityDirection = CGVectorMake(gravityX, 0)
        animator.addBehavior(gravityBehaviour)
        
        let collisionBehaviour:UICollisionBehavior = UICollisionBehavior(items: [sideBarContainerView])
        collisionBehaviour.addBoundaryWithIdentifier("sideBarBoundry", fromPoint: CGPointMake(boundryX, 20), toPoint: CGPointMake(boundryX, originView.frame.size.height))
        animator.addBehavior(collisionBehaviour)
        
        let pushBehaviour:UIPushBehavior = UIPushBehavior(items: [sideBarContainerView], mode: UIPushBehaviorMode.Instantaneous)
        pushBehaviour.magnitude = magnitude
        animator.addBehavior(pushBehaviour)
        
        let sideBarBehavior:UIDynamicItemBehavior = UIDynamicItemBehavior(items: [sideBarContainerView])
        sideBarBehavior.elasticity = 0.3
        animator.addBehavior(sideBarBehavior)
    }
    
    //MARK: SideBarDelegate delegate methods
    func SidebarControllerDidSelsectRowAtIndex(indexPath:NSIndexPath){
        delegate?.sideBarDidSelectRowCellAtIndex(indexPath.row)
    }
}
    
    

    


