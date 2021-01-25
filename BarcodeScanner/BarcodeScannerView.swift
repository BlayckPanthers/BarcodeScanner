//
//  BarcodeScannerView.swift
//  BarcodeScanner
//
//  Created by Fabien Lebon on 25/01/2021.
//

import SwiftUI

struct BarcodeScannerView: View {
    
    @State var scanValue: String = "Not Yet Scanned"
    @State var scanned: Color = .red
    
    var body: some View {
        NavigationView {
            VStack {
                
//                .Infinity take the full screen
                Rectangle().frame(maxWidth: .infinity, maxHeight: 300)
                
                Spacer().frame(height: 60)
                
                Label("Scanned Barcode :", systemImage: "barcode.viewfinder")
                    .font(.title)
                
                Text(scanValue)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(scanned)
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
