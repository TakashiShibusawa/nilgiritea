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
		<img if={figure} src={figure} class="figure" ref='figure' onclick={this.hideModal} />
		<nav class="close lsf" ref="close" onclick={this.hideModal}>close</nav>
	</div>
	<script>
		const self = this;
		const wrapper = document.getElementById('wrapper');
		self.figure = null;

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
			self.figure = href;
			self.update();
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
			position: fixed;
			z-index: 9000;
			left: 50%;
			top: 50%;
			width: 0;
			height: 4px;
			transition: 0.4s $easeOut 0.3s, height 0.3s $easeOut 0s, top 0.3s $easeOut 0s;
			&.shown {
				width: 100%;
				height: 100%;
				left: 0%;
				top: 0;
				transition: 0.4s $easeOut, height 0.5s $easeOut 0.5s, top 0.5s $easeOut 0.5s;
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
			max-width: 95%;
			max-height: 95%;
			opacity: 0;
		}
		.shown .figure {
			transition: 0s 0.5s;
			opacity: 1;
		}
		.close {
			position: absolute;
			left: 20px;
			top: 2.5%;
			font-size: 3.0em;
			color: #fff;
			opacity: 0;
			cursor: pointer;
			line-height: 1;
		}
		.shown .close {
			transition: 0.2s 1.1s;
			opacity: 1;
		}
	</style>
</niltea-modal>