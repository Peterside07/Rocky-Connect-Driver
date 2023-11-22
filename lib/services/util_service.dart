

class UtilService {
  static String statusCodeToMessage(int? code) {
    switch (code) {
      case 400:
        return 'Bad request';
      case 500:
        return 'Internal server error';
    }
    return 'Something went wrong';
  }

}
