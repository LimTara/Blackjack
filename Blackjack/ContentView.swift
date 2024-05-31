//
//  ContentView.swift
//  Blackjack
//
//  Created by Tara Lim on 31/5/2024.
//

import SwiftUI
struct ContentView: View {
    
    // Stating general variables
    @State var myDeck: [String] = []
    @State var turn = true
    @State var cardsDealt = false
    @State var aceAlert = false
    
    // Stating variables for player
    @State var playerHand: [String] = []
    @State var playerCount = 0
    @State var playerScore = 0
    @State var playerWin: Bool? = nil
    @State var totalPlayerScore: Int = 0
    
    // Stating variables for dealer
    @State var dealerHand: [String] = []
    @State var dealerCount = 0
    @State var dealerScore = 0
    @State var totalDealerScore: Int = 0
    
    // Function for randomizing card
    func randomCard(deck: [String]) -> String {
        let maxRange = deck.count - 1
        let randomNum = Int.random(in: 0...maxRange)
        
        return deck[randomNum]
    }
    
    // Function for naming all cards
    func createDeck() -> [String] {
        let suits = ["Hearts", "Diamonds", "Spades", "Clubs"]
        var blankDeck: [String] = []
        
        for suit in suits {
            for rank in 1...13 {
                if rank < 10 {
                    let newCard = suit + "0" + String(rank)
                    blankDeck.append(newCard)
                } else {
                    let newCard = suit + String(rank)
                    blankDeck.append(newCard)
                }
            }
        }
        return blankDeck
    }
    
    // Function and logic for player's card when clicked "HIT"
    func addPlayerCard() {
        if playerCount < 5 {
            let randomIndex = Int.random(in: 0..<myDeck.count)
            let card = myDeck[randomIndex]
            playerHand.append(card)
            myDeck.remove(at: randomIndex)
            playerCount += 1
            turn = true
            
            let lastCard = String(card)
            let cardRank = Int(lastCard.suffix(2)) ?? 0
            print(cardRank)
            
            // Scoring cards
            if cardRank == 1 {
                aceAlert = true
            } else if cardRank < 10 {
                playerScore += cardRank
            } else if cardRank >= 10 {
                playerScore += 10
            }
            
        } else {
            print("No more cards being dealt")
        }
    }
    
    // Function and logic for dealer's card when clicked "STAY"
    func addDealerCard() {
        if dealerCount < 5 {
            let randomIndex = Int.random(in: 0..<myDeck.count)
            let card = myDeck[randomIndex]
            dealerHand.append(card)
            myDeck.remove(at: randomIndex)
            dealerCount += 1
            turn = true
            
            let lastCard = String(card)
            let cardRank = Int(lastCard.suffix(2)) ?? 0
            print(cardRank)
            
            // Scoring cards
            if cardRank == 1 {
                if dealerScore < 11 {
                    dealerScore += 11
                } else if dealerScore >= 11 {
                    dealerScore += 1
                }
            } else if cardRank < 10 {
                dealerScore += cardRank
            } else if cardRank >= 10 {
                dealerScore += 10
            }
            
        }
        else {
                print("No more cards being dealt")
            }
        }
    
    // Function that restarts the game when clicked "NEXT ROUND"
    func restartGame () {
        turn = true
        cardsDealt = false
        
        playerHand = []
        playerCount = 0
        playerScore = 0
        playerWin = nil
        
        dealerHand = []
        dealerCount = 0
        dealerScore = 0
        
        myDeck = createDeck()
            
        addPlayerCard()
        addPlayerCard()
            
        addDealerCard()
        addDealerCard()
    }
    
