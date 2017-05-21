import RiotControl from 'riotcontrol';

import Action from '../../Action/Action';
import Store from '../../Store/Store';
import Constant from "../../Constant/Constant";

import loader from "../../class_loader";

<niltea-loader>
	<div class="loader_container" ref='loader'>
		<div class="loadingMsg">
			<figure class="logo"></figure>
			<span class="progress">loading Contents...<span id="progressContainer">0%</span></span>
		</div>
	</div>
	<script>
	// loader関係の処理がここに
	// 1.マウントと同時に'import loader'でclass Loaderのインスタンスを生成（して初期化する
	// ※初期状態ではloaderは表示されている
	// Action経由でsetLoaderが呼ばれたらLoaderをアクティブにする
	// コンテンツが読みこまれたらLoderを隠し（処理を呼んで）Action.contentLoadedを叩く

	// Action経由でsetLoaderが呼ばれたらLoaderを再度表示する

	const self = this;

	// コンテンツが読み込まれたときの処理
	// Action.contentLoadedを叩く
	const contentLoaded = () => {
		setTimeout(() => {self.refs.loader.classList.add('disabled');}, 0);
		// loader.contentLoaded();
		Action.contentLoaded();
	};
	const showLoader = () => {
		setTimeout(() => {self.refs.loader.classList.remove('disabled');}, 0);
	}
	const activateLoader = () => {
		// loaderをアクティブにする処理
		loader.activateLoader(contentLoaded);
	};

	// self.on('mount', activateLoader )
	RiotControl.on(Constant.showLoader, showLoader );
	RiotControl.on(Constant.setLoader, activateLoader );
	</script>
</niltea-loader>