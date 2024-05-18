enum StatusActivity {
  /// * [String] location = LatLng
  /// * [String] serfie = Upload [String] fsavename key reponse
  checkin('/api.checkin'),

  /// * [String] location = LatLng
  /// * [String] serfie = Upload [String] fsavename key reponse
  checkout('/api.checkout'),

  /// * [String] location = LatLng
  /// * [String] izindate
  /// * [String] alasan
  izin('/api.izin'),

  /// * [String] location = LatLng\
  /// * [String] cutidate
  cuti('/api.cuti');

  final String endpoint;

  const StatusActivity(this.endpoint);
}
