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
        
        captureSession.sessionPreset = .photo
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
        
     
        // build frame for ML model
        
    }
    
    func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection)
    {
        //print("Camera successfully printed frame", Date())
        
        guard let pixelBuffer : CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
            else
        {
            return
        }
        // set squeezenet model
        guard let model = try? VNCoreMLModel(for: Resnet50().model)
            else
        {
            return
        }
        
        let request = VNCoreMLRequest(model: model)
        {
            (finishedReq, err) in
            
            //check the error
            
            //print(finishedReq.results as Any)
            
            //put results in array of classification observation
            
            guard let results = finishedReq.results as? [VNClassificationObservation]
                else
            {
                return
            }
            
            //print first object camera sees
            guard let firstObservation = results.first
                else
            {
                return
            }
            
            //print results to console
            print(firstObservation.identifier, firstObservation.confidence)
        }
        
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
        
    }
    

}

