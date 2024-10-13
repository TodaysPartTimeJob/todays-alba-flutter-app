import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../exception/custom_exception.dart';
import '../../exception/error_code.dart';
import '../../model/api/login/login_request_model.dart';
import '../../model/api/signup/nickname_duplication_check_request_model.dart';
import '../../model/api/signup/signup_request_model.dart';
import '../../model/state/signup_state.dart';
import '../../model/state/sns_login_info_state.dart';
import '../../repository/auth/auth_repository.dart';
import '../../repository/auth/auth_repository_Impl.dart';
import 'sns_login_info_provider.dart';

final signupViewModelProvider =
StateNotifierProvider<SignupViewModel, SignupState>((ref) {
  final snsLoginInfo = ref.watch(snsLoginInfoProvider);
  final authRepository = ref.watch(authRepositoryImplProvider);

  return SignupViewModel(SignupState.init(), authRepository, snsLoginInfo);
});

class SignupViewModel extends StateNotifier<SignupState> {
  final AuthRepository authRepository;
  final SnsLoginInfoState snsLoginInfo;

  SignupViewModel(super.state,
      this.authRepository,
      this.snsLoginInfo,);

  void onNicknameChange(String value) {
    state = state.copyWith(
      nickname: state.nickname.copyWith(
        value: value,
        isValid: false,
        stateMessage: "",
      ),
    );
  }

  void onTapNicknameCheckButton() async {
    try {
      _validateNickname();
      var requestModel =
      NicknameDuplicationCheckRequestModel(nickname: state.nickname.value);
      await authRepository.checkNicknameDuplication(requestModel);
      _changeNicknameInputState(true, "사용가능한 닉네임입니다.");
    } on CustomException catch (e) {
      setNicknameErrorMessage(e);
    } catch (e) {
      _changeNicknameInputState(false, ErrorCode.UnknownError.message);
    }
  }

  void onEmailChange(String value) {
    try {
      _validateEmail(value);
      _changeEmailInput(value, true, "사용가능한 이메일입니다.");
    } on CustomException catch (e) {
      if (e.errorCode == ErrorCode.NotValidInputError) {
        _changeEmailInput(value, false, e.errorMessage);
      } else {
        _changeEmailInput(value, false, "일시적인 오류가 발생하였습니다.");
      }
    } catch (e) {
      _changeEmailInput(value, false, "일시적인 오류가 발생하였습니다.");
    }
  }

  void onWeightChange(String value) {
    try {
      _validateWeight(value);
      _changeWeightInput(value, true, "");
    } on CustomException catch (e) {
      if (e.errorCode == ErrorCode.NotValidInputError) {
        _changeWeightInput(value, false, e.errorMessage);
      } else {
        _changeWeightInput(value, false, "일시적인 오류가 발생하였습니다.");
      }
    } catch (e) {
      _changeEmailInput(value, false, "일시적인 오류가 발생하였습니다.");
    }
  }

  Future<bool> submitAdditionalInfo() async {
    if (!state.nickname.isValid) {
      _changeNicknameInputState(false, "닉네임 중복확인이 필요합니다.");
      false;
    }
    if (!state.email.isValid) {
      _changeEmailInput(state.email.value, false, "유효하지 않은 이메일입니다.");
      false;
    }
    if (!state.weight.isValid) {
      _changeWeightInput(state.weight.value, false, "유효하지 않은 몸무게 입니다.");
      false;
    }

    var requestModel = SignupRequestModel(
      snsType: snsLoginInfo.snsType!.name,
      accessToken: "Bearer ${snsLoginInfo.accessToken!}",
      nickname: state.nickname.value,
      email: state.email.value,
      weight: double.tryParse(state.weight.value)!,
    );

    await authRepository.signup(requestModel);

    print("회원가입 성공");
    var loginResponseModel = await authRepository.login(
      LoginRequestModel(
        snsType: snsLoginInfo.snsType!.name,
        accessToken: "Bearer ${snsLoginInfo.accessToken!}",
      ),
    );

    print(
        "accessToken: ${loginResponseModel.token
            .accessToken}, refreshToken: ${loginResponseModel.token
            .refreshToken}");

    await authRepository.saveToken(loginResponseModel.token.accessToken,
        loginResponseModel.token.refreshToken);

    return true;
  }

