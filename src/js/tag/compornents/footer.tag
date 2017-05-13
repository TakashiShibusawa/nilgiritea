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
			<a class="nilgiriLogo txtHide" href="http://www.nilgiri-tea.net/">Designed by Nilgiri Tea</a>
			<div class="Shibusawa">&copy; Nilgiri Tea</div>
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
</niltea-footer>