var address = '北海道稚内市';

(function() {
  // Geolocation APIに対応していなかったら処理を止める
  if ("geolocation" in navigator == false) return;

  var btn = $('.btn-googlemap');

  // リンクを書き換える
  var setLink = function(lat, lng) {
    // Google mapの経路検索のURLを作る
    var link = 'https://www.google.co.jp/maps/dir/' + lat + ',' + lng + '/' + encodeURIComponent(address) + '/';

    btn.attr('href', link);
  };

  navigator.geolocation.getCurrentPosition(function(position) {
    var coords = position.coords;
    setLink(coords.latitude, coords.longitude);

  }, function(error) {
    // Geolocation APIが使えない場合とかエラーが起きたときの処理

  }, {
    timeout: 10000,	// 取得タイムアウトまでの時間（ミリ秒）
    maximumAge: 10000,	// 位置情報の有効期限（ミリ秒）
    enableHighAccuracy: true	// より精度の高い位置情報を取得するか（true／false）
  });
});