//
//  ForecastViewController.swift
//  Weather
//
//  Created by HarveyHu on 4/08/19.
//  Copyright © 2019 Harvey. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

class ForecastViewController: UIViewController, UISetting, UITableViewDelegate {
    private let disposeBag = DisposeBag()
    private let viewModel = ForecastViewModel(permanentData: PermanentData(), locationHelper: LocationHelper(), netManager: NetManager())
    private let tableView = UITableView()
    private var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, List>>?
    var selectedCity: LocalCity?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUI()
        self.setUIEvents()
        self.setUIConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let cityId = self.selectedCity?.id {
            self.viewModel.updateForecast(cityId: cityId)
        }
    }

    func setUI() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.tableView)
        if let cityName = self.selectedCity?.name {
            self.navigationItem.title = "\(cityName): 5 Day Weather Forecast"
        } else {
            self.navigationItem.title = "5 Day Weather Forecast"
        }
        
        // set dataSource
        self.dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, List>>(configureCell: { (dateSource, tableView, indexPath, list) -> UITableViewCell in
            var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
            if cell == nil {
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
            }
            
            if let description = list.weather?[0].descriptionField, let dt = list.dtTxt, let temp = list.main?.temp {
                
                cell!.textLabel?.text = "\(dt)"
                cell!.detailTextLabel?.text = "Weather: \(description)   Temp: \(String(format: "%.2f", self.viewModel.getLocalizedTemp(temp: temp))) \(self.viewModel.getLocalizedTempUnit().rawValue)"
            }
            
            return cell!
        })
    }
    
    func setUIConstraints() {
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setUIEvents() {
        // tableView
        self.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
        
        self.viewModel.items
            .bind(to: tableView.rx.items(dataSource: dataSource!))
            .disposed(by: disposeBag)
    }

}
