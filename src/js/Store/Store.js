import RiotControl from "riotcontrol"
import Constant from "../Constant/Constant"

const store = new class ContentStore{
	get current(){ return this._currentPage; }
	get content(){ return this._content; }
	get baseURL(){ return 'http://nilgiri-tea.net/'; }
	get title(){ return 'Nilgiri Tea'; }
	get twitterID(){ return 'niltea'; }

	constructor(){
		riot.observable(this);

		this._content = '';
		this._currentPage = '';
		this._pageTitle = '';

		this.on(Constant.setCurrent, this._setCurrent.bind(this));
		this.on(Constant.setContent, this._setContent.bind(this));
	}

	_setCurrent(currentAction){
		// Actionから渡されたcurrent操作関数がcurrentActionへ代入される
		// それを用いてcurrentの内容を変更する
		this._currentPage = currentAction(this._content);
		// Storeの内容が変わったよー、というのをControlへ通知する（そして関係する動作を叩いてもらう
		RiotControl.trigger(this.ActionTypes.changed);
	}
	_setContent(contentAction){
		this._content = contentAction(this._content);
		RiotControl.trigger(this.ActionTypes.changed);
	}
	_setpageTitle(pageTitleAction){
		this._pageTitle = pageTitleAction(this._pageTitle);
		RiotControl.trigger(this.ActionTypes.changed);
	}
}();

store.ActionTypes = { changed: "content_store_changed" };
RiotControl.addStore(store);

export default store