import RiotControl from 'riotcontrol';

import Action from '../Action/Action';
import Store from '../Store/Store';
import Constant from "../Constant/Constant";

import util from '../niltea_util.js';
<niltea-index>
	<section id="article_list" class='post index' ref='articleList'>
		<niltea-list-item articleList={articleList}></niltea-list-item>
	</section>
	<script>
		const self = this;
		self.articleList = {};
		self.cords = {};

		const getElmSize = e => {
			requestAnimationFrame(() => {
				const scrollTop = ~~(util.getScrollTop());
				const winHeight = ~~(window.innerHeight);

				// postの最下部の位置を取得する
				// x = 最上部位置 + 要素高さ - 下パディング
				// ただし最上部位置はscroll位置によって変化するのでscrollTopを足す
				const postRect = self.refs.articleList.getBoundingClientRect();
				const postTop = postRect.top;
				const postHeight = postRect.height;
				const postPB = parseInt(getComputedStyle(self.refs.articleList).paddingBottom, 10);
				const postBtm = ~~(postTop + postHeight - postPB + scrollTop);

				// 一つ目の記事の高さを取る
				const firstArticle = self.refs.articleList.getElementsByClassName('post_item')[0];
				const articleHeight = firstArticle.getBoundingClientRect().height;

				// トリガ位置の計算
				// post最下部から記事高さ(を元にした数値)を引く
				self.cords.triggerPos = postBtm - articleHeight;
				self.cords.winHeight = winHeight;
			});
		};

		// infscrの設定
		self.is_infScrActive = false;
		const scrollHandler = scrollTop => {
			if (self.is_infScrActive) return;
			// ウィンドウ下部の座標
			const winBtmPos = scrollTop + self.cords.winHeight;

			// トリガ位置より下にスクロールした
			if (winBtmPos >= self.cords.triggerPos) {
				// call infScr
				Action.callInfScr();
			}
		};

		// 追加コンテンツを読み込む動作
		const fetchAddContnt = () => {
			// infScrが動いてたら処理せずreturn
			if (self.is_infScrActive) return;
			// infScrが動いてるフラグを立てる
			self.is_infScrActive = true;
			// 現在のページ数を取得
			const currentPage = Store.current.page;
			// 次ページ番号を計算
			const nextPage = currentPage + 1;
			// ページあたりの最大投稿数を聞いてくる
			// 最終ページの判断、offset値の計算に使います
			const limit = Constant.indexPostLimit;
			// 最終ページ番号を計算
			const maxPage = Math.ceil(Store.blogInfo.posts / limit);
			// 次ページの取得
			Action.loadContent({isIncrement: true, type: 'posts', query: {limit, offset: limit * currentPage}, page: nextPage});

			// 最終ページかどうか判断してページのインクリメント
			if (nextPage <= maxPage) {
				// Action.setCurrent({current: 'index', page: nextPage});
			}
			// 最終ページを読み込んだときの処理
			if (currentPage >= maxPage) {
				RiotControl.off(Constant.onScroll, scrollHandler);
				// TODO:下のページネーションを消す処理の追加
			}
		};
		// Subscribes callInfScr
		RiotControl.on(Constant.callInfScr, fetchAddContnt);
		// Subscribes Store.onChanged
		RiotControl.on(Store.ActionTypes.changed, () => {
			self.articleList = Store.content;
			self.update();
		});
		// after content loaded by loader
		const contentLoadHandler = () => {
			getElmSize();
			self.is_infScrActive = false;
		};
		RiotControl.on(Constant.contentLoaded, contentLoadHandler);

		self.on('updated', () => {
			Action.setLoader();
		});
		self.on('before-mount', Action.showLoader );
		self.on('mount', () => {
			RiotControl.on(Constant.onScroll, scrollHandler);
			window.addEventListener('resize', getElmSize);
		});

		self.on('unmount', () => {
			RiotControl.off(Store.ActionTypes.changed);
			RiotControl.off(Constant.contentLoaded, contentLoadHandler);
			RiotControl.off(Constant.callInfScr, fetchAddContnt);
			RiotControl.off(Constant.onScroll, scrollHandler);
			window.removeEventListener('resize', getElmSize);
		});
	</script>
</niltea-index>

<niltea-list-item>
	<article each={item in opts.articlelist} style='background-image: url({item.photos ? item.photos[0].original_size.url : null});' class='post_item loader_bgi'>
		<a class="post_item_link" href='/post/{item.id}'>
			<div class="post_item_info">
				<h3 class='post_item_title'><raw content={item.title} /></h3>
				<section class="post_item_meta">
					<span class="post_item_date">{this.formatDate(item.date)}</span><br><span class="post_item_notes">{item.note_count} notes</span>
				</section>
			</div>
		</a>
		<div class="post_item_action">
			<a href="http://tumblr.com/reblog/{item.id}/{item.reblog_key}/" class="like lsf" target='_blank'>heart</a>
			<a href="http://tumblr.com/reblog/{item.id}/{item.reblog_key}/" class="reblog lsf" target='_blank'>retweet</a>
		</div>
	</article>
	<script>
		const self = this;
		self.formatDate = date => {
			const _date = new Date(date);
			return `${_date.getFullYear()} / ${_date.getMonth() + 1} / ${_date.getDate()}`;
		}
	</script>
</niltea-list-item>

<niltea-index-list-lead>
	<span class='line' each={content in lines}>{content}</span>
	<script>
		let content = opts.content;
		content = content.replace('</p>', '').replace('<p>', '');
		this.lines = content.split('<br />');
	</script>
</niltea-index-list-lead>