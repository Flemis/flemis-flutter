//import 'package:cpfcnpj/cpfcnpj.dart';

import 'package:cpfcnpj/cpfcnpj.dart';

class Validators {
  static String accentedCharacters =
      "áéíóúýÁÉÍÓÚÝâêîôûÂÊÎÔÛãñõÃÑÕäëïöüÿÄËÏÖÜŸçÇ";

  // static String defaultRegex =
  //     "[a-zA-Z0-9" + accentedCharacters + "|.|#|@|\$|\\-|\_|+|&|~]";

  static String defaultRegex = r"^[A-Za-z0-9- ]+$";
  static String defaultWithoutRegex = "[a-zA-Z0-9]";

  static String isValidTextInput(String input, [String? errorMessage]) {
    if (input.isEmpty) {
      return 'Por favor, preencha o campo acima.';
    }

    return '';
  }

  static String isValidTextInputName(String input) {
    if (input.isEmpty) {
      return "Por favor, informe o nome.";
    }

    return '';
  }

  static String isValidCardNumber(String input) {
    if (input.isEmpty || (input.length < 16)) {
      return "Por favor, informe o número do cartão.";
    }

    return '';
  }

  static String isValidApelidoInput(String apelido) {
    if (apelido.isEmpty) {
      return 'Por favor, preencha o apelido.';
    }
    return '';
  }

  // CPF VALIDATOR
  static String isValidCPF(String cpf) {
    // Validar CPF
    if (!CPF.isValid(cpf) && cpf.isNotEmpty) {
      return 'CPF inválido.';
    } else {
      return '';
    }
  }

  static String isValidCPFForce(String cpf) {
    // Validar CPF
    if (cpf.isEmpty) {
      return 'Por favor, informe o CPF';
    } else if (!CPF.isValid(cpf)) {
      return 'Cpf inváido';
    }
    return '';
  }

  // Email VALIDATOR
  static String isValidEmail(String email, [String errorMessage = ""]) {
    if (email.isEmpty) {
      return 'Por favor, informe o e-mail.';
    }

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(email.trim())) {
      return 'E-mail inválido.';
    }
    return '';
  }

  static String isValidaPhoneNumber(String phone) {
    if (phone.isEmpty) {
      return '';
    }

    Pattern pattern = r'^\(\d{2,}\) \d{4,}\-\d{4}$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(phone.trim())) {
      return 'Celular inválido.';
    }
    return '';
  }

  static String isValidaRGNumber(String rg) {
    if (rg.isEmpty) {
      return '';
    }

    if (rg.isNotEmpty && rg.length < 7) {
      return 'RG inválido.';
    }
    return '';
  }

  static String isValidPassword(String password, [String errorMessage = ""]) {
    if (password.isEmpty) {
      return 'Por favor, informe a senha.';
    }

    if (password.length < 5 || password.length > 40) {
      return 'Por favor, a senha deve possuir de 5 a 40 caracteres.';
    }

    return '';
  }

  static String isValidConfirmPassword(int one, int two) {
    return '';
  }

  static String validCharacter(String text, [String? errorMessage]) {
    if (text == '') {
      return '';
    }

    if (text.length < 3 || text.length > 20) {
      return 'Por favor, este campo deve possuir de 3 a 20 caracteres.';
    }

    final validCharacters = RegExp(r'^[a-zA-Z0-9]+$');
    if (!validCharacters.hasMatch(text)) {
      return 'Não é permitido o uso de caracateres especiais.';
    }

    return '';
  }

  static String isValidDate(String input) {
    try {
      if (input.isEmpty) {
        return '';
      }

      final parsedDate = input.replaceAll('/', '');
      final day = parsedDate.substring(0, 2);
      final month = parsedDate.substring(2, 4);
      final year = parsedDate.substring(4, 8);
      final formattedDate = year + month + day;

      final date = DateTime.parse(formattedDate);
      final originalFormatString = _toOriginalFormatString(date);
      if (parsedDate != originalFormatString) {
        return 'Por favor, informe uma data válida.';
      }
      return '';
    } catch (e) {
      return 'Por favor, informe uma data válida.';
    }
  }

  static String _toOriginalFormatString(DateTime dateTime) {
    final y = dateTime.year.toString().padLeft(4, '0');
    final m = dateTime.month.toString().padLeft(2, '0');
    final d = dateTime.day.toString().padLeft(2, '0');
    return "$d$m$y";
  }
}
