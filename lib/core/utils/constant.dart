class Constant{
  static const _uRL="https://newsapi.org/v2/everything?q=tesla&from=2021-11-18&sortBy=publishedAt";
  static const _apiKey="apiKey=a4e8fb83e9c54be4881a2dd529b87238";
  String endPoint(String endPoint){
   late String url;
    if(endPoint.isNotEmpty){
      url = _uRL+"&"+_apiKey+endPoint;
    }else{
      url = _uRL+"&"+_apiKey;
    }
    return url;
  }
}
