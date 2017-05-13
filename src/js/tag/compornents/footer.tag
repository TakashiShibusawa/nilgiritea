import RiotControl from 'riotcontrol';

import Store from '../../Store/Store';
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
	// Subscribes Store.onChanged
	RiotControl.on(Store.ActionTypes.changedCurrent, () => {
		self.pagingEnabled = false;
		const current = Store.current;
		if(current.currentPage === 'index') {
			self.pagingEnabled = true;
			self.page = parseInt(current.page, 10);
			const lastPage = 2;

			if (self.page >= 2) {
				self.hasPrev = true;
				self.prevPage = '/index/' + (self.page - 1);
			} else {
				self.hasPrev = false;
			}

			if (self.page < lastPage) {
				self.hasNext = true;
				self.nextPage = '/index/' + (self.page + 1);
			} else {
				self.hasNext = false;
			}
		}

		self.update();
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