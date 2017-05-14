import RiotControl from 'riotcontrol';

import Action from '../../Action/Action';
import Store from '../../Store/Store';
<niltea-modal>
	<div class="modal" ref='modal'>
		<div class="modal_bg" ref='modalBg'>modal bg</div>
		<figure class="content" ref='content'></figure>
	</div>
	<script>
		const self = this;
		// posts以外に遷移したらunmountする
		const unMountSelf = () => {
			if(Store.current.currentPage === 'posts') return;
			self.unmount(true);
		}
		RiotControl.on(Store.ActionTypes.changedCurrent, unMountSelf );
		self.on('unmount', () => {
			RiotControl.off(Store.ActionTypes.changedCurrent, unMountSelf);
		});
	</script>
	<style type="text/scss">
		@import "../../../css/includes/mixin";
	</style>
</niltea-modal>