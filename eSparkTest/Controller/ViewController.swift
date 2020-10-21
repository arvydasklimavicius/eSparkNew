//
//  ViewController.swift
//  eSparkTest
//
//  Created by Arvydas Klimavicius on 2020-10-12.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    var availableVehicles = [VehicleData]()
    let locationManager = CLLocationManager()
    
//    let location = LocationManager()
//    var vehicleApi = VehicleApi()
    


    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterController: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        tableView.dataSource = self
        tableView.delegate = self
        getVehicle()
        
//        location.locationManager.requestWhenInUseAuthorization()
//        vehicleApi.getVehicle()


    }
    
    
 //MARK: - URL session call
    
    func getVehicle() {
        let session = URLSession.shared
        let url = URL(string: "https://development.espark.lt/api/mobile/public/availablecars")!
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                self.availableVehicles = self.parseJsonData(data: data)
                OperationQueue.main.addOperation({
                                self.tableView.reloadData()
                            })
            }
        }
        task.resume()
    }
    
    func parseJsonData(data: Data) -> [VehicleData] {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([VehicleData].self, from: data)
            for vehicle in decodedData {
                availableVehicles.append(vehicle)
                print(availableVehicles)
                print(availableVehicles.count)
                
                
                
            }
        } catch {
            print(error)
        }
        return availableVehicles
    }
 //MARK: - Filtering functionality
    
    @IBAction func filterChanged(_ sender: UISegmentedControl) {
        
        switch filterController.selectedSegmentIndex {
        case 0:
            availableVehicles.sort { (first, second) -> Bool in
                first.plateNumber.lowercased() < second.plateNumber.lowercased()
            }
            tableView.reloadData()
        case 1:
            availableVehicles.sort { (first, second) -> Bool in
                first.batteryPercentage < second.batteryPercentage
            }
            tableView.reloadData()

        default: break
        }
        
        
        
    }
    
    
}

//MARK: - TabkeView configuration

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableVehicles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VehicleCell", for: indexPath)
        if let vehicleCell = cell as? VehicleCell{
            let vehicle = availableVehicles[indexPath.row]
            vehicleCell.configureCell(with: vehicle)
        }
        return cell
    }
    
    
}

//MARK: - CLLocationManager Delegate
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lon = location.coordinate.longitude
            let lat = location.coordinate.latitude
            print("\(lon), \(lat)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

