class Crop {
  String? cropName;
  List<String>? varieties;
  String? weatherRequired;
  String? growingPeriod;
  String? suitableSoil;
  List<String>? majorProducers;

  Crop(
      {this.cropName,
        this.varieties,
        this.weatherRequired,
        this.growingPeriod,
        this.suitableSoil,
        this.majorProducers});

  Crop.fromJson(Map<String, dynamic> json) {
    cropName = json['crop_name'];
    if (json['varieties'] != null) {
      varieties = List<String>.from(json['varieties']);
    }
    weatherRequired = json['weather_required'];
    growingPeriod = json['growing_period'];
    suitableSoil = json['suitable_soil'];
    if (json['major_producers'] != null) {
      majorProducers = List<String>.from(json['major_producers']);
    }
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['crop_name'] = cropName;
    data['varieties'] = varieties;
    data['weather_required'] = weatherRequired;
    data['growing_period'] = growingPeriod;
    data['suitable_soil'] = suitableSoil;
    data['major_producers'] = majorProducers;
    return data;
  }
}
