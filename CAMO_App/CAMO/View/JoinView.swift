//
//  JoinView.swift
//  CAMO
//
//  Created by 장세희 on 2022/11/07.
//

import SwiftUI

struct JoinView: View {
    
    @State private var inputName: String = ""
    @State private var inputEmail: String = ""
    @State private var inputPW: String = ""
    @State private var inputPWChk: String = ""
    @State private var inputPhone: String = ""
    
    @State private var textMsg = true
    @State private var textWrongPW = true
    @State private var popAlert = false
    
    
    // 이메일 정규식
    let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]{1,}+\\.[A-Z0-9a-z~!@#$%^&*]{1,20}$"
    
    // 전화번호 정규식
    let phonePattern = "^0([0-9]{1,2})([0-9]{3,4})([0-9]{4})$"
    
    var body: some View {
        VStack(alignment: .leading) {
            Rectangle().frame(height:0)
            Text("회원가입").font(.system(size: 24)).fontWeight(.black)
            Spacer().frame(height: 70)
            VStack(alignment: .leading) {
                
                Text("이름").font(.system(size:16)).foregroundColor(Color("mainColor"))
                UnderlineTextFieldView(text: $inputName, textField: nameView, placeholder: "이름을 입력하세요")
                    .padding(.bottom, 32)
                
                Text("이메일").font(.system(size:16)).foregroundColor(Color("mainColor"))
                UnderlineTextFieldView(text: $inputEmail, textField: emailView, placeholder: "이메일을 입력하세요")
                    .padding(.bottom, 32)
                
                Text("전화번호").font(.system(size:16)).foregroundColor(Color("mainColor"))
                UnderlineTextFieldView(text: $inputPhone, textField: phoneView, placeholder: "전화번호를 입력하세요 ('-' 제외)").padding(.bottom, 32)
                
                Text("비밀번호").font(.system(size:16)).foregroundColor(Color("mainColor"))
                UnderlineTextFieldView(text: $inputPW, textField: passwordView, placeholder: "비밀번호를 입력하세요")
                    .padding(.bottom, 32)
                
                Text("비밀번호 확인").font(.system(size:16)).foregroundColor(Color("mainColor"))
                UnderlineTextFieldView(text: $inputPWChk, textField: passwordChkView, placeholder: "비밀번호를 다시 입력하세요")
                }
            
            VStack {
                if (!textWrongPW) {
                    Text("비밀번호가 서로 일치하지 않습니다").font(.system(size: 12))
                        .foregroundColor(Color("redPointColor"))
                }

            }
            .padding(.bottom, 70)
            
            Button {
                if (inputPW == inputPWChk && inputPW != "") {
                    // 잘 입력된 경우
                    // 입력값을 서버로 보내고 화면 전환
                    popAlert = true
                } else if (inputPW == "" || inputPWChk == "" || inputName == ""
                           || inputEmail == "" || inputPhone == "") {
                    // 하나라도 빈칸이 있는 경우
                    textMsg = false
                } else if (inputPWChk != inputPW) {
                    // 비밀번호가 일치하지 않는 경우
                    textWrongPW = false
                }
                
            } label: {
                Text("회원가입")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
            }
            .padding(.vertical, 20)
            .background(Color("mainColor"))
            .cornerRadius(16)
            
            .alert(isPresented: $popAlert) {
                Alert(title: Text("회원가입 완료!"), message: nil,
                                  dismissButton: .default(Text("확인")))
            }
            
            if (!textMsg) {
                Text("모든 칸을 필수로 입력해주세요").font(.system(size: 12))
                    .foregroundColor(Color("redPointColor"))
            }
            
            
        }
        .padding(30)
    }
}





struct JoinView_Previews: PreviewProvider {
    static var previews: some View {
        JoinView()
    }
}

extension JoinView {

    private var nameView: some View {
         TextField("", text: $inputName)
            .font(.system(size:16))
            .foregroundColor(.black)
            .autocapitalization(.none)
    }
    
     private var emailView: some View {
          TextField("", text: $inputEmail)
             .font(.system(size:16))
             .foregroundColor(.black)
            .keyboardType(.emailAddress)
            .autocapitalization(.none)
     }

     private var passwordView: some View {
          SecureField("", text: $inputPW)
             .font(.system(size:16))
             .foregroundColor(.black)
            .autocapitalization(.none)
     }
    
    private var passwordChkView: some View {
         SecureField("", text: $inputPWChk)
            .font(.system(size:16))
            .foregroundColor(.black)
            .autocapitalization(.none)
    }
    
    private var phoneView: some View {
         TextField("", text: $inputPhone)
            .font(.system(size:16))
            .foregroundColor(.black)
            .autocapitalization(.none)
    }
}






// MARK: - UnderlineTextField
struct UnderlineTextFieldView<TextFieldView>: View where TextFieldView: View {

     @Binding var text: String
     let textField: TextFieldView
     let placeholder: String

     
     var body: some View {
          HStack {
               underlineTextFieldView
          }
     }
}

// MARK: - Setups
extension UnderlineTextFieldView {
     
     private var underlineTextFieldView: some View {
          VStack {
               ZStack(alignment: .leading) {
                    if text.isEmpty {
                         placeholderView
                    }

               textField
                    .padding(.trailing, 16)
               }

               underlineView
          }
     }

     private var placeholderView: some View {
          Text(placeholder)
             .font(.system(size: 16))
             .foregroundColor(.black)
               .opacity(0.5)
     }

     private var underlineView: some View {
          Rectangle().frame(height: 1)
               .foregroundColor(Color("mainColor"))
               .padding(.trailing, 16)
     }
}
