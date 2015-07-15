//
//  QRViewController.swift
//  Museum-App-iOS
//
//  Created by THOMAS NEEDHAM on 13/07/2015.
//  Copyright (c) 2015 THOMAS NEEDHAM. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

internal class QRViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var QRCodeFrameView: UIView?
    
    required internal init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        let captureDevice:AVCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        var error:NSError?
        let input:AnyObject! = AVCaptureDeviceInput.deviceInputWithDevice(captureDevice, error: &error)
        if(error != nil){
            NSLog("An Error Occured: %@", error!.localizedDescription)
        }
        captureSession = AVCaptureSession()
        captureSession?.addInput(input as! AVCaptureInput)
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetadataOutput)
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer)
        captureSession?.startRunning()
        NSLog("QR Controller Loaded");
    }
    
    override internal func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
