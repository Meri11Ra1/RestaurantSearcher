import { Controller } from "@hotwired/stimulus"

const options = {
  enableHighAccuracy: true,
  timeout: 5000,
  maximumAge: 10
}

const _updateDistanceValue = () => {
  console.log("updateDistanceValue")

  window.updateDistanceValue = function (value) {
    const distances = {
      1: "300m",
      2: "500m",
      3: "1000m",
      4: "2000m",
      5: "3000m",
    };
    document.getElementById("distance_display").value = distances[value];
  };
}

// views/search_conditions/index.html.erb: data-controller="geolocation"
export default class extends Controller {
  static values = { url: String }
  static targets = ["status"]
  static targets = ["slide"]

  index = 0;

  connect() {
    console.log("Geolocation controller connected")
    _updateDistanceValue();

    this.index = 0;
    this.showCurrentSlide();

    navigator.geolocation.getCurrentPosition(this.preSearchSuccess.bind(this), this.preSearchError(this), options);
  }

  search() {
    console.log("search")
    navigator.geolocation.getCurrentPosition(this.searchSuccess.bind(this), this.SearchError.bind(this), options);
  }
  
  preSearchSuccess(pos) {
    this.index = 1;
    this.showCurrentSlide();
  }

  searchSuccess(pos) {
    const coord = pos.coords;
    // リダイレクトとパラムの渡し方
    const radius = document.getElementById("radius_range").value;

    location.assign(`/results/?lat=${coord.latitude}&lng=${coord.longitude}&rad=${radius}`);
  }

  preSearchError(err) {
    console.warn(`ERROR(${err.code}): ${err.message}`);
  }

  SearchError(err) {
    console.warn(`ERROR(${err.code}): ${err.message}`);

    alert("位置情報の取得に失敗しました。\nブラウザの設定やネットワークの接続を確認してください。");
  }

  showCurrentSlide() {
    this.slideTargets.forEach((element, index) => {
      element.hidden = index !== this.index;
      console.log(element.hidden);
    });
  }
}

document.addEventListener("DOMContentLoaded", () => {
  _updateDistanceValue();
});