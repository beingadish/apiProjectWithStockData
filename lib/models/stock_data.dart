class StockData {
  String? _ticker;
  int? _queryCount;
  int? _resultsCount;
  bool? _adjusted;
  List<Results>? _results;
  String? _status;
  String? _requestId;
  int? _count;

  StockData(
      {String? ticker,
        int? queryCount,
        int? resultsCount,
        bool? adjusted,
        List<Results>? results,
        String? status,
        String? requestId,
        int? count}) {
    if (ticker != null) {
      _ticker = ticker;
    }
    if (queryCount != null) {
      _queryCount = queryCount;
    }
    if (resultsCount != null) {
      _resultsCount = resultsCount;
    }
    if (adjusted != null) {
      _adjusted = adjusted;
    }
    if (results != null) {
      _results = results;
    }
    if (status != null) {
      _status = status;
    }
    if (requestId != null) {
      this._requestId = requestId;
    }
    if (count != null) {
      this._count = count;
    }
  }

  String? get ticker => _ticker;
  set ticker(String? ticker) => _ticker = ticker;
  int? get queryCount => _queryCount;
  set queryCount(int? queryCount) => _queryCount = queryCount;
  int? get resultsCount => _resultsCount;
  set resultsCount(int? resultsCount) => _resultsCount = resultsCount;
  bool? get adjusted => _adjusted;
  set adjusted(bool? adjusted) => _adjusted = adjusted;
  List<Results>? get results => _results;
  set results(List<Results>? results) => _results = results;
  String? get status => _status;
  set status(String? status) => _status = status;
  String? get requestId => _requestId;
  set requestId(String? requestId) => _requestId = requestId;
  int? get count => _count;
  set count(int? count) => _count = count;

  StockData.fromJson(Map<String, dynamic> json) {
    _ticker = json['ticker'];
    _queryCount = json['queryCount'];
    _resultsCount = json['resultsCount'];
    _adjusted = json['adjusted'];
    if (json['results'] != null) {
      _results = <Results>[];
      json['results'].forEach((v) {
        _results!.add(new Results.fromJson(v));
      });
    }
    _status = json['status'];
    _requestId = json['request_id'];
    _count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticker'] = this._ticker;
    data['queryCount'] = this._queryCount;
    data['resultsCount'] = this._resultsCount;
    data['adjusted'] = this._adjusted;
    if (this._results != null) {
      data['results'] = this._results!.map((v) => v.toJson()).toList();
    }
    data['status'] = this._status;
    data['request_id'] = this._requestId;
    data['count'] = this._count;
    return data;
  }
}

class Results {
  double? _v;
  double? _vw;
  double? _o;
  double? _c;
  double? _h;
  double? _l;
  int? _t;
  int? _n;

  Results(
      {double? v,
        double? vw,
        double? o,
        double? c,
        double? h,
        double? l,
        int? t,
        int? n}) {
    if (v != null) {
      this._v = v;
    }
    if (vw != null) {
      this._vw = vw;
    }
    if (o != null) {
      this._o = o;
    }
    if (c != null) {
      this._c = c;
    }
    if (h != null) {
      this._h = h;
    }
    if (l != null) {
      this._l = l;
    }
    if (t != null) {
      this._t = t;
    }
    if (n != null) {
      this._n = n;
    }
  }

  double? get v => _v;
  set v(double? v) => _v = v;
  double? get vw => _vw;
  set vw(double? vw) => _vw = vw;
  double? get o => _o;
  set o(double? o) => _o = o;
  double? get c => _c;
  set c(double? c) => _c = c;
  double? get h => _h;
  set h(double? h) => _h = h;
  double? get l => _l;
  set l(double? l) => _l = l;
  int? get t => _t;
  set t(int? t) => _t = t;
  int? get n => _n;
  set n(int? n) => _n = n;

  Results.fromJson(Map<String, dynamic> json) {
    _v = json['v'];
    _vw = json['vw'];
    _o = json['o'];
    _c = json['c'];
    _h = json['h'];
    _l = json['l'];
    _t = json['t'];
    _n = json['n'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['v'] = _v;
    data['vw'] = _vw;
    data['o'] = _o;
    data['c'] = _c;
    data['h'] = _h;
    data['l'] = _l;
    data['t'] = _t;
    data['n'] = _n;
    return data;
  }
}
