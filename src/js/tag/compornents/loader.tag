import RiotControl from 'riotcontrol';

import Action from '../../Action/Action';
import Store from '../../Store/Store';
import Constant from "../../Constant/Constant";

import loader from "../../class_loader";

<niltea-loader>
	<div class="loader" ref='loader'>
	</div>
	<script>
	// loader関係の処理がここに
	// 1.マウントと同時に'import loader'でclass Loaderのインスタンスを生成（して初期化する
	// コンテンツが読みこまれたらLoderを隠してLoadedを呼ぶ

	// Action経由でsetLoaderが呼ばれたらLoaderを再度アクティブにする

	const self = this;

	// コンテンツが読み込まれたときの処理
	const contentLoaded = Action.contentLoaded;
	const activateLoader = () => {
		// loaderをアクティブにする処理
		loader.activateLoader(contentLoaded);
	};

	self.on('mount', activateLoader )
	RiotControl.on(Constant.setLoader, activateLoader );
	</script>
	<style type="text/scss">
	</style>
</niltea-loader>