  void _validateNickname() {
    String nickname = state.nickname.value;

    if (nickname == "") {
      throw CustomException.message(
          ErrorCode.NotValidInputError, "닉네임의 길이는 2에서 20자 사이여야 합니다");
    }

    if (nickname.trim() != nickname) {
      throw CustomException.message(
          ErrorCode.NotValidInputError, "공백을 포함할 수 없습니다.");
    }

    if (nickname.length < 2 || nickname.length > 20) {
      throw CustomException.message(
          ErrorCode.NotValidInputError, "닉네임의 길이는 2에서 20자 사이여야 합니다");
    }
  }

  void _validateEmail(email) {
    final RegExp emailRegExp =
    RegExp(r'^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');

    if (email == "") {
      throw CustomException.message(
          ErrorCode.NotValidInputError, "이메일을 입력해주세요.");
    }

    if (email.trim() != email) {
      throw CustomException.message(
          ErrorCode.NotValidInputError, "공백을 포함할 수 없습니다.");
    }

    if (!emailRegExp.hasMatch(email)) {
      throw CustomException.message(
          ErrorCode.NotValidInputError, "유효하지않은 이메일 형식입니다.");
    }
  }

  void _validateWeight(String weight) {
    if (weight == "") {
      throw CustomException.message(
          ErrorCode.NotValidInputError, "몸무게를 입력해주세요.");
    }

    if (weight.trim() != weight) {
      throw CustomException.message(
          ErrorCode.NotValidInputError, "공백을 포함할 수 없습니다.");
    }

    if (!_isDouble(weight)) {
      throw CustomException.message(
          ErrorCode.NotValidInputError, "몸무게는 숫자만 가능합니다.");
    }

    double? weightDouble = double.tryParse(weight);
    if (weightDouble! < 0 || weightDouble > 200) {
      throw CustomException.message(
          ErrorCode.NotValidInputError, "몸무게는 0보다 크고 200보다 작아야합니다.");
    }
  }

  void _changeNicknameInputState(bool isValid, String stateMessage) {
    state = state.copyWith(
        nickname: state.nickname.copyWith(
          isValid: isValid,
          stateMessage: stateMessage,
        ));
  }

  void _changeEmailInput(String value, bool isValid, String stateMessage) {
    state = state.copyWith(
        email: state.email.copyWith(
          value: value,
          isValid: isValid,
          stateMessage: stateMessage,
        ));
  }

  void _changeWeightInput(String value, bool isValid, String stateMessage) {
    state = state.copyWith(
        weight: state.weight.copyWith(
          value: value,
          isValid: isValid,
          stateMessage: stateMessage,
        ));
  }

  bool _isDouble(String value) {
    final doubleValue = double.tryParse(value);
    return doubleValue != null;
  }

  void setNicknameErrorMessage(CustomException e) {
    if (e.errorCode == ErrorCode.DuplicatedNicknameError) {
      _changeNicknameInputState(
        false,
        ErrorCode.DuplicatedNicknameError.message,
      );

      return;
    }

    if (e.errorCode == ErrorCode.DuplicatedNicknameError) {
      _changeNicknameInputState(
        false,
        ErrorCode.DuplicatedNicknameError.message,
      );

      return;
    }

    if (e.errorCode == ErrorCode.NotValidInputError) {
      _changeNicknameInputState(
        false,
        e.errorMessage,
      );

      return;
    }

    if (e.errorCode == ErrorCode.NetworkConnectionError) {
      _changeNicknameInputState(
        false,
        ErrorCode.NetworkConnectionError.message,
      );

      return;
    }

    _changeNicknameInputState(false, ErrorCode.UnknownError.message);
    return;
  }
}
