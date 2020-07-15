//
//  ContactDetailsTableViewController.swift
//  Contact Listing
//
//  Created by Sherynn Tam on 15/07/2020.
//  Copyright © 2020 Sherynn Tam. All rights reserved.
//

import UIKit

class ContactDetailsTableViewController: UITableViewController {
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var firstNameTextField: CustomTextField!
    @IBOutlet weak var lastNameTextField: CustomTextField!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var phoneTextField: CustomTextField!
    
    @IBOutlet weak var image: UIImageView!
    
    var viewModel: ContactDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(backButtonTapped(sender:)))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(rgb: 0xFF8C00)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonTapped(sender:)))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(rgb: 0xFF8C00)
        
        self.image.layer.cornerRadius = self.image.frame.height / 2
        
        if let contact = viewModel?.contact {
            self.firstNameTextField.text = contact.firstName
            self.lastNameTextField.text = contact.lastName
            self.emailTextField.text = contact.email
            self.phoneTextField.text = contact.phone
        }
        
        viewModel?.contactUpdated = {
            self.popViewController()
        }
    }
    
    @objc func backButtonTapped(sender: UIBarButtonItem) {
        popViewController()
    }
    
    @objc func saveButtonTapped(sender: UIBarButtonItem) {
        if firstNameTextField.text!.isEmpty {
            showAlert("First Name is required")
            return
        }

        if lastNameTextField.text!.isEmpty {
            showAlert("Last Name is required")
            return
        }

        let contactId = viewModel!.isEdit ? viewModel?.contact?.id : randomString()
        let contact: Contact = Contact(id: contactId!, firstName: self.firstNameTextField.text!, lastName: self.lastNameTextField.text!, email: self.emailTextField.text, phone: self.phoneTextField.text)
        
        viewModel!.updateContact(contact: contact)
        
    }
    
    private func popViewController() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func randomString() -> String {
      let letters = "abcdefghijklmnopqrstuvwxyz0123456789"
      return String((0..<24).map{ _ in letters.randomElement()! })
    }
}

extension ContactDetailsTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.firstNameTextField:
            self.lastNameTextField.becomeFirstResponder()
        case self.lastNameTextField:
            self.emailTextField.becomeFirstResponder()
        case self.emailTextField:
            self.phoneTextField.becomeFirstResponder()
        default:
            self.phoneTextField.resignFirstResponder()
        }
    }
}
