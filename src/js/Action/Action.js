import RiotControl from "riotcontrol"
import ActionTypes from "../Constant/Constant"
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
	async loadContent(type, resource = ''){
		let json = null,
		article = null,
		flg_result = false;
		switch (type) {
			case 'pages':
			// pageの時はリソース指定必須とする。なければfailフラグの返却
			if (!resource) return flg_result;
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
			json = await tumblrAPI.fetchAPI(Constant.getEndPoint(type, resource));
			// jsonがきちんと返ってきたら成功フラグをtrueにする
			if (json) {
				article = this._loadArticle(json.response.posts);
				flg_result = true;
			}
			break;
		}
		// 成功フラグが立っていればcontrolに通知する
		if (flg_result) RiotControl.trigger(ActionTypes.setContent, (content) => article);
		return flg_result;
	}
	_loadArticle (articles) {
		const articleList = [];
		// 単一記事の場合はObjectが渡されてくるはずなので、forEachで回すためにArrayに突っ込む
		if (Object.prototype.toString.call(articles) !== '[object Array]') {
			articles = [articles];
		}
		articles.forEach((article) => {
			const articleData = this._getArticleData(article);
			articleList.push(articleData);
		});
		return articleList;
	}
	_getArticleData (post) {
		return {
			id      : post.id,
			caption : post.caption,
			title   : post.slug,
			date    : post.timestamp,
			type    : post.type,
			url     : post.short_url,
			photos  : post.photos,
		};
	}
	decrementCounter(){
		RiotControl.trigger(ActionTypes.decrementCounter, (count)=> count-1);
	}
	resetCounter(){
		RiotControl.trigger(ActionTypes.resetCounter, (count)=> 0);
	}
}

// export default AppAction
export default appAction