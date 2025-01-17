// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "controllers"
import "@hotwired/turbo-rails"
import { Application } from "@hotwired/stimulus";
import GeolocationController from "./controllers/geolocation_controller";

const application = Application.start();
application.register("geolocation", GeolocationController);