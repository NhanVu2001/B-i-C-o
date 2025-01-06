/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Vu Thien Nhan
  ID: Your student id (e.g. 1234567)
  Created  date: 22/08/2022
  Last modified: 29/08/2022
  Acknowledgement: https://github.com/TomHuynhSG/RMIT-Casino.
*/

import SwiftUI

struct GameView: View {
    //Set value for width and height to match with devices'
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    @State var userName: String
    //Setup cardDeck array, order from ace to king, hearts to spade
    let cardDeck = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","Cardback"]
    //Array for cards' values
    let cardValue = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10,1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10,1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10,]
    //Variables for leaderboard
    @State private var highScores = UserDefaults.standard.array(forKey: "highScores") as? [Int] ?? [0,0,0,0,0,0,0,0,0,0]
    @State private var hsHolders = UserDefaults.standard.stringArray(forKey: "hsHolders") ?? ["","","","","","","","","",""]
    @State private var isHighScore = false
    //Initial player's and dealer's hands display card backs
    @State private var playerHand = [52,52,52]
    @State private var dealerHand = [52,52,52]
    //Variables for calculation
    @State private var playerPoint:Int = 0
    @State private var dealerPoint:Int = 0
    @State private var tempPoint:Int = 0
    //Initial game values
    @State private var money = 200
    @State private var betAmount = 50
    @State private var winStreak = 0
    @State private var highestStreak = 0
    //Bet amount booleans
    @State private var isBetAmount50 = true
    @State private var isBetAmount100 = false
    //Booleans for displaying info view and game over sheet
    @State private var showingInfoView = false
    @State private var showGameOverModal = false
    //
    @State private var isAnimatingDealer = false
    @State private var isAnimatingPlayer = false
    
    // MARK: - Functions
    //Randomise player's hand
    func getPlayerHand() {
        playerHand = playerHand.map({ _ in
            Int.random(in: 0...cardDeck.count-2)
        })
    }
    //Randomise player's hand
    func getDealerHand() {
        dealerHand = dealerHand.map({ _ in
            Int.random(in: 0...cardDeck.count-2)
        })
    }
    //Calculate dealer's and player's point
    func calPoint1() -> Int{
        tempPoint = cardValue[dealerHand[0]]+cardValue[dealerHand[1]]+cardValue[dealerHand[2]]
        dealerPoint = tempPoint % 10
        return dealerPoint
    }
    func calPoint2() -> Int{
        tempPoint = cardValue[playerHand[0]]+cardValue[playerHand[1]]+cardValue[playerHand[2]]
        playerPoint = tempPoint % 10
        return playerPoint
    }
    //Check winning logic
    func checkWinning() {
        //Player's win condition
        if playerPoint > dealerPoint{
            playerWins()
            //Set new highest win streak
            if winStreak > highestStreak {
                highestStreak = winStreak
                for i in 0..<highScores.count {
                    if (highScores[i]) < highestStreak {
                        var counter = 0
                        for _ in i..<highScores.count - 1 {
                            highScores[highScores.count - 1 - counter] = highScores[highScores.count - 2 - counter]
                            hsHolders[highScores.count - 1 - counter] = hsHolders[highScores.count - 2 - counter]
                            counter += 1
                        }
                        highScores[i] = highestStreak
                        hsHolders[i] = userName
                        UserDefaults.standard.set(highScores, forKey: "highScores")
                        UserDefaults.standard.set(hsHolders, forKey: "hsHolders")
                        
                        break
                    }
                }
            } else {
                highestStreak = highestStreak
            }
        } else if playerPoint == dealerPoint {
            draw()
        }
        else {
            playerLoses()
        }
    }
    //Draw logic
    func draw() {
        money = money
        winStreak = winStreak
    }
    //Player win logic
    func playerWins() {
        money += betAmount*2
        winStreak += 1
    }
    //Player lose logic
    func playerLoses() {
        money -= betAmount
        winStreak = 0
    }
    //Game over condition
    func isGameOver() {
        if money <= 0 {
            showGameOverModal = true
        }
    }
    //Bet amount functions
    func chooseBet50() {
        betAmount = 50
        isBetAmount50 = true
        isBetAmount100 = false
        playSound(sound: "bet-chip", type: "mp3")
    }
    func chooseBet100() {
        betAmount = 100
        isBetAmount50 = false
        isBetAmount100 = true
        playSound(sound: "bet-chip", type: "mp3")
    }
    //Reset game to inital values
    func resetGame(){
        UserDefaults.standard.set(0, forKey: "highscore")
        dealerHand = [52,52,52]
        playerHand = [52,52,52]
        winStreak = 0
        betAmount = 50
        isBetAmount50 = true
        isBetAmount100 = false
        money = 200
        playSound(sound: "reshuffle-card", type: "mp3")
    }
    
    // MARK: - Game UI
    var body: some View {
        ZStack{
            Image("Background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            VStack {
                Image("LogoBaiCao")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 200, alignment: .center)
                
                VStack {
                    HStack{
                        ZStack {
                            Capsule()
                                .foregroundColor(Color("ColorBlackTransparent"))
                                .frame(width: 150, height: 50)
                            
                            Text("Logged\nin as:\(userName)")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .heavy, design: .rounded))
                                .frame(width: 120, height: 50, alignment: .leading)
                        }
                        Spacer()
                        ZStack {
                            Capsule()
                                .foregroundColor(Color("ColorBlackTransparent"))
                                .frame(width: 150, height: 50)
                            HStack{
                                Text("Highest\nwin streak")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20, weight: .heavy, design: .rounded))
                                    .multilineTextAlignment(.trailing)
                                Text(String(highestStreak))
                                    .foregroundColor(.white)
                                    .font(.system(size: 20, weight: .heavy, design: .rounded))
                            }
                            .frame(width: 150, height: 50)
                        }
                    }.padding(.horizontal, 10)
                    
                    HStack {
                        ZStack {
                            Capsule()
                                .foregroundColor(Color("ColorBlackTransparent"))
                                .frame(width: 150, height: 50)
                            Text("Cash: \(money)$")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .heavy, design: .rounded))
                        }
                        .frame(width: 150, height: 50)
                        
                        Spacer()
                        
                        ZStack{
                            Capsule()
                                .foregroundColor(Color("ColorBlackTransparent"))
                                .frame(width: 150, height: 50)
                            HStack{
                                Text("Current\nwin streak")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20, weight: .heavy, design: .rounded))
                                    .multilineTextAlignment(.trailing)
                                Text(String(winStreak))
                                    .foregroundColor(.white)
                                    .font(.system(size: 20, weight: .heavy, design: .rounded))
                            }
                        }
                        .frame(width: 150, height: 50)
                    }.padding(.horizontal,10)
                }
                VStack{
                    HStack{
                        Image(cardDeck[dealerHand[0]])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 145)
                            .opacity(isAnimatingDealer ? 1 : 0)
                            .offset(x: isAnimatingDealer ? 0 : 20)
                            .animation(.easeOut(duration: 0.5), value: isAnimatingDealer)
                            .onAppear(perform: {
                                self.isAnimatingDealer.toggle()
                            })
                        
                        Image(cardDeck[dealerHand[1]])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 145)
                            .opacity(isAnimatingDealer ? 1: 0)
                            .offset(x: isAnimatingDealer ? 0 : 20)
                            .animation(.easeOut(duration: 0.7), value: isAnimatingDealer)
                            .onAppear(perform: {
                                self.isAnimatingDealer.toggle()
                            })
                        
                        Image(cardDeck[dealerHand[2]])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 145)
                            .opacity(isAnimatingDealer ? 1: 0)
                            .offset(x: isAnimatingDealer ? 0 : 20)
                            .animation(.easeOut(duration: 0.9), value: isAnimatingDealer)
                            .onAppear(perform: {
                                self.isAnimatingDealer.toggle()
                            })
                    }
                    Text("Dealer's score: \(dealerPoint)")
                }
                //Player's hand and total point
                VStack {
                    Text("Player's score: \(playerPoint)")
                    HStack{
                        Image(cardDeck[playerHand[0]])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 145)
                            .opacity(isAnimatingPlayer ? 1: 0)
                            .offset(x: isAnimatingPlayer ? 0 : 20)
                            .animation(.easeOut(duration: 0.5), value: isAnimatingPlayer)
                            .onAppear(perform: {
                                self.isAnimatingPlayer.toggle()
                            })
                        Image(cardDeck[playerHand[1]])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 145)
                            .opacity(isAnimatingPlayer ? 1: 0)
                            .offset(x: isAnimatingPlayer ? 0 : 20)
                            .animation(.easeOut(duration: 0.7), value: isAnimatingPlayer)
                            .onAppear(perform: {
                                self.isAnimatingPlayer.toggle()
                            })
                        Image(cardDeck[playerHand[2]])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 145)
                            .opacity(isAnimatingPlayer ? 1: 0)
                            .offset(x: isAnimatingPlayer ? 0 : 20)
                            .animation(.easeOut(duration: 0.9), value: isAnimatingPlayer)
                            .onAppear(perform: {
                                self.isAnimatingPlayer.toggle()
                            })
                    }
                }
                //Deal Button
                Button {
                    // Deal card sound
                    playSound(sound: "deal-card", type: "mp3")
                    // No animation
                    withAnimation{
                        self.isAnimatingDealer = false
                        self.isAnimatingPlayer = false
                    }
                    self.getDealerHand()
                    self.getPlayerHand()
                    // Trigger animation
                    withAnimation{
                        self.isAnimatingDealer = true
                        self.isAnimatingPlayer = true
                    }
                    self.calPoint1()
                    self.calPoint2()
                    self.checkWinning()
                    self.isGameOver()
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(Color(red: 0.7705919147, green: 0.1937867403, blue: 0.1496810615))
                            .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color(red: 0.9469942451, green: 0.9170835018, blue: 0.8738509417), lineWidth: 3))
                            .frame(width: 100, height: 50)
                        Text("Deal")
                            .fontWeight(.heavy)
                            .foregroundColor(Color.green)
                    } //ZStack end
                } //label end
                //Bet amount buttons
                HStack{
                    //Bet 50
                    
                    HStack{
                        Button {
                            self.chooseBet50()
                        } label: {
                            HStack{
                                ZStack{
                                    Capsule()
                                        .foregroundColor(Color("ColorBlackTransparent"))
                                        .frame(width: 100, height: 50)
                                    Text("50$")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20, weight: .heavy, design: .rounded))
                                }
                                Image("cash")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 50)
                                    .opacity(isBetAmount50 ? 1:0)
                                    .offset(x: isBetAmount50 ? 0:20)
                                    .animation(.default, value: isBetAmount50)
                            }.padding(.horizontal,10)
                        }
                    }
                    
                    Spacer()
                    
                    HStack{
                        Button {
                            self.chooseBet100()
                        } label: {
                            HStack{
                                Image("cash")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 50)
                                    .opacity(isBetAmount100 ? 1:0)
                                    .offset(x: isBetAmount100 ? 0:20)
                                    .animation(.default, value: isBetAmount100)
                                ZStack {
                                    Capsule()
                                        .foregroundColor(Color("ColorBlackTransparent"))
                                        .frame(width: 100, height: 50)
                                    Text("100$")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20, weight: .heavy, design: .rounded))
                                }
                                
                            }
                        }
                    }
                }
            }
            .frame(width: width, height: height-10, alignment: .top)
            
            .overlay(
                HStack{
                    Button(action: {
                        withAnimation{
                            self.isAnimatingDealer = false
                            self.isAnimatingPlayer = false
                        }
                        self.resetGame()
                        withAnimation{
                            self.isAnimatingDealer = true
                            self.isAnimatingPlayer = true
                        }
                    }) {
                        Image(systemName: "arrow.2.circlepath.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                    }.frame(width: 30, height: 30)
                    
                    Button(action: {
                        self.showingInfoView = true
                    }) {
                        Image(systemName: "info.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                    }.frame(width: 40, height: 30)
                }.frame(width: width, height: height, alignment: .topTrailing)
                    .padding(.top,30)
                
            )
            .padding()
            .frame(maxWidth: 720)
            .blur(radius:  showGameOverModal ? 5 : 0 , opaque: false)
            
            if showGameOverModal{
                ZStack{
                    Color("ColorBlackTransparent")
                        .edgesIgnoringSafeArea(.all)
                    VStack{
                        Text("GAME OVER")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)
                            .foregroundColor(Color.white)
                            .padding()
                            .frame(minWidth: 280, idealWidth: 280, maxWidth: 320)
                            .background(Color("ColorRedRMIT"))
                        
                        Spacer()
                        
                        VStack {
                            Image("LogoBaiCao")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 150)
                            Text("You've gone broke!\nMaybe gambling isn't as easy as it seems!\n Don't try solving your problem with gambling!")
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.center)
                            Button {
                                self.showGameOverModal = false
                                self.money = 200
                            } label: {
                                Text("New Game".uppercased())
                            }
                            .padding(.vertical,10)
                            .padding(.horizontal, 20)
                            .background(
                                Capsule()
                                    .strokeBorder(lineWidth: 2)
                                    .foregroundColor(Color("ColorRedRMIT"))
                            )
                            
                        }
                        Spacer()
                    }
                    .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 280, idealHeight: 300, maxHeight: 350, alignment: .center)
                    .background(Color("ColorBlueRMIT"))
                    .cornerRadius(20)
                }.onAppear(perform: {
                    playSound(sound: "gameover", type: "mp3")
                })
            }
        }.frame(width: width, height: height)
            .sheet(isPresented: $showingInfoView) {
                HowToPlayView()
            }
    }
}
//
//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView()
//            .previewInterfaceOrientation(.portrait)
//    }
//}
