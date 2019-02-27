import 'package:bloc/bloc.dart';
import 'package:mobile_ecommerce/bloc/authentication/authentication_event.dart';
import 'package:mobile_ecommerce/bloc/authentication/authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthEvent, AuthenticationState> {
  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationState currentState, AuthEvent event) async* {
   
  }
}