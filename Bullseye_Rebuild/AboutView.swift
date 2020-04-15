//
//  AboutView.swift
//  Bullseye_Rebuild
//
//  Created by Kathleen Hang on 4/1/20.
//  Copyright © 2020 Team Cowdog. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    let color = Color(red: 255/255, green: 149/255, blue: 43/255)
    
    var body: some View {
        Group {
            VStack {
                // title of game
                Text("Bullseye Game")
                    .modifier(TitleTextStyle())

                // description of game
                Text("Welcome to Bullseye! The objective of the game is to aim the slider button as closely as you can to the target value. When ready to fire, click the big blue button!")
                    .modifier(BodyTextStyle())

                Text("Have a BLAST!")
                .modifier(EndingTextStyle())
                    
            } // end of VStack
            .background(color) // overlay
            .cornerRadius(25)
            .shadow(color: Color.black, radius: 5, x: 2, y: 2)
    
        } // end of group view
        .background(Image("bg_beanstalk")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea([.top,.bottom,.leading,.trailing]))
    }
}

struct TitleTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .allowsTightening(true)
                .font(Font.custom("Revamped", size: 30))
                .padding(.bottom, 20)
                .padding(.top, 10)
                .navigationBarTitle("About Bullseye")
                .foregroundColor(Color.white)
                .shadow(color: Color.black, radius: 5, x: 2, y: 2)
    }
   }

struct BodyTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
        .foregroundColor(Color.white)
        .shadow(color: Color.black, radius: 5, x: 1, y: 1)
        .padding(.bottom, 14)
        .font(Font.custom("Revamped", size: 20))
    }
}

struct EndingTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
        .font(Font.custom("Revamped", size: 25))
        .padding(.bottom, 10)
        .foregroundColor(Color.blue)
        .shadow(color: Color.white, radius: 5, x: 2, y: 2)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
