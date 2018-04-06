//
//  ViewController.swift
//  Detection Camera
//
//  Created by Nnamdi Affia on 06/04/2018.
//  Copyright © 2018 Nnamdi Affia. All rights reserved.
//

import UIKit
import AVKit
import Vision

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //launch camera session
        let captureSession = AVCaptureSession()
        //setup camera
        guard let captureDevice = AVCaptureDevice.default(for: .video)
            else
        {
            return
            
        }
        //set up video input
        guard let input = try? AVCaptureDeviceInput (device: captureDevice)
            else
        
        {
            return
        }
        
        captureSession.addInput(input)
        
        captureSession.startRunning()
        
        //set up video output
        let previewLayer = AVCaptureVideoPreviewLayer (session: captureSession)
        
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

