//
//  VehicleCell.swift
//  eSparkTest
//
//  Created by Arvydas Klimavicius on 2020-10-12.
//

import UIKit

class VehicleCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var plateNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var vehicleImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configureCell(with vehicle: VehicleData) {
        titleLabel.text = vehicle.model.title
        plateNumberLabel.text = vehicle.plateNumber
        addressLabel.text = vehicle.location.address
        
        let url = URL(string: vehicle.model.photoUrl)!
        vehicleImageView.load(url: url)
        
        
    }

}
