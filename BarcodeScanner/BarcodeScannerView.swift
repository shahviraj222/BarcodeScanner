//
//  ContentView.swift
//  BarcodeScanner
//
//  Created by viraj shah on 09/05/25.
//

import SwiftUI

struct BarcodeScannerView: View {
    @State private var scannedCode = " "

    var body: some View {
        NavigationView{
            VStack{
                ScannerView(scannedCode: $scannedCode)
                    .frame(maxWidth:.infinity,maxHeight:300)
                
                Spacer()
                    .frame(height:60)
                
                Label("Scan Barcode", systemImage:"barcode.viewfinder")
                    .font(.title)
                
                Text(scannedCode.isEmpty ? "not yet scanned" : scannedCode)
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(scannedCode.isEmpty ? .red :.green)
                    .padding()
            }
            .navigationTitle("Barcode Scanner")
        }
    }
}

#Preview {
    BarcodeScannerView()
}
