//
//  ViewController.swift
//  today
//
//  Created by Florian MOUCHET on 28/01/2022.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var z: UILabel!
    @IBOutlet weak var y: UILabel!
    @IBOutlet weak var x: UILabel!
    
    func affiche(i: Int){
        /*let rect = CGRect(x: 50, y: 100, width: 200, height: 100)
        let label = UILabel(frame: rect)
        label.text = i.description
        label.numberOfLines = 2
        view.addSubview(label)
        view.backgroundColor = .red*/
        
    }
    
    func affichePasMove(){
        let rect = CGRect(x: 50, y: 100, width: 200, height: 100)
        let label = UILabel(frame: rect)
        label.text = " "
        label.numberOfLines = 2
        view.addSubview(label)
        view.backgroundColor = .black
    }
    
    let manager = CMMotionManager()
    private let pedometer = CMPedometer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var i = 0
        var iter = 0
        
        if manager.isGyroAvailable {
          // CMMotionManager is available.
          manager.gyroUpdateInterval = 0.1
          manager.startGyroUpdates()

          // get gyro data...
          let queue = OperationQueue.main
            manager.startGyroUpdates(to: queue) {
             (data, error) in
             // ... get data here
          }
        }

        
        manager.startAccelerometerUpdates()
        
        manager.accelerometerUpdateInterval = 3
        
        var precX: Double = 0
        var precY: Double = 0
        var precZ: Double = 0
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ _ in
            if let data = self.manager.accelerometerData{
                iter = iter + 1
                let x1 = data.acceleration.x
                let y1 = data.acceleration.y
                let z1 = data.acceleration.z
                
                self.x.text = String(x1)
                self.y.text = String(y1)
                self.z.text = String(z1)
                
                if abs(x1 - precX) > 0.5 || abs(y1 - precY) > 0.5 || abs(z1 - precZ) > 0.5{
                    i = i + 1
                    precX = x1
                    precY = y1
                    precZ = z1
                    self.affiche(i: i)
                }
                else{
                    self.affichePasMove()
                    
                }
            }
        }
    }

    
}

