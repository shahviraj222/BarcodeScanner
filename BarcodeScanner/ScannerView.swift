//
//  ScannerView.swift
//  BarcodeScanner
//
//  Created by viraj shah on 13/05/25.
//

//calling uiview controller into this file

//step1 : make scannerView to UIViewControllerRepresentable
//step2 : write the typealias
//step3 :


import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
    
    @Binding var scannedCode:String
    
    func makeCoordinator() -> Coordinator {
        Coordinator(scannerView:self)
    }
    
     
    
    func makeUIViewController(context: Context) -> ScannerVC {
        ScannerVC(scannerDelegate: context.coordinator)
    }

    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) {}
    
    final class Coordinator: NSObject, ScannerVCDelegate {
        
        private let scannerView:ScannerView
        init(scannerView: ScannerView) {
            self.scannerView = scannerView
        }
        
        func didFind(barcode: String) {
            scannerView.scannedCode = barcode
            print(barcode)
        }
        
        func didSurface(error: CameraError) {
            print(error.rawValue)
        }
        
    }
    

    
  

}

#Preview {
    ScannerView(scannedCode: .constant("123456"))
}
