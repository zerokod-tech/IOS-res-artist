//
//  OnboardingView.swift
//  res-artist
//
//  Created by Roberta Marino on 01/05/23.
//

import SwiftUI

struct OnboardingView: View {
    // MARK: - PROPERTY
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset:CGFloat = 0
    @State private var isAnimating: Bool = false
    
    // MARK: - BODY
    var body: some View {
        ZStack{
            Color("ColorBlue")
                .ignoresSafeArea(.all,edges: .all)
            
            VStack (spacing: 20){
                //MARK: -HEADER
                
                Spacer()
                VStack(spacing:0){
                    
                
                Text("Share.")
                    .font(.system(size: 60))
                    .fontWeight(.heavy)
                    .foregroundColor(.yellow)
                    //.transition(.opacity)
                    
                Text("""
                    It's not how much we give but how much love we put into giving
                    """)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal,10)
                
            }//: HEADER
            .opacity(isAnimating ? 1 : 0)
            .offset(y: isAnimating ? 0 : -40)
            .animation(.easeOut(duration: 1), value: isAnimating)
        
            //MARK: - CENTER
            
            ZStack{
            

                CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                
                Image("character-1")
                    .resizable()
                    .scaledToFit()
                    
           
            
            }// CENTER
            
            
            Spacer()
   
            //MARK: - FOOTER
        
            ZStack{
                //VStack{
                    // 1.BACKGROUND (STATIC)
                Capsule()
                    .fill(Color.white.opacity(0.2))
                    
                Capsule()
                    .fill(Color.white.opacity(0.2))
                    .padding(8)
                
                    // 2.CALL-TO-ACTION (STATIC)
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                    
                    // 3.CAPSULE (DYNAMIC WIDTH)
                    
                    HStack{
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 80)
                        Spacer()
                    }
                   
                    
                    
                    
                    // 4.CIRCLE(DRAGGABLE)
                    
                    
                    HStack{
                        ZStack{
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                    }
                    
                    .foregroundColor(.white)
                    .frame(width:80, height: 80, alignment: .center)
                    .offset(x: buttonOffset)
                    .gesture (
                        DragGesture()
                            .onChanged{
                                gesture in
                                if gesture
                                    .translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                                    buttonOffset = gesture.translation.width
                                  }
                            }
                            .onEnded{ _ in
                                withAnimation(Animation.easeOut(duration: 0.4))
                                {
                                if buttonOffset > buttonWidth / 2 {
                                //Play sound
                                  
                                    playSound(sound: "chimeup", type: "mp3")
                                    
                                //END PlaySound
                                    
                                    buttonOffset = buttonWidth - 80
                                    isOnboardingViewActive = false
                                } else {
                                    buttonOffset = 0
                                }
                            }
                        }
                    )//:GESTURE
                    Spacer()
                }// HStack
            }//:FOOTER
                .frame(width: buttonWidth, height: 80, alignment: .center)
                     .padding()
                     .opacity(isAnimating ? 1 : 0)
                     .offset(y: isAnimating ? 0 : 40)
                     .animation(.easeOut(duration: 1), value: isAnimating)
                   } //: VSTACK
                 } //: ZSTACK
                    
            .onAppear(perform: {
                isAnimating = true
        })
            .preferredColorScheme(.dark)
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
