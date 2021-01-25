//
//  BarcodeScannerView.swift
//  BarcodeScanner
//
//  Created by Fabien Lebon on 25/01/2021.
//

import SwiftUI

struct BarcodeScannerView: View {
    
    @State private var scannedValue: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                
//                .Infinity take the full screen
                ScannerView(scannedValue: $scannedValue).frame(maxWidth: .infinity, maxHeight: 300)
                
                Spacer().frame(height: 60)
                
                Label("Scanned Barcode :", systemImage: "barcode.viewfinder")
                    .font(.title)
                
                Text(scannedValue.isEmpty ? "Not Yer Scanned" : scannedValue)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(scannedValue.isEmpty ? .red : .green)
                    .padding()
                
            }.navigationTitle("Barcode Scanner")
        }
    }
}

struct BarcodeScannerView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeScannerView()
    }
}
