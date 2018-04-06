//
//  ViewController.swift
//  Detection Camera
//
//  Created by Nnamdi Affia on 06/04/2018.
//  Copyright © 2018 Nnamdi Affia. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let captureSession = AVCaptureSession()
        
        guard let captureDevice = AVCaptureDevice.default(for: .video)
            else
        {
            return
            
        }
        
        guard let input = try? AVCaptureDeviceInput (device: captureDevice)
            else
        
        {
            return
        }
        
        captureSession.addInput(input)
        
        captureSession.startRunning()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

