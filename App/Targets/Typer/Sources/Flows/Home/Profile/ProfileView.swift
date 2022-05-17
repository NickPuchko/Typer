//
//  ProfileView.swift
//  Typography
//
//  Created by Николай Пучко on 27.11.2021.
//

import Firebase
import SwiftUI
import SwiftUIX
import SDWebImageSwiftUI

struct ProfileView: View {
	@EnvironmentObject var authState: AuthState

	var body: some View {
		ScrollView {
			VStack(spacing: 0.0) {
				VStack(spacing: 15.0) {
					switch authState.loginState {
					case .pending:
						ActivityIndicator()
					case .inited:
						Button(TyperStrings.Localizable.login) {
							Task {
								await authState.execute(action: .signIn)
							}
						}
					case let .loaded(user):
						if let user = user {
							WebImage(url: user.photoURL)
								.resizable()
								.squareFrame(sideLength: 84)
								.clipShape(Circle())
							Text(user.displayName ?? "")
								.font(.sfProDisplay(variant: .semibold, size: .headingL))
							Text(user.email ?? "")
								.font(.sfProDisplay(variant: .regular, size: .paragraph))
						} else {
							Button(TyperStrings.Localizable.login) {
								Task {
									await authState.execute(action: .signIn)
								}
							}
						}
					}
				}
				.padding(.bottom, 30.0)
				VStack(spacing: 15.0) {
					Button {
						//
					} label: {
						ProfileRowView(title: "Избранное")
					}
					.disabled(true)
					Button {
						//
					} label: {
						ProfileRowView(title: "История")
					}
					.disabled(true)
					Button {
						Task {
							await authState.execute(action: .signOut)
						}
					} label: {
						PinkBorderedButton(title: "Выйти")
					}
					.hidden(!authState.isSigned)
				}
				Spacer()
			}
			.padding()
			.navigationBarTitle("Профиль")
		}
		.background(
			TyperAsset.Assets.backgroundPrimary.color.modern.edgesIgnoringSafeArea(.all)
		)
	}
}

// struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(viewModel: .init(authenticator: StubAuthService()))
//    }
// }
