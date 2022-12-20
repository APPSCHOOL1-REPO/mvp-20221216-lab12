//
//  Home.swift
//  KavasoftCalender
//
//  Created by 전근섭 on 2022/12/17.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var loginSignupStore: LoginSignupStore
    @State private var currentDate: Date = Date()
    @State private var bottomSheetActivated: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Image("moveoLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                
                Spacer()
                
                NavigationLink {
                    // TODO: - 설정페이지 연결(알림에 대한 설정을 추가하게 된다면 사용 아니면 삭제)
                } label: {
                    Image(systemName: "gearshape.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.mainColor)
                    
                }
                
                NavigationLink {
                    AddPostView()
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.mainColor)
                }
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    // custom date picker
                    CustomDatePicker(currentDate: $currentDate)
                }
                .padding(.vertical)
            }
            .safeAreaInset(edge: .bottom) {
                Button {
                    bottomSheetActivated.toggle()
                    // profileView에서 fatal error 났을 때 임시방편 로그아웃 메서드
                    loginSignupStore.logout()
                } label: {
                    Text("일정 추가")
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color.orange, in: Capsule())
                }
                .padding(.horizontal)
                .padding(.top)
                .foregroundColor(.white)
                .background(.ultraThinMaterial)
                .sheet(isPresented: $bottomSheetActivated) {
                    AddSchedule()
                        .presentationDetents([.medium, .large])
                }
            }
        }
        .onAppear{
            loginSignupStore.fetchUser()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(SampleTask())
            .environmentObject(LoginSignupStore())
    }
}
