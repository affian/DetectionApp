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

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

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
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue:  DispatchQueue (label:"videoQueue"))
        
    }
    // build frame for ML model
    func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        print("Camera successfully printed frame", Date())
    
    
    guard let pixelBuffer : CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        else
    {
    return
    }
    
    let request = VNCoreMLRequest(model: <#T##VNCoreMLModel#>)
    {
        (finishedReq, err) in
        
        //check the error
        
        print(finishedReq.results)
    }
    
    VNImageRequestHandler(cvPixelBuffer: <#T##CVPixelBuffer#>, options: <#T##[VNImageOption : Any]#>).perform(<#T##requests: [VNRequest]##[VNRequest]#>)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

