//
//  ContactsViewController.swift
//  Contact Listing
//
//  Created by Sherynn Tam on 13/07/2020.
//  Copyright © 2020 Sherynn Tam. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {

    var viewModel: ContactViewModel!
    var refreshControl = UIRefreshControl()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(addButtonTapped(sender:)))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(rgb: 0xFF8C00)

        tableView.delegate = self
        tableView.dataSource = self
        
        initViewModel()
        initRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        viewModel.initFetch()
    }
    
    private func initViewModel() {
        viewModel = ContactViewModel()

        viewModel.reloadTableView = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }

        viewModel.showAlertClosure = { [weak self] in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert(message)
                }
            }
        }
    }
    
    private func initRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.initFetch()
    }
    
    @objc func addButtonTapped(sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" ,
            let nextScene = segue.destination as? ContactDetailsTableViewController {
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let selectedContact = viewModel.contacts[indexPath.row]
                nextScene.viewModel = ContactDetailsViewModel(contact: selectedContact, index: indexPath.row)
            }
            else {
                nextScene.viewModel = ContactDetailsViewModel(contact: nil, index: -1)
            }
        }
    }
}

// MARK: - UITableView Data Source
extension ContactsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactTableViewCell
        let contact = viewModel.contacts[indexPath.row]
        
        cell.nameLabel.text = "\(contact.firstName) \(contact.lastName)"
        
        return cell
    }
}

// MARK: - UITableView Delegate
extension ContactsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        self.performSegue(withIdentifier: "showDetails", sender: self)
    }
}
