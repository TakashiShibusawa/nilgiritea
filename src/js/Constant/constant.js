const constant = new class Constant{
	constructor () {
		this.api = {
			API_KEY  : "api_key=Rak7GXrKPBB6uuTODOgQL3hPLpnTAf2b2IoUjAUoBd8yLoCthg",
			APIRoot : "http://api.tumblr.com/v2/blog/nilgiritea.tumblr.com/",
		}
		this.action = {
			fetchArticle: "fetchArticle",
		}
		// action types
		this.setBlogInfo= 'setBlogInfo';
		this.setCurrent = 'setCurrent';
		this.setContent = 'setContent';
	}

	_getApiKey(){
		return this.api.API_KEY;
	}
	getEndPoint (type, resource) {
		const id = resource ? `&id=${resource}` : '';
		const endPoint = this.api.APIRoot + type + '?' + this._getApiKey() + id;
		return endPoint;
	}

}

export default constant;
