import { Controller } from "stimulus";

export default class extends Controller {
  connect() {
    console.log("Sessions controller connected");
  }

  successfulLogin() {
    console.log("Successful login");
  }
}
