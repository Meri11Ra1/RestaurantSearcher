import { Controller } from "@hotwired/stimulus"

const options = {
  enableHighAccuracy: true,
  timeout: 5000,
  maximumAge: 0
}

// views/search_conditions/index.html.erb: data-controller="geolocation"
export default class extends Controller {
  static values = { url: String }

  connect() {
    console.log("Geolocation controller connected")
  }

  search() {
    navigator.geolocation.getCurrentPosition(this.success.bind(this), this.error, options);
  }
  
  success(pos) {
    const coord = pos.coords;
    // リダイレクトとパラムの渡し方
    location.assign(`/search_conditions/index/?place=${coord.latitude},${coord.longitude}`)
  }

  error(err) {
    console.warn(`ERROR(${err.code}): ${err.message}`);
  }
}