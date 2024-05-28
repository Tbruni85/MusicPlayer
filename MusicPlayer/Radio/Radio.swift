//
//  Radio.swift
//  MusicPlayer
//
//  Created by Tiziano Bruni on 28/05/2024.
//

import Foundation

struct Radio: Decodable, Hashable {
    
    let image: String
    let name: String
    let stream: String
    
#if DEBUG
    static let example = Radio(image: "goku_feed",
                               name: "Goku",
                               stream: "https://radio.virginradio.co.uk/stream?aw_0_1st.platform=website&aw_0_1st.playerid=broadcast-web-virginradio")
#endif
}


