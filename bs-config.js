const historyApiFallback = require('connect-history-api-fallback');

module.exports = { "injectChanges": true,
	"files": [ "./**/*.{html,htm,css,js}" ],
	"watchOptions": { "ignored": "node_modules" },
	"server": { "baseDir": "./theme/"},
	"middleware": [historyApiFallback()],
};
