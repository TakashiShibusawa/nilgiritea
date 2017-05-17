const constant = new class Constant{
	constructor () {
		this.api = {
			API_KEY  : "api_key=Rak7GXrKPBB6uuTODOgQL3hPLpnTAf2b2IoUjAUoBd8yLoCthg",
			APIRoot : "http://api.tumblr.com/v2/blog/nilgiritea.tumblr.com/",
		}
		// indexで取得する記事数
		this.indexPostLimit = 5;
		this.action = {
			fetchArticle: "fetchArticle",
		}
		// action types
		this.setBlogInfo   = 'setBlogInfo';
		this.setCurrent    = 'setCurrent';
		this.setContent    = 'setContent';
		this.addContent    = 'addContent';
		this.showLoader    = 'showLoader';
		this.setLoader     = 'setLoader';
		this.contentLoaded = 'contentLoaded';
		this.openModal     = 'openModal';
		this.callInfScr    = 'callInfScr';
	}

	_getApiKey(){
		return this.api.API_KEY;
	}
	_setQS (query) {
		if (!query) return '';
		let queryString = '';
		Object.keys(query).forEach(key => (query[key]) ? queryString += `&${key}=${query[key]}` : queryString );
		return queryString;
	}
	getEndPoint ({type = 'post', query}) {
		const queryString = this._setQS(query);
		const endPoint = this.api.APIRoot + type + '?' + this._getApiKey() + queryString;
		return endPoint;
	}

}

export default constant;
