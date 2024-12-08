import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.element.style = "color: red;";
  }

//   handleSubmitStart() {
//     console.log("Turbo form submission started");
//   }

  clear() {
    console.log("Form reset");
    this.element.reset();
  }
}
