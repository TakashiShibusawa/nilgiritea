import RiotControl from 'riotcontrol';

import Store from '../../Store/Store';
import Constant from "../../Constant/Constant";
<niltea-footer>
	<footer class="footer">
		<nav class="navigation" if={pagingEnabled}>
			<a if={hasPrev} href="{prevPage}" class="prev">&lt; PREV</a>
			<span class="current_page">{page}</span>
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
		if(Store.current.currentPage !== 'index') return;

		self.pagingEnabled = true;
		self.page = parseInt(Store.current.page, 10);

		if (self.page >= 2) {
			self.hasPrev = true;
			self.prevPage = (self.page === 2) ? '/' : '/index/' + (self.page - 1);
		} else {
			self.hasPrev = false;
		}

		if (self.page < self.maxPage) {
			self.hasNext = true;
			self.nextPage = '/index/' + (self.page + 1);
		} else {
			self.hasNext = false;
		}
		self.update();
	}
	// Subscribes Store.onChanged
	RiotControl.on(Store.ActionTypes.changedBlogInfo, () => {
		self.maxPage = Math.ceil(Store.blogInfo.posts / Constant.indexPostLimit);
		modPagenation();
	});
	RiotControl.on(Store.ActionTypes.changedCurrent, () => {
		self.pagingEnabled = false;
		modPagenation();
	});
	</script>
	<style type="text/scss">
	/* navigation */
	.navigation {
		width: 100%;
		margin: 0 auto;
		padding: 20px 0 0;
		overflow: hidden;
		text-align: center;
		.count { float: left; }
		.links {
			width: 100%;
			text-align: center;
		}
		&.permalink .links { overflow: hidden; }
		.links a,
		.links span {
			display: inline-block;
			padding: 6px 9px;
			border-radius: 4px;
			text-decoration: none;
			font-size: 1.4em;
			color: #424b54;
		}
		.links a:hover { background-color: #ddd; }
	}
	.current_page { background-color: #ddd; }
	</style>
</niltea-footer>