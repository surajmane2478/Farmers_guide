class MarketPrice {
  String? state;
  String? crop;
  double? price;

  MarketPrice({this.state, this.crop, this.price});

  MarketPrice.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    crop = json['crop'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['crop'] = this.crop;
    data['price'] = this.price;
    return data;
  }
}
