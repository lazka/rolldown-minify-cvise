# Rolldown minify test case

Context: https://github.com/rolldown/rolldown/issues/6458

## Setup

* (optional, since already included in this example) Generate a self contained
index.js by bundling the following in some way:

```js
import '@webcomponents/scoped-custom-element-registry';
class MyGreeting extends HTMLElement {}
customElements.define('my-greeting', MyGreeting);
const greeting = document.createElement('my-greeting');
document.body.appendChild(greeting);
```

* `sudo apt install cvise` (https://repology.org/project/cvise/versions)
* `npm install` - to install playwright and rolldown
* `./node_modules/.bin/playwright install chromium` - to install the browser
* run `./test.sh` to check if things work, should exit with 0

## Reduce & Result

* `cvise --not-c test.sh index.js` and wait a few minutes until it's done.

After it's done see `index.js` for the reduced test case.
