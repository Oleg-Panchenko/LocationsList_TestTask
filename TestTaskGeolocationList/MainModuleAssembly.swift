//
//  MainModuleAssembly.swift
//  TestTaskGeolocationList
//
//  Created by Panchenko Oleg on 30.03.2023.
//

import UIKit

final class MainModuleAssembly {
    
    class func configureModule() -> UIViewController {
        
        let mainTableVC = MainTableViewController()
        let dataManager = DataManager()
        let viewModel = MainViewModel()
     
        viewModel.dataManager = dataManager
        mainTableVC.viewModel = viewModel
        
        return mainTableVC
    }
}
