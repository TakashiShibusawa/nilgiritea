import RiotControl from 'riotcontrol';

import Action from '../../Action/Action';
import Store from '../../Store/Store';
import Constant from "../../Constant/Constant";
<niltea-modal>
	<div class="modal" ref='modal'>
		<div class="modal_bg" ref='modalBg' onclick={this.hideModal}></div>
		<figure class="content" ref='content'></figure>
	</div>
	<script>
		const self = this;

		const openModal = event => {
			event.preventDefault();
			const el = (event.target.nodeName === 'IMG') ? event.target.parentNode : event.target;
			const href = el.href;

			const fig = self.refs.content;
			fig.style.backgroundImage = `url('${href}')`;

		}
		const hideModal = () => {
			console.log('hide')
		}
		self.hideModal = hideModal;
		RiotControl.on(Constant.openModal, openModal );

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
		.modal {
			display: none;
			position: fixed;
			left: 0;
			top: 0;
			width: 50%;
			height: 50%;
		}
		.modal_bg {
			position: absolute;
			left: 0;
			top: 0;
			width: 100%;
			height: 100%;
			background-color: rgba(#000, 0.8);
		}
		.content {
			position: absolute;
			left: 0;
			right: 0;
			top: 0;
			bottom: 0;
			margin: auto;
			width: 80%;
			height: 90%;
			background: center center no-repeat;
			background-size: contain;
		}
	</style>
</niltea-modal>