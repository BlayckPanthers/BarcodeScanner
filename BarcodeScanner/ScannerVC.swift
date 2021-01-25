//
//  ScannerVC.swift
//  BarcodeScanner
//
//  Created by Fabien Lebon on 25/01/2021.
//

import AVFoundation
import UIKit

protocol ScannerVCDelegate: class {
    func didFind(barcode: String)
    
}

final class ScannerVC: UIViewController {
    // UIViewController works Through Delegates and protocols, with swiftUI Coordinator receive informations from UIViewController and pass it to SwiftUI
    
    let captureSession = AVCaptureSession()
    
    // display on the screens what the camera is filming
    var previewLayer: AVCaptureVideoPreviewLayer?
    weak var scannerDelegate: ScannerVCDelegate?
    
    init(scannerDelegate: ScannerVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.scannerDelegate = scannerDelegate
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupCaptureSession(){
        // Do we have a video capture available ?
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            return
        }
        
        let metaDataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metaDataOutput) {
            captureSession.addOutput(metaDataOutput)
            
            // setup what are we looking for the the camera https://en.wikipedia.org/wiki/EAN-8 https://en.wikipedia.org/wiki/EAN-13
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            // ean8 and ean13 = barcode format
            metaDataOutput.metadataObjectTypes = [.ean8, .ean13]
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        // fill the view but keep your aspectRatio
        previewLayer!.videoGravity = .resizeAspectFill
        view .layer.addSublayer(previewLayer!)
        
        captureSession.startRunning()
    }
}

extension ScannerVC: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let object = metadataObjects.first else {
            return
        }
        
        guard let machineReadeableObject = object as? AVMetadataMachineReadableCodeObject else {
            return
        }
        
        guard let barcode = machineReadeableObject.stringValue else {
            return
        }
        
        scannerDelegate?.didFind(barcode: barcode)
    }
    
}
