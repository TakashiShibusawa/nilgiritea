import RiotControl from "riotcontrol"
import Constant from "../Constant/Constant"

const store = new class ContentStore{
	get blogInfo(){ return this._blogInfo; }
	get current(){ return this._current; }
	get content(){ return this._content; }
	get baseURL(){ return 'http://nilgiri-tea.net/'; }
	get title(){ return 'Nilgiri Tea'; }
	get twitterID(){ return 'niltea'; }

	constructor(){
		riot.observable(this);

		this._blogInfo = null;
		this._content = '';
		this._current = '';
		this._pageTitle = '';
		this.on(Constant.setBlogInfo,  this._setBlogInfo.bind(this));
		this.on(Constant.setCurrent,   this._setCurrent.bind(this));
		this.on(Constant.setContent,   this._setContent.bind(this));
		this.on(Constant.setPageTitle, this._setPageTitle.bind(this))
	}

	_setBlogInfo(action){
		const blogInfo = action(JSON.stringify(this._blogInfo));
		// もしinfoが変わっていればisChangedが立つのでデータを差し替えてtrigger
		if (!blogInfo.isChanged) return;
		this._blogInfo = blogInfo.data;
		RiotControl.trigger(this.ActionTypes.changedBlogInfo);
	}
	_setCurrent(action){
		// Actionから渡されたcurrent操作関数がactionへ代入される
		// それを用いてcurrentの内容を変更する
		this._current = action(this._current);
		// Storeの内容が変わったよー、というのをControlへ通知する（そして関係する動作を叩いてもらう
		RiotControl.trigger(this.ActionTypes.changedCurrent);
	}
	_setContent(contentAction){
		this._content = contentAction(this._content);
		RiotControl.trigger(this.ActionTypes.changed);
	}
	_setPageTitle(pageTitleAction){
		// ページ名の抽出
		const pageType = this._current.currentPage;
		const pageName = (pageType !== 'posts') ? pageType : this._content[0].title;
		const titleBody = (pageName === 'index') ? '' : `${pageName} | `;
		this._pageTitle = pageTitleAction(titleBody, this._blogInfo.title);
		RiotControl.trigger(this.ActionTypes.changedPageTitle);
	}
}();

store.ActionTypes = {
	changedBlogInfo: "changedBlogInfo",
	changed: "content_store_changed",
	changedCurrent: "changedCurrent",
	changedPageTitle: "changedPageTitle",
};
RiotControl.addStore(store);

export default store