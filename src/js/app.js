// import utility
import util from './niltea_util.js';

// riot and tags
require('riot');
require('./tag/Index.tag')

const RiotControl  = require('riotcontrol');

document.addEventListener('DOMContentLoaded', () => {
	riot.mount('#wrapper', 'niltea-page');
});
