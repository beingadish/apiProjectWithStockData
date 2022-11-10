class StockData {
  String? ticker;
  int? queryCount;
  int? resultsCount;
  bool? adjusted;
  List<Results>? results;
  String? status;
  String? requestId;
  int? count;

  StockData(
      {this.ticker,
      this.queryCount,
      this.resultsCount,
      this.adjusted,
      this.results,
      this.status,
      this.requestId,
      this.count});

  StockData.fromJson(Map<String, dynamic> json) {
    ticker = json['ticker'];
    queryCount = json['queryCount'];
    resultsCount = json['resultsCount'];
    adjusted = json['adjusted'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
    status = json['status'];
    requestId = json['request_id'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ticker'] = ticker;
    data['queryCount'] = queryCount;
    data['resultsCount'] = resultsCount;
    data['adjusted'] = adjusted;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['request_id'] = requestId;
    data['count'] = count;
    return data;
  }
}

class Results {
  int? v;
  double? vw;
  double? o;
  double? c;
  double? h;
  double? l;
  int? t;
  int? n;

  Results({this.v, this.vw, this.o, this.c, this.h, this.l, this.t, this.n});

  Results.fromJson(Map<String, dynamic> json) {
    v = json['v'];
    vw = json['vw'];
    o = json['o'];
    c = json['c'];
    h = json['h'];
    l = json['l'];
    t = json['t'];
    n = json['n'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['v'] = v;
    data['vw'] = vw;
    data['o'] = o;
    data['c'] = c;
    data['h'] = h;
    data['l'] = l;
    data['t'] = t;
    data['n'] = n;
    return data;
  }
}
