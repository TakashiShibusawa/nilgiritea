const debug = true;
const log = (!debug) ? arg => null : (...arg) => console.log(...arg);

import RiotControl from 'riotcontrol';

import Action from '../../Action/Action';
import Store from '../../Store/Store';
import Constant from "../../Constant/Constant";

import util from '../../niltea_util.js';
<niltea-modal>
	<div class="modal" ref='modal'>
		<div class="modal_bg" ref='modalBg' onclick={this.hideModal}></div>
		<figure class="figure" ref='figure'></figure>
	</div>
	<script>
		const self = this;
		const wrapper = document.getElementById('wrapper');

		const showModal = href => {
			self.refs.modal.classList.add('shown');
			// 本体のロック
			self.scrollY = util.getScrollTop();
			wrapper.style.position = 'fixed';
			wrapper.style.top = self.scrollY * -1 + 'px';
		};
		const openModal = event => {
			event.preventDefault();
			// const el = (event.target.nodeName === 'IMG') ? event.target.parentNode : event.target;
			// log(el)
			const href = event.target.style.backgroundImage.match(/https?:\/+[\d\w\.\/]*/)[0];
			log('openModal', href)
			const fig = self.refs.figure;
			fig.style.backgroundImage = `url('${href}')`;
			showModal(href);
		}

		const hideModal = () => {
			console.log('hide')
			self.refs.modal.classList.remove('shown');
			// 本体のロック解除
			wrapper.style.position = '';
			wrapper.style.top = '';
			util.setScrollTop(self.scrollY);
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
			z-index: 9000;
			left: 0;
			top: 0;
			width: 100%;
			height: 0;
			&.shown {
				display: block;
				height: 100%;
			}
		}
		.modal_bg {
			position: absolute;
			left: 0;
			top: 0;
			width: 100%;
			height: 100%;
			background-color: rgba(#000, 0.8);
		}
		.figure {
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