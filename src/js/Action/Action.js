import RiotControl from "riotcontrol"
import Constant from "../Constant/Constant";
import fetchJsonp from 'jsonp-promise';
import util from '../niltea_util.js';

const fetchParams = {mode: 'cors'};

const tumblrAPI = new class TumblrAPI {
	async fetchAPI (uri) {
		if(typeof uri !== 'string') return false;
		const res = await fetchJsonp(uri, {param: 'jsonp'}).promise;
		return (res.meta.status >= 200 && res.meta.status < 300) ? res : false;
	}
};

const appAction = new class AppAction {
	// コンテンツのロードを行い、Storeに通知を行うメソッド
	// isIncrementがtrueであれば追加読み込み
	async loadContent({type, query, isIncrement = false, current, page = null, id = null, hasInfo}){
		const article = (hasInfo) ? null : await this.fetchContent({type, query});
		if (article) RiotControl.trigger(Constant.setContent, (content) => (isIncrement) ? content.concat(article) : article );
		this.setCurrent({currentPage : current, page, id});
	}
	// コンテンツのロードを行う
	async fetchContent({type, query}){
		//APIを叩いてjson取得してもらう。正常に帰ってこなかったらreturn
		const json = await tumblrAPI.fetchAPI(Constant.getEndPoint({type, query}));
		if (!json) return false;

		// 正常取得時の動作
		RiotControl.trigger(Constant.setBlogInfo, (oldInfo) => {
			let isChanged = false;
			let data = null;
			// 取得してきたblogInfoをObjectに突っ込む
			const fetchedBlogInfo = JSON.stringify(json.response.blog);
			if (oldInfo !== fetchedBlogInfo) {
				isChanged = true;
				data = json.response.blog;
			}
			return {isChanged, data};
		});

		// 記事データの整形を行い、返ってきたデータがあればそれをreturn
		const article = this._formatArticle(json.response.posts);
		return article || false;
	}
	_formatArticle (posts_fetched) {
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
		const title = post.caption.match(/<h2>.+<\/h2>/);
		const title_stripped = title ? title[0].replace(/<\/?h2>/g, '') : 'no title';
		return {
			id      : post.id,
			caption : post.caption,
			title   : title_stripped,
			slug    : post.slug,
			date    : post.timestamp * 1000,
			type    : post.type,
			url     : post.short_url,
			photos  : post.photos,
			photoset_layout : post.photoset_layout,
			reblog_key : post.reblog_key,
			note_count: post.note_count,
		};
	}
	setCurrent(currentInfo) {
		const {currentPage, id = 'null', page = 'null'} = currentInfo;
		RiotControl.trigger(Constant.setCurrent, (currentObj) => { return {currentPage, id, page} });

		this.setPageTitle();
	}
	setPageTitle () {
		RiotControl.trigger(Constant.setPageTitle, (title_body, blogTitle) => document.title = title_body + blogTitle);
	}
	showLoader () {
		RiotControl.trigger(Constant.showLoader, null);
	}
	setLoader () {
		RiotControl.trigger(Constant.setLoader, null);
	}
	contentLoaded () {
		RiotControl.trigger(Constant.contentLoaded, null);
	}
	openModal (event) {
		RiotControl.trigger(Constant.openModal, event);
	}
	callInfScr() {
		RiotControl.trigger(Constant.callInfScr, null);
	}
}

// export default AppAction
export default appAction