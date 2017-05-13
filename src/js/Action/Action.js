import RiotControl from "riotcontrol"
import Constant from "../Constant/Constant";
import "whatwg-fetch";
import util from '../niltea_util.js';

const fetchParams = {mode: 'cors'};

const tumblrAPI = new class TumblrAPI {
	async fetchAPI (uri) {
		if(typeof uri !== 'string') return false;
		const res = await fetch(uri, fetchParams);
		const json = await res.json();
		return (res.status >= 200 && res.status < 300) ? json : false;
	}
};

const appAction = new class AppAction {
	async loadContent({type, query}){
		let article = null;

		//json の取得
		const json = await tumblrAPI.fetchAPI(Constant.getEndPoint({type, query}));
		if (!json) return false;

		// 正常取得時の動作
		RiotControl.trigger(Constant.setBlogInfo, (oldInfo) => {
			let isChanged = false;
			let data = null;
			const fetchedBlogInfo = JSON.stringify(json.response.blog);
			if (oldInfo !== fetchedBlogInfo) {
				isChanged = true;
				data = json.response.blog;
			}
			return {isChanged, data};
		});

		article = this._loadArticle(json.response.posts);
		if (article) RiotControl.trigger(Constant.setContent, (content) => article);
		return true;
	}
	_loadArticle (posts_fetched) {
		// postsがないとき(infoを取得したとき)
		if (!posts_fetched) return null;
		const posts_formatted = [];
		posts_fetched.forEach((article) => {
			const articleData = this._getArticleData(article);
			posts_formatted.push(articleData);
		});
		return posts_formatted;
	}
	_getArticleData (post) {
		return {
			id      : post.id,
			caption : post.caption,
			title   : post.slug,
			slug    : post.slug,
			date    : post.timestamp,
			type    : post.type,
			url     : post.short_url,
			photos  : post.photos,
			photoset_layout : post.photoset_layout,
			reblog_key : post.reblog_key
		};
	}
	setCurrent(currentInfo) {
		const {current: currentPage, id = null, page = null} = currentInfo;
		RiotControl.trigger(Constant.setCurrent, (currentObj) => { return {currentPage, id, page} });
	}
	resetCounter(){
		RiotControl.trigger(Constant.resetCounter, (count)=> 0);
	}
}

// export default AppAction
export default appAction