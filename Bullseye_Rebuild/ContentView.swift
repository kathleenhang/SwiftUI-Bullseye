   //
   //  ContentView.swift
   //  Bullseye_Rebuild
   //
   //  Created by Kathleen Hang on 3/26/20.
   //  Copyright © 2020 Team Cowdog. All rights reserved.
   //
   
   import SwiftUI
   
   struct ContentView: View {
    @State private var showingAlert = false
    @State var sliderValue = 0.0
    let sliderMinVal = 1.0
    let sliderMaxVal = 100.0
    @State var pointsEarned = 0
    @State var totalScore = 0
    @State var round = 1
    @State var randomTargetVal = Int.random(in: 1...100)
    
    var body: some View {
        NavigationView {
            
            VStack {
                Spacer().navigationBarTitle("SMACK IT HARD")
                
                
                // ROW: target value / prompt ***********
                HStack {
                    Text("Try to land slider value on target value:")
                        
                        .modifier(LargePromptTextStyle())
                    Text("\(randomTargetVal)")
                        .modifier(ValueTextStyle())
                }
                
                // ROW: slider *************
                HStack {
                    // display min val = 1
                    Text("\(Int(sliderMinVal))")
                        .padding()
                        .modifier(SmallPromptTextStyle())
                    Slider(value: $sliderValue, in: sliderMinVal...sliderMaxVal)
                        .accentColor(.green)
                    // display max val = 100
                    Text("\(Int(sliderMaxVal))")
                        .padding()
                        .modifier(SmallPromptTextStyle())
                }
                
                // ROW: Button to fire
                Button(action: {
                    self.showingAlert.toggle()
                    self.calculatePointsEarned()
                }) {
                    HStack {
                        Image("fluffy_dog")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50.0, height: 50.0)
                        Text(" Hit Me Babeh One Moar Tyme ")
                    }
                }// end of button implementation
                    .modifier(ButtonTextStyle())
                    // .shadow(color: Color.black, radius: 5, x: 2, y: 2)
                    .alert(isPresented: self.$showingAlert) {
                        Alert(title: Text(alertTitleMessage()),
                              message: Text(alertDescriptionMessage()),
                              dismissButton: .default(Text("BYE")){
                                self.updateGameBoard()
                            })
                }
                    
                .buttonStyle(PlainButtonStyle())
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(15)
                .shadow(color: Color.black, radius: 5, x: 2, y: 2)
                
                
                Spacer()
                
                // ROW: score, rounds, bottom ***************
                HStack {
                    
                    Button(action: {
                        // when player clicks start over button....
                        // reset rounds to 1
                        self.startNewGame()
                    }) {
                        // what button will look like
                        Text(" Start Over ")
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                        
                    }
                    .frame(width: 225.0, height: 50.0)
                    .modifier(ButtonTextStyle())
                    
                    Spacer()
                    Text("Score:")
                        .modifier(SmallPromptTextStyle())
                    
                    Text("\(totalScore)")
                        .modifier(ValueTextStyle())
                    
                    Spacer()
                    
                    Text("Round:")
                        .modifier(SmallPromptTextStyle())
                    
                    
                    Text("\(round)")
                        .modifier(ValueTextStyle())
                    
                    Spacer()
                    
                    NavigationLink(destination: AboutView()) {
                        Text(" Info ")
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                    }
                    .frame(width: 100.0, height: 50)
                    .modifier(ButtonTextStyle())
                    //.padding()
                }
                // slider starting value is at halfway point
            } // end of main VStack ****
                
                .onAppear() {
                    self.sliderValue = 50.0
            }
                // background of entire app
                
                
                .background( Image("bg_beanstalk")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea([.top,.bottom,.leading,.trailing]))
            
        } // end of NavigationView
            .navigationViewStyle(StackNavigationViewStyle())
        
        
    } // end of body
    
    func calculatePointsEarned() {
        let difference = abs(self.randomTargetVal - Int(self.sliderValue))
        // calculate points for current round
        if difference == 0 {
            // player earns extra 200 points for perfect score
            self.pointsEarned = 200
        } else if difference <= 5 {
            self.pointsEarned = 150
        } else {
            self.pointsEarned = 100 - difference
        }
        
    }
    
    func startNewGame() {
        self.round = 1
        // reset score to 0
        self.totalScore = 0
        // reset slider position
        self.sliderValue = 50.0
        // generate new random target value
        self.randomTargetVal = Int.random(in: 1...100)
    }
    
    
    func updateGameBoard() {
        // increment round
        self.round += 1
        // reset slider position
        self.sliderValue = 50
        self.randomTargetVal = Int.random(in: 1...100)
        // accumulate score
        self.totalScore += self.pointsEarned
    }
    // Alert pop up title string display
    func alertTitleMessage() -> String {
        
        let difference = abs(randomTargetVal - Int(sliderValue))
        var alertTitle = ""
        
        
        if difference == 0 {
            alertTitle = "Perfect!"
        } else if difference < 10 {
            alertTitle = "Super Close!"
        } else if difference < 50 {
            alertTitle = "Meh..."
        } else {
            alertTitle = "Not even close..."
        }
        return alertTitle
        
    } // function end
    // Alert description string display
    func alertDescriptionMessage() -> String {
        return "Slider value: \(Int(sliderValue))\n" +
            "Target value: \(randomTargetVal)\n" +
        "You earned \(pointsEarned) points!"
        
    }
   } // end of ContentView
   
   
   struct ValueTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.orange)
            // .shadow(color: Color.black, radius: 5, x: 2, y: 2)
            .font(Font.custom("Revamped", size: 25)
                .bold())
    }
   }
   struct SmallPromptTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.black)
            // .shadow(color: Color.black, radius: 5, x: 2, y: 2)
            .font(Font.custom("Revamped", size: 20)
                .bold())
    }
   }
   
   struct ButtonTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.white)
            .shadow(color: Color.black, radius: 5, x: 2, y: 2)
            .font(Font.custom("Revamped", size: 20)
                .bold())
    }
   }
   
   struct LargePromptTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.black)
            //  .shadow(color: Color.black, radius: 3, x: 2, y: 2)
            .font(Font.custom("Revamped", size: 25)
                .bold())
    }
   }
   
   struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
   }
   
   
   
   // brush teeth, draw uml , explain how app is built
