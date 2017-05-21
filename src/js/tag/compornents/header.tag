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
		<nav class="hamburger lsf" ref='hamburger' onclick={hamburger}>menu</nav>
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
				self.refs.hamburger.textContent = 'close';
				isGnavShown = true;
			} else {
				self.refs.gnav.classList.remove(shown);
				self.refs.hamburger.textContent = 'menu';
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
</niltea-header>