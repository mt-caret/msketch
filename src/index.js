import './vendor/katex/katex.min.css';
import 'sanitize.css';
import './main.css';
const Elm = require('./App.elm');
const mountNode = document.getElementById('app');
const app = Elm.App.embed(mountNode);
