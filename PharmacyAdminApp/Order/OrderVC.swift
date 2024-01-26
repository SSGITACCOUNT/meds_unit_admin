//
//  OrderVC.swift
//  PharmacyAdminApp
//
//  Created by Sashikala Sewwandi on 2024-01-19.
//

import UIKit

class OrderVC: UIViewController {

    @IBOutlet weak var ongoingBtn: RoundedButton!
    @IBOutlet weak var completeBtn: RoundedButton!
    @IBOutlet weak var buttonView: UIView!
    
    var containerController: SwiftyPageController!
    var isViewPastOrders = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI ()
    }
    
    func updateUI() {
        if !isViewPastOrders {
            manageTabSelection(tabIndex: 0)
            containerController.selectController(atIndex: 0, animated: true)
        } else {
            manageTabSelection(tabIndex: 1)
            containerController.selectController(atIndex: 1, animated: true)
        }
        
        buttonView.layer.cornerRadius = 25
    }
    
    func manageTabSelection(tabIndex: Int) {
        if(tabIndex == 0){
            ongoingBtn.setTitleColor(UIColor.systemGray5, for: .normal)
            ongoingBtn.backgroundColor = UIColor(named: "theme_color")
            completeBtn.setTitleColor(UIColor(named: "theme_color"), for: .normal)
            completeBtn.backgroundColor = UIColor.systemGray5
        } else {
            completeBtn.setTitleColor(UIColor.systemGray5, for: .normal)
            completeBtn.backgroundColor = UIColor(named: "theme_color")
            ongoingBtn.setTitleColor(UIColor(named: "theme_color"), for: .normal)
            ongoingBtn.backgroundColor = UIColor.systemGray5
        }
    }
    
    func setupContainerController(_ controller: SwiftyPageController) {
        // assign variable
        containerController = controller
        
        // set delegate
        containerController.delegate = self
        
        // set animation type
        containerController.animator = .parallax
        
        // set view controllers
        let firstController = OngoingOrderVC.storyboardInstantiate(appStoryboard: .Order, identifier: "OngoingOrderVC")
        let secondController = PastOrderVC.storyboardInstantiate(appStoryboard: .Order, identifier: "PastOrderVC")
        
        containerController.viewControllers = [firstController, secondController]
        
        // select needed controller
        containerController.selectController(atIndex: 0, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let containerController = segue.destination as? SwiftyPageController {
            setupContainerController(containerController)
        }
    }
    
    @IBAction func ongoingAction(_ sender: Any) {
        manageTabSelection(tabIndex: 0)
        containerController.selectController(atIndex: 0, animated: true)
    }
    
    @IBAction func completeAction(_ sender: Any) {
        manageTabSelection(tabIndex: 1)
        containerController.selectController(atIndex: 1, animated: true)
    }
}

extension OrderVC: SwiftyPageControllerDelegate{
    
    func swiftyPageController(_ controller: SwiftyPageController, willMoveToController toController: UIViewController){
    }
    
    func swiftyPageController(_ controller: SwiftyPageController, didMoveToController toController: UIViewController) {
        let index  = containerController.viewControllers.firstIndex(of: toController)!
        manageTabSelection(tabIndex: index)
    }
    
    func swiftyPageController(_ controller: SwiftyPageController, alongSideTransitionToController toController: UIViewController) {
    }
}
