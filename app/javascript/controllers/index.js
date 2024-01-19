import { application } from "./application";

import HelloController from "./hello_controller";
application.register("hello", HelloController);

import ClipboardController from "./clipboard_controller";
application.register("clipboard", ClipboardController);

import SlideShow from "./slideshow_controller";
application.register("slideshow", SlideShow);