    var body: some View {
        ZStack{
            Image("Background")
            
            VStack {
                // "BLACKJACK" title
                HStack{
                    Image(systemName: "b.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Image(systemName: "l.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Image(systemName: "a.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Image(systemName: "c.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Image(systemName: "k.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Image(systemName: "j.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Image(systemName: "a.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Image(systemName: "c.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Image(systemName: "k.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                .padding(20)
                    
                Text("Dealer's Hand")
                    .font(.title)
                    .fontWeight(.bold)
                    .fontDesign(.serif)
                
                // Horizontal stack of dealer's cards displayed
                HStack{
                    ForEach(dealerHand, id: \.self) { card in Image(card)
                            .resizable()
                            .frame(width: 83, height: 121)
                    }
                }
                
                // Displaying dealer's card scores
                Text("Dealer: \(dealerScore)")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .fontDesign(.serif)
                
                // Displaying dealer's total score every round
                Text("\(totalDealerScore)")
                    .frame(width: 40, height: 40)
                    .font(.title)
                    .fontWeight(.bold)
                    .fontDesign(.serif)
                    .foregroundStyle(.white)
                    .background(.black)
                    .cornerRadius(10)
                
                // Space for displaying text of who wins in a round
                if playerWin == false {
                    Text("❌ YOU LOSE ❌")
                        .font(.title2)
                        .fontWeight(.bold)
                        .fontDesign(.serif)
                        .foregroundStyle(.white)
                    
                } else if playerWin == true {
                    Text("✅ YOU WIN ✅")
                        .font(.title2)
                        .fontWeight(.bold)
                        .fontDesign(.serif)
                        .foregroundStyle(.white)
                    
                } else {
                    Text(" ")
                        .font(.title2)
                        .fontWeight(.bold)
                        .fontDesign(.serif)
                        .foregroundStyle(.white)
                }
                
                // "NEXT ROUND" button that is displayed only when it shows who won for the round
                if playerWin == true || playerWin == false {
                    Button(action: {
                        restartGame()
                    }, label: {
                        Text("NEXT ROUND")
                            .frame(width: 130, height: 35)
                            .font(.callout)
                            .fontDesign(.serif)
                            .fontWeight(.heavy)
                            .foregroundStyle(.black)
                            .background(.red)
                            .cornerRadius(30)
                    })
                } else {
                    Text(" ")
                        .frame(width: 130, height: 35)
                }
                
                Text("Player's Hand")
                    .font(.title)
                    .fontWeight(.bold)
                    .fontDesign(.serif)
                
                // Horizontal stack of player's cards displayed
                HStack {
                    ForEach(playerHand, id: \.self) { card in Image(card)
                            .resizable()
                            .frame(width: 83, height: 121)
                    }
                }
                
                // Displaying player's card scores
                Text("Player: \(playerScore)")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .fontDesign(.serif)
                
                // Displaying player's total score every round
                Text("\(totalPlayerScore)")
                    .frame(width: 40, height: 40)
                    .font(.title)
                    .fontWeight(.bold)
                    .fontDesign(.serif)
                    .foregroundStyle(.white)
                    .background(.black)
                    .cornerRadius(10)
                
                HStack{
                    
                    // HIT Button
                    Button(action: {
                        addPlayerCard()
                        
                        // Determining the winner for the round
                        if playerScore == 21 {
                            playerWin = true
                        } else if playerScore > 21 {
                            playerWin = false
                        }
                        
                        // Adding total scores
                        if playerWin == false {
                            totalDealerScore += 1
                        } else if playerWin == true {
                            totalPlayerScore += 1
                        }
                    }, label: {
                        HStack{
                            Text("HIT")
                                .frame(width: 130, height: 50)
                                .font(.title)
                                .fontDesign(.serif)
                                .fontWeight(.heavy)
                                .foregroundStyle(.black)
                                .background(.red)
                                .cornerRadius(30)
                                .padding(20)
                        }
                    })
                    
                    // STAY Button
                    Button(action: {
                        // While loop: dealer adds cards only when the condition of less than 16 points are met
                        while dealerScore <= 16 {
                            addDealerCard()
                        }
                        
                        // Determining the winner for the round
                        if dealerScore > 21 {
                            playerWin = true
                        } else if dealerScore == playerScore {
                            playerWin = false
                        } else if dealerScore > playerScore {
                            playerWin = false
                        } else if playerScore > dealerScore {
                            playerWin = true
                        }
                        
                        // Adding total scores
                        if playerWin == false {
                            totalDealerScore += 1
                        } else if playerWin == true {
                            totalPlayerScore += 1
                        }
                    }, label: {
                        HStack{
                            Text("STAY")
                                .frame(width: 130, height: 50)
                                .font(.title)
                                .fontDesign(.serif)
                                .fontWeight(.heavy)
                                .foregroundStyle(.black)
                                .background(.red)
                                .cornerRadius(30)
                                .padding(20)
                        }
                    })
                }
            }
            .padding()
            // Ace alert that pops up when player gets ace card
            .alert(isPresented: $aceAlert, content: {
                Alert(
                    title: Text("Ace Dealt"),
                    message: Text("Choose the value of ace"),
                    primaryButton: .default(Text("11 points"), action: {
                        playerScore += 11
                        if playerScore == 21 {
                            playerWin = true
                        }
                    }),
                    secondaryButton: .default(Text("1 point"), action: {
                        playerScore += 1
                    })
                )
            })
            
            // Creating a deck and drawing the first 2 cards for the player and dealer
            .onAppear {
                restartGame()
                
                // Automatic win at the beginning when conditions are met
                if playerScore == 21 {
                    playerWin = true
                }
                if dealerScore == 21 {
                    playerWin = false
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
