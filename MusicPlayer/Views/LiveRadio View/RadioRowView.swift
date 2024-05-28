//
//  RadioRowView.swift
//  MusicPlayer
//
//  Created by Tiziano Bruni on 28/05/2024.
//

import SwiftUI

struct RadioRowView: View {
    let radio: Radio
    
    var body: some View {
        HStack {
            Image(radio.image)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())

            Text(radio.name)
                .font(.headline)
            Spacer()
        }
    }
}

#Preview {
    RadioRowView(radio: Radio.example)
}
