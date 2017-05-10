const path = require('path');
const webpack = require('webpack');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const DEBUG = !process.argv.includes('--release');
console.log(!process.argv.includes('--release'))
// postcss plugins
var cssimport = require('postcss-import');
var cssnested = require('postcss-nested');
var customProperties = require('postcss-custom-properties');
var autoprefixer = require('autoprefixer');

const plugins_js = [ new webpack.ProvidePlugin({
	riot: 'riot'
})
];
if(DEBUG){
	console.log('############################\n## Debug mode is enabled ##\n###########################');
} else {
	console.log('#############################\n## Release mode is enabled ##\n#############################');
	plugins_js.push(
		new webpack.optimize.UglifyJsPlugin({ compress: { screw_ie8: true, warnings: false } }),
		new webpack.optimize.AggressiveMergingPlugin()
		);
}

module.exports = [
{
	entry: {
		bundle: './src/js/app.js'
	},
	output: {
		path: path.join(__dirname + '/theme/js/'),
		filename: '[name].js'
	},
	module: {
		rules: [
		{
			test: /\.tag$/,
			exclude: /node_modules/,
			enforce: 'pre',
			use: 'riot-tag-loader'
		},
		{
			test: /\.js$|\.tag$/,
			exclude: /node_modules/,
			use: 'babel-loader'
		}
		]
	},
	resolve: {
		extensions: ['*', '.js', '.tag']
	},
	plugins: plugins_js
},
{
	entry: {
		style: './src/css/style.scss'
	},
	output: {
		path: path.join(__dirname + '/theme/css/'),
		filename: '[name].css'
	},
	module: {
		rules: [
		{
			test: /\.scss$/,
			exclude: /node_modules/,
			use: ExtractTextPlugin.extract({
				fallback: "style-loader",
				use: [
				{
					loader: "css-loader",
					options: {
						url: false,
						minimize: !DEBUG
					}
				},
				"sass-loader"
				]
			})
		}
		]
	},
	plugins: [
	new ExtractTextPlugin({
		filename: '[name].css'
	})
	],
}
];
