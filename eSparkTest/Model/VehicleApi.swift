//
//  VehicleApi.swift
//  eSparkTest
//
//  Created by Arvydas Klimavicius on 2020-10-13.
//

import Foundation

class VehicleApi {
    
    var availableVehicles = [VehicleData]()
            
    
    
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
                
//                OperationQueue.main.addOperation({
//                    self.vc.tableView.reloadData()
//                            })
            }
            
    }
        task.resume()
    }
    
    func parseJsonData(data: Data) -> [VehicleData] {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([VehicleData].self, from: data)
            DispatchQueue.main.async {
                for vehicle in decodedData {
                    self.availableVehicles.append(vehicle)
                    print(self.availableVehicles)
                    print(self.availableVehicles.count)
                   
            }
//            for vehicle in decodedData {
//                availableVehicles.append(vehicle)
//                print(availableVehicles)
//                print(availableVehicles.count)
                
            }
        } catch {
            print(error)
        }
        return availableVehicles
    }

    
}
