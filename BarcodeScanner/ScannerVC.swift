//
//  ScannerVC.swift
//  BarcodeScanner
//
//  Created by viraj shah on 10/05/25.
//

import UIKit
import AVFoundation

enum CameraError:String
{
    case invalidDeviceInput = "" 
}

protocol ScannerVCDelegate: class{
    func didFind(barcode:String)
}

final class ScannerVC: UIViewController {
    let caputuredSession = AVCaptureSession()
    var previewLayer:AVCaptureVideoPreviewLayer?
    weak var scannerDelegate:ScannerVCDelegate!
    
    init(scannerDelegate:ScannerVCDelegate){
        super.init(nibName: nil, bundle: nil)
        self.scannerDelegate = scannerDelegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCaptureSession(){
        guard let videoCaptureDevice = AVCaptureDevice.default(for:.video) else{
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        do {
            try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
            catch{
                return
            }
        }
        if caputuredSession.canAddInput(videoInput){
            caputuredSession.addInput(videoInput)
        }
        else{
            return
        }
        let metaDataOutput = AVCaptureMetadataOutput()
        
        if caputuredSession.canAddOutput(metaDataOutput){
            caputuredSession.addOutput(metaDataOutput)
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metaDataOutput.metadataObjectTypes = [.ean8,.ean13]
        }else{
            return
        }
            
        previewLayer = AVCaptureVideoPreviewLayer(session: caputuredSession)
        previewLayer!.videoGravity  = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)
        
        caputuredSession.startRunning()
        
    }
    
}

extension ScannerVC: AVCaptureMetadataOutputObjectsDelegate{
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let object = metadataObjects.first else{
            return
        }
        
        
        guard let machineReadableObject = object as? AVMetadataMachineReadableCodeObject else {
            return
        }
        
        guard let barcode = machineReadableObject.stringValue else{
            return
        }
        scannerDelegate?.didFind(barcode: barcode)
    }
}
