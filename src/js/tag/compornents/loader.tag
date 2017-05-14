import RiotControl from 'riotcontrol';

import Action from '../../Action/Action';
import Store from '../../Store/Store';
import Constant from "../../Constant/Constant";

import loader from "../../class_loader";

<niltea-loader>
	<div class="loader_container" ref='loader'>
		<figure class="logo"></figure>
		<div id="progressContainer"></div>
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
	const activateLoader = () => {
		// loaderをアクティブにする処理
		setTimeout(() => {self.refs.loader.classList.remove('disabled');}, 0);
		loader.activateLoader(contentLoaded);
	};

	// self.on('mount', activateLoader )
	RiotControl.on(Constant.setLoader, activateLoader );
	</script>
	<style type="text/scss">
		@import "../../../css/includes/mixin";
		.loader_container {
			position: fixed;
			left: 0;
			top: 0;
			width: 100%;
			height: 100%;
			z-index: 9999;
			background-color: #fff;
			.logo {
				@include txtHide;
				position: absolute;
				left: 0;
				right: 0;
				top: 0;
				bottom: 0;
				margin: auto;
				background: url(/images/nilgiri.png) no-repeat;
				width: 108px;
				height: 34px;
				display: block;
			}
			transition: 0s;
			&.disabled {
				transition: opacity 0.7s linear 0s, height 1s linear 0.3s;
				opacity: 0;
				height: 0;
			}
		}
	</style>
</niltea-loader>