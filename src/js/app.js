// import utility
import util from './niltea_util.js';

// riot and tags
require('riot');
require('./tag/base.tag')
require('./tag/index.tag')
require('./tag/post.tag')
require('./tag/about.tag')
require('./tag/compornents/header.tag')
require('./tag/compornents/footer.tag')
require('./tag/compornents/raw.tag')
require('./tag/compornents/loader.tag')
require('./tag/compornents/modal.tag')

riot.mount('#wrapper', 'niltea-base');
