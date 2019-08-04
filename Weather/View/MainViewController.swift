//
//  MainViewController.swift
//  Weather
//
//  Created by HarveyHu on 30/07/19.
//  Copyright © 2019 Harvey. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

class MainViewController: UIViewController, UISetting, UITableViewDelegate {
    private let disposeBag = DisposeBag()
    private let viewModel = MainViewModel(permanentData: PermanentData(), locationHelper: LocationHelper(), netManager: NetManager())
    private let infoView = UIView()
    private let temperatureUnitLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let mixTemperatureLabel = UILabel()
    private let maxTemperatureLabel = UILabel()
    private let weatherImageView = UIImageView()
    private let windDirectionLabel = UILabel()
    private let windSpeedLabel = UILabel()
    private let cityNameLabel = UILabel()
    private let tableView = UITableView()
    private var previousIndex: IndexPath?
    
    private var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, LocalCity>>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.reloadAllCities()
        
        self.setUI()
        self.setUIEvents()
        self.setUIConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel.reloadFavoriteCities()
        self.viewModel.updateCurrentWeatherByLocation()
    }
    
    // update the main information on the top of the screen
    func updateInfoView(currentWeather: CurrentWeather) {
        // left column
        if let city = currentWeather.name {
            self.cityNameLabel.text = "City: \(city)"
        }
        if let icon = currentWeather.weather?.first?.icon {
            self.viewModel.updateWeatherIcon(imageName: icon)
        }
        self.temperatureUnitLabel.text = "Localizd Unit:\(self.viewModel.getLocalizedTempUnit().rawValue)"
        
        // right column
        if let temp = currentWeather.main?.temp {
            let localizedTemp = self.viewModel.getLocalizedTemp(temp: temp)
            self.temperatureLabel.text = "Temp: \(String(format: "%.2f", localizedTemp))"
        }
        if let tempMix = currentWeather.main?.tempMin {
            let localizedTemp = self.viewModel.getLocalizedTemp(temp: tempMix)
            self.mixTemperatureLabel.text = "Mix Temp: \(String(format: "%.2f", localizedTemp))"
        }
        if let tempMax = currentWeather.main?.tempMax {
            let localizedTemp = self.viewModel.getLocalizedTemp(temp: tempMax)
            self.maxTemperatureLabel.text = "Max Temp: \(String(format: "%.2f", localizedTemp))"
        }
        if let windDegree = currentWeather.wind?.deg {
            if let direction = self.viewModel.getWindDirection(degree: windDegree) {
                self.windDirectionLabel.text = "Wind Direction: \(direction)"
            } else {
                self.windDirectionLabel.text = "Wind Direction: n/a)"
            }
        }
        if let windSpeed = currentWeather.wind?.speed {
            self.windSpeedLabel.text = "Wind Speed: \(windSpeed)"
        } else {
            self.windSpeedLabel.text = "Wind Speed: n/a)"
        }
    }

    func cellSelected(selectedIndex: IndexPath?) {
        print("cell selected")
        // if you tap on the same cell, then ignore it.
        if selectedIndex == self.previousIndex {
            return
        }
        self.previousIndex = selectedIndex
        
        if let index = selectedIndex {
            do {
                if let city = try self.dataSource?.model(at: index) as? LocalCity {
                    self.viewModel.updateCurrentWeather(cityId: city.id)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func cellInfoButtonTapped(selectedIndex: IndexPath?) {
        
        if let index = selectedIndex {
            do {
                if let city = try self.dataSource?.model(at: index) as? LocalCity {
                    let forecastVC = ForecastViewController()
                    forecastVC.selectedCity = city
                    self.navigationController?.pushViewController(forecastVC, animated: true)
                }
            } catch {
                print(error)
            }
        }
    }
    
    @objc func addButtonTapped(sender: UIBarButtonItem) {
        print("addButtonTapped")
        let alert = UIAlertController(title: "Add favorite city?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input country name here..."
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {[weak self] action in
            
            if let name = alert.textFields?.first?.text {
                print("Your name: \(name)")
                self?.viewModel.addCityToFavorite(cityName: name)
            }
        }))
        
        self.present(alert, animated: true)
    }
    
    
    func setUI() {
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "Current Weather"
        self.view.addSubview(self.infoView)
        self.view.addSubview(self.tableView)
        
        self.infoView.addSubview(temperatureUnitLabel)
        self.infoView.addSubview(temperatureLabel)
        self.infoView.addSubview(mixTemperatureLabel)
        self.infoView.addSubview(maxTemperatureLabel)
        self.infoView.addSubview(weatherImageView)
        self.infoView.addSubview(windDirectionLabel)
        self.infoView.addSubview(windSpeedLabel)
        self.infoView.addSubview(cityNameLabel)
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped(sender:)))
        
        self.navigationItem.rightBarButtonItem = addButton
        
        // set dataSource
        self.dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, LocalCity>>(configureCell: { (dateSource, tableView, indexPath, city) -> UITableViewCell in
            var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            }
            
            cell!.textLabel?.text = "\(city.name)"
            cell?.accessoryType = .detailDisclosureButton
            
            return cell!
        })
    }
    
    func setUIConstraints() {
        self.infoView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(500.0)
        }
        
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.infoView.snp_bottomMargin)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        self.cityNameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(10)
            make.width.greaterThanOrEqualTo(100)
            make.height.equalTo(20)
        }
        
        self.temperatureUnitLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.cityNameLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.width.greaterThanOrEqualTo(100)
            make.height.equalTo(20)
        }
        
        self.weatherImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.temperatureUnitLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        self.temperatureLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(200)
            make.width.greaterThanOrEqualTo(100)
            make.height.equalTo(20)
        }
        
        self.mixTemperatureLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.temperatureLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(200)
            make.width.greaterThanOrEqualTo(100)
            make.height.equalTo(20)
        }
        
        self.maxTemperatureLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.mixTemperatureLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(200)
            make.width.greaterThanOrEqualTo(300)
            make.height.equalTo(20)
        }
        
        self.windDirectionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.maxTemperatureLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(200)
            make.width.greaterThanOrEqualTo(300)
            make.height.equalTo(20)
        }
        
        self.windSpeedLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.windDirectionLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(200)
            make.width.greaterThanOrEqualTo(300)
            make.height.equalTo(20)
        }
    }
    
    func setUIEvents() {
        // tableView
        self.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
        
        self.viewModel.items
            .bind(to: tableView.rx.items(dataSource: dataSource!))
            .disposed(by: disposeBag)
        
        self.tableView.rx.itemSelected
            .subscribe({[weak self] (value) in
                self?.cellSelected(selectedIndex: value.element)
            }).disposed(by: disposeBag)
        
        self.tableView.rx.itemAccessoryButtonTapped.subscribe({[weak self] (value) in
            if let indexPath = value.element {
                print("Tapped Detail @ \(indexPath.section),\(indexPath.row)")
                self?.cellInfoButtonTapped(selectedIndex: indexPath)
            }
        }).disposed(by: disposeBag)
        
        // weatherIcan
        self.viewModel.weatherIcon
            .bind(to: self.weatherImageView.rx.image)
            .disposed(by: disposeBag)
        
        // currentWeather
        self.viewModel.currentWeather
        .subscribe(onNext: {[weak self] (currentWeather) in
            print(currentWeather)
            self?.updateInfoView(currentWeather: currentWeather)
        }, onError: { (error) in
            print(error)
        }, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
    }
}

