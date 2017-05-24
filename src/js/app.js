// import utility
import util from './niltea_util.js';

// riot and tags
require('riot');
require('./tag/base.tag')
// ヘッダー/フッター
require('./tag/compornents/header.tag')
require('./tag/compornents/footer.tag')
// 部品
require('./tag/compornents/raw.tag')
require('./tag/compornents/loader.tag')
require('./tag/compornents/modal.tag')
// 各ページ
require('./tag/index.tag')
require('./tag/post.tag')
require('./tag/about.tag')

// GA
require('./tag/compornents/analytics.tag');

riot.mount('#wrapper', 'niltea-base');
