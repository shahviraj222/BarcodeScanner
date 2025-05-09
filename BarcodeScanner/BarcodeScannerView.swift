//
//  ContentView.swift
//  BarcodeScanner
//
//  Created by viraj shah on 09/05/25.
//

import SwiftUI

struct BarcodeScannerView: View {
    var body: some View {
        NavigationView{
            VStack{
                Rectangle()
                    .frame(maxWidth:.infinity,maxHeight:300)
                
                Spacer()
                    .frame(height:60)
                
                Label("Scan Barcode", systemImage:"barcode.viewfinder")
                    .font(.title)
                
                Text("Not Scaned yet")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(.green)
                    .padding()
            }
            .navigationTitle("Barcode Scanner")
        }
    }
}

#Preview {
    BarcodeScannerView()
}
