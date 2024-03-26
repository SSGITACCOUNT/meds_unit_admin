//
//  Contact.swift
//  PharmacyAdminApp
//
//  Created by Sashikala Sewwandi on 2024-01-19.
//

import UIKit

class ContactVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var messegeTxt: UITextField!
    
    let vm = ContactVM()
    var messages: [MessageFireData] = []
    var imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        tableview.estimatedRowHeight = 100
        tableview.rowHeight = UITableView.automaticDimension
        
        tableview.register(UINib(nibName: "SenderTVCell", bundle: nil), forCellReuseIdentifier: "SenderTVCell")
        tableview.register(UINib(nibName: "ReceiverTVCell", bundle: nil), forCellReuseIdentifier: "ReceiverTVCell")
        tableview.register(UINib(nibName: "SenderChatImageTVCell", bundle: nil), forCellReuseIdentifier: "SenderChatImageTVCell")
        tableview.register(UINib(nibName: "ReceiverChatImageTVCell", bundle: nil), forCellReuseIdentifier: "ReceiverChatImageTVCell")
        
        fetchChatMessages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func openCameraAction() {
        view.endEditing(true)
        var actionList: [String] = ["Take Photo", "Photos"]
        
        AlertManager.shared.multipleActionSheet(actions: actionList, isCancelEnable: true, vc: self) { [weak self] action in
            guard let _ = self else { return }
            switch action {
            case "Take Photo":
                self?.openCamera()
                break
            case "Photos":
                self?.openPhotos()
                break
            default:
                break
            }
        }
    }
    
    private func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePickerController.sourceType = UIImagePickerController.SourceType.camera
            imagePickerController.allowsEditing = true
            self.present(imagePickerController, animated: true, completion: nil)
        } else {
            AlertManager.shared.singleActionMessage(title: NSLocalizedString("WARNING", comment: "Warning"), message: NSLocalizedString("YOU_DONT_HAVE_CAMERA", comment: "You don't have camera"), action: NSLocalizedString("OK", comment: "Ok"), vc: self)
        }
    }
    
    private func openPhotos() {
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func didSelect(image: UIImage?) {
        guard let model = vm.orderModel else { return }
        if let data = image?.jpegData(compressionQuality: 0.4) {
            let fileExt = (data as NSData).imageFormat
            CloudStorageHelper.shared.uploadFile(data: data, fileExt: fileExt.rawValue) { [weak self] uploadedFileUrl  in
                guard let _ = self else { return }
                FirestoreHelper.shared.sendMessage(contentType: .image, orderId: model.orderId ?? "", uploadedFileUrl, customerName: model.name ?? "", customerId: model.phoneNumber ?? "", customerImage: model.imageUrl ?? "")
            }
        }
    }
    
    func sendMessageAction() {
        guard let _message = messegeTxt.text, let model = vm.orderModel else { return }
        let trimmedMessage = _message.trimmingCharacters(in: .whitespacesAndNewlines)
        if  trimmedMessage == "" || trimmedMessage.isEmpty { return }
        
        FirestoreHelper.shared.sendMessage(contentType: .message, orderId: model.orderId ?? "", _message, customerName: model.name ?? "", customerId: model.phoneNumber ?? "", customerImage: model.imageUrl ?? "")
        messegeTxt.text = ""
    }
    
    func fetchChatMessages(){
        guard let _orderNo =  vm.orderModel?.orderId else { return }
        FirestoreHelper.shared.getOrderChatData(orderNo: _orderNo, CustomerId: vm.orderModel?.customerId ?? "", customerName: vm.orderModel?.name ?? "", customerImage: "") { [weak self] messageData, isClosed in
            guard let _ = self else { return }
            self?.messages = messageData
            self?.tableview.reloadData()
        }
    }
        
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func openCameraAction(_ sender: Any) {
        openCameraAction()
    }
        
    @IBAction func messageSendAction(_ sender: Any) {
        sendMessageAction()
    }
    
}

extension ContactVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = messages[indexPath.row]
        if model.sender?.phoneNumber == Constants.shared.currentLoggedInFireStoreUser?.phone {
            if model.contentType == ContentType.message.rawValue {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SenderTVCell", for: indexPath)
                if let _cell = cell as? SenderTVCell {
                    _cell.configCell(model: model)
                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SenderChatImageTVCell", for: indexPath)
                if let _cell = cell as? SenderChatImageTVCell {
                    _cell.configCell(model: model)
                }
                return cell
            }
        } else {
            if model.contentType == ContentType.message.rawValue {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiverTVCell", for: indexPath)
                if let _cell = cell as? ReceiverTVCell {
                    _cell.configCell(model: model)
                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiverChatImageTVCell", for: indexPath)
                if let _cell = cell as? ReceiverChatImageTVCell {
                    _cell.configCell(model: model)
                }
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension ContactVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let photo = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        didSelect(image: photo)
        self.dismiss(animated: true, completion: nil)
    }
}
