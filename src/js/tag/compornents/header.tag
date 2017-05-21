import RiotControl from 'riotcontrol';
import Store from '../../Store/Store';
import Constant from "../../Constant/Constant";
<niltea-header>
	<header class="mainHeader">
		<h1>
			<a href="/" class="home">
				<span class="mainTitle">{title}</span>
				<span class="siteDescription"><raw content="{description}" /></span>
			</a>
		</h1>
		<nav class="hamburger lsf" onclick={hamburger}>menu</nav>
		<nav class="gnav clearfix" id="gnav" ref='gnav'>
			<ul>
				<li class="gnav_item about" title="about"><a href="/about">about</a></li>
				<li class="gnav_item pixiv" title="Pixiv"><a href="https://pixiv.me/kicky" target="_blank">pixiv</a></li>
				<li class="gnav_item twitter lsf" title="Twitter"><a href="https://twitter.com/niltea" target="_blank">twitter</a></li>
				<li class="gnav_item github lsf" title="GitHub"><a href="https://github.com/niltea" target="_blank">github</a></li>
			</ul>
		</nav>
	</header>
	<script>
		const self = this;
		self.title = '';
		self.description = '';
		// Subscribes Store.changedBlogInfo
		RiotControl.on(Store.ActionTypes.changedBlogInfo, () => {
			const blogInfo = Store.blogInfo;
			self.title = blogInfo.title;
			self.description = blogInfo.description;
			self.update();
		});

		// gnavの表示・非表示を切り替える関数
		// opt:String | Boolean [true | false | 'toggle']
		// 	true:  強制的に表示する
		// 	false: 強制的に隠す
		// 	'toggle': (default) 表示のトグル
		let isGnavShown = false;
		const gnavDisp = opt => {
			const shown = 'narrow_shown';
			if (opt.constructor !== Boolean) {
				// true/false以外が渡されたときは現在の表示状況に応じてオプションを設定
				opt = (isGnavShown === true)? false : true;
			}
			if (opt === true) {
				self.refs.gnav.classList.add(shown);
				isGnavShown = true;
			} else {
				self.refs.gnav.classList.remove(shown);
				isGnavShown = false;
			}
			// last
			self.update();
		};
		// カレントが切り替わったときはgnavを強制非表示とする
		RiotControl.on(Store.ActionTypes.changedCurrent, () => gnavDisp(false)　);
		self.hamburger = () => gnavDisp('toggle')
		// スクロールしたのであればgnav非表示
		let prevTop = 0;
		const scrollHandler = scrollTop => {
			if (!isGnavShown) {
				prevTop = scrollTop;
				return;
			}
			const scrollDiff = Math.abs(scrollTop - prevTop);
			if (scrollDiff >= 6) gnavDisp(false);
			prevTop = scrollTop;
		};
		self.on('mount', () => {
			RiotControl.on(Constant.onScroll, scrollHandler);
		})
		self.on('unmount', () => {
			RiotControl.off(Constant.onScroll, scrollHandler);
		})
	</script>
	<style type="text/scss">
		@import "../../../css/includes/mixin";
		$easeIn:  cubic-bezier(0.6, 0.04, 0.98, 0.335);
		$easeOut: cubic-bezier(0.075, 0.82, 0.165, 1);
		.mainHeader {
			position: fixed;
			left: 0;
			top: 20px;
			padding-left: 20px;
			z-index: 500;
			width: 100%;
			display: flex;
			justify-content: flex-start;
		}
		a {
			text-decoration: none;
			color: #000;
		}
		h1 {
			a {
				display: inline-block;
			}
			.mainTitle {
				display: block;
				font-size: 3.8em;
				line-height: 1em;
				letter-spacing: 0.05em;
			}
			.siteDescription {
				display: block;
				margin-top: 0.6em;
				font-weight: 400;
				font-size: 1.0em;
				line-height: 1em;
				letter-spacing: 0.15em;
			}
		}
		.gnav {
			padding-left: 40px;
			padding-top: 15px;
			ul {
				display: flex;
				justify-content: flex-start;
			}
		}
		.gnav_item {
			display: inline-block;
			line-height: 1em;
			font-size: 1.8em;
			+ .gnav_item {
				margin-left: 1.2em;
			}
			&:first-child { margin: 0; }
			&.active,
			&:hover {
				/*border-color: #2d73a8;*/
			}
			a {
				font-size: 1em;
			}
			&.lsf a {
				font-size: 1.2em;
			}
		}
		.hamburger {
			display: none;
		}
		@media screen and (min-width: 37.5em) {
			.pixiv a {
				width: 18px;
				height: 18px;
				display: block;
				background: url(/images/pixiv.svg) 0 0 no-repeat;
				background-size: 18px;
				@include txtHide;
			}
		}
		@media screen and (max-width: 37.5em) {
			.mainHeader {
				display: block;
				padding: 0;
			}
			h1, .gnav {
				float: none;
			}
			h1 {
				display: flex;
				justify-content: center;
				text-align: center;
			}

			.hamburger {
				display: block;
				position: absolute;
				right: 2vw;
				top: 8px;
				width: 1em;
				font-size: 2.8em;
				line-height: 1em;
				cursor: pointer;
			}
			.gnav {
				position: fixed;
				right: 0;
				top: 65px;
				padding: 0;
				width: 20%;
				transform: translateX(20vw);
				transition: 0.5s $easeOut;
				&.narrow_shown {
					transition: 0.2s $easeIn;
					transform: none;
				}
				ul {
					flex-direction: column;
					padding-bottom: 20px;
				}
				.gnav_item {
					margin: 10px 0 0;
					text-align: right;
					&:first-child {
						margin-top: 0;
					}
					a {
						display: inline-block;
						padding: 5px 20px 5px 10px;
						/*border-radius: 2px 0 0 2px;*/
					}
				}
			}
		}
	</style>
</niltea-header>