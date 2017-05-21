import RiotControl from 'riotcontrol';

import Store from '../../Store/Store';
import Constant from "../../Constant/Constant";
<niltea-footer>
	<footer class="footer">
		<nav class="navigation" if={pagingEnabled}>
			<a if={hasPrev} href="{prevPage}" class="prev">&lt; PREV</a>
			<a each={page in prevPagenations} href="{page.href}" class="num">{page.num}</a>
			<span class="current">{page}</span>
			<a each={page in nextPagenations} href="{page.href}" class="num">{page.num}</a>
			<a if={hasNext} href="{nextPage}" class="next">NEXT &gt;</a>
		</nav>
		<div class="copyright">
			<a class="nilgiriLogo txtHide" href="/">Designed by Nilgiri Tea</a>
		</div>
	</footer>
	<script>
	const self = this;
	self.pagingEnabled = false;
	self.hasPrev = false;
	self.hasNext = false;
	self.prevPage = null;
	self.nextPage = null;
	self.maxPage = null;

	const modPagenation = () => {
		const pagenations = 2;
		// index以外の時はpagingを消してreturn
		if(Store.current.currentPage !== 'index') {
			self.pagingEnabled = false;
			self.update();
			return;
		}
		if(!self.maxPage) return;

		self.pagingEnabled = true;
		self.page = parseInt(Store.current.page, 10);

		if (self.page >= 2) {
			self.hasPrev = true;
			self.prevPage = (self.page === 2) ? '/' : '/index/' + (self.page - 1);
			self.prevPagenations = (() => {
				const pagenation = [
					{href: '/', num: 1},
				];
				if (self.page === 2 ) return pagenation;
				for (let i = self.page - pagenations, l = self.page - 1; i <= l; i += 1) {
					if (i === 1) continue;
					pagenation.push({href: '/index/' + i, num: i});
				}
				return pagenation;
			})();
		} else {
			self.hasPrev = false;
			self.prevPagenations = null;
		}

		if (self.page < self.maxPage) {
			self.hasNext = true;
			self.nextPage = '/index/' + (self.page + 1);
			self.nextPagenations = (() => {
				const pagenation = [
					{href: '/index/' + self.maxPage, num: self.maxPage},
				];
				// 最終のひとつ手前であれば最終ページだけ出して帰る
				if (self.page === self.maxPage - 1 ) return pagenation;
				for (let i = self.page + pagenations, l = self.page + 1; i >= l; i -= 1) {
					if (i === self.maxPage) continue;
					pagenation.unshift({href: '/index/' + i, num: i});
				}
				return pagenation;
			})();
		} else {
			self.hasNext = false;
			self.nextPagenations = null;
		}
		self.update();
	}
	// Subscribes Store.onChanged
	RiotControl.on(Store.ActionTypes.changedBlogInfo, () => {
		self.maxPage = Math.ceil(Store.blogInfo.posts / Constant.indexPostLimit);
		modPagenation();
	});
	RiotControl.on(Store.ActionTypes.changedCurrent, modPagenation );
	</script>
</niltea-footer>