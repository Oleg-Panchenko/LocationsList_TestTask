//
//  MainTableViewController.swift
//  TestTaskGeolocationList
//
//  Created by Panchenko Oleg on 28.03.2023.
//

import CoreLocation
import UIKit

final class MainTableViewController: UITableViewController {
    
    var viewModel: MainViewModelProtocol!
    
    private var users: [User]?
    private var selectedUser: User? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private var timer: Timer?
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView.register(GeolocationUserCell.self, forCellReuseIdentifier: GeolocationUserCell.reuseId)
        tableView.register(HeaderTableViewCell.self, forHeaderFooterViewReuseIdentifier: HeaderTableViewCell.reuseId)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        viewModel.locationManager = CLLocationManager()
        viewModel.locationManager?.delegate = self
        viewModel.locationManager?.requestWhenInUseAuthorization()
        
        updateUsers()
        viewModel.startUpdatingLocations()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.updateLocationsInThreeSeconds()
    }
    
    private func updateUsers() {
        let _: () = viewModel.users = { user, users in
            self.selectedUser = user
            self.users = users
        }
    }
    
    private func updateLocationsInThreeSeconds() {
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: { [weak self] _ in
            self?.viewModel.startUpdatingLocations()
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }
    
    @objc func uncheck() {
        viewModel.uncheckUser()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MainTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GeolocationUserCell.reuseId) as? GeolocationUserCell else {
            return UITableViewCell()
        }
        guard let user = users?[indexPath.row] else { return UITableViewCell() }
        cell.configure(user: user)
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        timer?.invalidate()
        viewModel.selectedRow = indexPath.row

        self.updateUsers()
        updateLocationsInThreeSeconds()
    }
}

// MARK: - Header
extension MainTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return selectedUser != nil ? 80 : 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderTableViewCell.reuseId) as? HeaderTableViewCell else {
            return nil
        }
        header.configure(user: selectedUser)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(uncheck))
        
        header.addGestureRecognizer(tapRecognizer)
        return selectedUser != nil ? header : nil
    }
}

// MARK: - CLLocationManagerDelegate
extension MainTableViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.tableView.reloadData()
    }
}
