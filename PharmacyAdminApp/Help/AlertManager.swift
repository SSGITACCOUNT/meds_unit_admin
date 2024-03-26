//
//  AlertManager.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-01-27.
//
import Foundation
import UIKit

class AlertManager {
    static let shared: AlertManager = {
        let _shared = AlertManager()
        return _shared
    }()

    func singleActionMessage(title: String, message: String, action: String, vc: UIViewController) {
        ApplicationServiceProvider.shared.checkAndDismissAlert()
        let alert = UIAlertController(title: title, message: message , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: action, style: UIAlertAction.Style.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
    func multipleActionMessage(title: String, message: String, actionButtonTitles: [String], vc: UIViewController, completion: @escaping AlertActionHandler) {
        let alert = UIAlertController(title: title, message: message , preferredStyle: UIAlertController.Style.alert)
        for action in actionButtonTitles {
            alert.addAction(UIAlertAction(title: action, style: UIAlertAction.Style.default, handler: { (_action) in
                completion(_action.title ?? "")
            }))
        }
        vc.present(alert, animated: true, completion: nil)
    }
    
    func singleActionMessage(title: String, message: String, actionButtonTitle: String, vc: UIViewController,completion: @escaping AlertActionHandler) {
        let alert = UIAlertController(title: title, message: message , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: actionButtonTitle, style: UIAlertAction.Style.default, handler: { (_action) in
            completion(_action.title ?? "")
        }))
        vc.present(alert, animated: true, completion: nil)
    }
    
    func multipleActionSheet(title: String? = nil, message: String? = nil, actions: [String], isCancelEnable: Bool = false, vc: UIViewController, completion: @escaping AlertActionHandler) {
        ApplicationServiceProvider.shared.checkAndDismissAlert()
        let alert = UIAlertController(title: title, message: message , preferredStyle: UIAlertController.Style.actionSheet)
        for action in actions {
            alert.addAction(UIAlertAction(title: action, style: UIAlertAction.Style.default, handler: { (_action) in
                completion(_action.title ?? "")
            }))
        }
        if isCancelEnable == true {
            alert.addAction(UIAlertAction(title: NSLocalizedString("CANCEL", comment: "Cancel"), style: .cancel, handler: nil))
        }
        vc.present(alert, animated: true, completion: nil)
    }
}
