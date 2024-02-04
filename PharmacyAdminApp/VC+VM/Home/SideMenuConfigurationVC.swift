//
//  SideMenuConfigurationVC.swift
//  PharmacyAdminApp
//
//  Created by Sashikala Sewwandi on 2024-01-18.
//

import UIKit

class SideMenuConfigurationVC: SideMenuController {

    required init?(coder aDecoder: NSCoder) {
        SideMenuController.preferences.drawing.menuButtonImage = UIImage(named: "Group 9 (3)")
        SideMenuController.preferences.drawing.sidePanelPosition = .overCenterPanelLeft
        SideMenuController.preferences.drawing.sidePanelWidth = (UIScreen.main.bounds.width - 100)
        SideMenuController.preferences.drawing.centerPanelShadow = true
        SideMenuController.preferences.animating.statusBarBehaviour = .horizontalPan
        SideMenuController.preferences.animating.transitionAnimator = FadeAnimator.self
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        performSegue(withIdentifier: "SideMenu.Menu", sender: nil)
        performSegue(withIdentifier: "Home.Menu", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nc = segue.destination as? UINavigationController else { return }
        
    }

}
