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
		let json = null,
		article = null,
		flg_result = false;
		switch (type) {
			case 'info':
			// ページリストを取得し、forEachで回す
			json = await tumblrAPI.fetchAPI(Constant.getEndPoint(type));
			json.forEach(page => {
				// リソースIDが指定の物と違ったら飛ばす
				if (page.resource_id !== resource) return false;

				// 記事が見つかったときの処理
				flg_result = true;
				// 記事を整形してtriggerする
				article = this._loadArticle(page);
			});
			break;

			default:
			//posts の取得
			json = await tumblrAPI.fetchAPI(Constant.getEndPoint({type, query}));
			// jsonがきちんと返ってきたら成功フラグをtrueにする
			if (json) {
				article = this._loadArticle(json.response.posts);
				flg_result = true;
			}
			break;
		}
		// 成功フラグが立っていればcontrolに通知する
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
		if (flg_result) RiotControl.trigger(Constant.setContent, (content) => article);
		return flg_result;
	}
	_loadArticle (posts_fetched) {
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
		const {current: currentPage, id = null} = currentInfo;
		RiotControl.trigger(Constant.setCurrent, (currentObj) => { return {currentPage, id} });
	}
	resetCounter(){
		RiotControl.trigger(Constant.resetCounter, (count)=> 0);
	}
}

// export default AppAction
export default appAction