import RiotControl from 'riotcontrol';

import Store from '../../Store/Store';
<niltea-footer>
	<footer class="footer">
		<nav class="navigation" if={currentPage === 'index'}>
			<a href="{PreviousPage}" class="previous">&lt; PREV</a>
			<span class="current_page">{PageNumber}</span>
			<virtual><a href="{URL}" class="previous">{PageNumber}</a></virtual>
			<a href="{NextPage}" class="next">NEXT &gt;</a>
		</nav>
		<div class="copyright">
			<a class="nilgiriLogo txtHide" href="/">Designed by Nilgiri Tea</a>
		</div>
	</footer>
	<script>
	const self = this;
	// Subscribes Store.onChanged
	RiotControl.on(Store.ActionTypes.changedCurrent, () => {
		self.currentPage = Store.current.currentPage;
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