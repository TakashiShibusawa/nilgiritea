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

		const showModal = target => {
			self.refs.modal.classList.add('shown');
			// 本体のロック
			self.scrollY = util.getScrollTop();
			wrapper.style.position = 'fixed';
			wrapper.style.top = self.scrollY * -1 + 'px';
		};
		const openModal = event => {
			log('openModal is called.')
			event.preventDefault();

			// ターゲット画像を抽出
			const target = event.target.style.backgroundImage.match(/https?:\/+[\d\w\.\/]*/)[0];
			log('openModal: target acquired', target)

			// figureにURLをセットしてupdateすることでimgを表示させる
			self.figure = target;
			self.update();
			// モーダル表示処理を呼ぶ
			showModal(target);
		}

		const hideModal = () => {
			log('hideModal is called.')
			self.refs.modal.classList.remove('shown');
			// 本体のロック解除
			wrapper.style.position = '';
			wrapper.style.top = '';
			util.setScrollTop(self.scrollY);
		}
		self.hideModal = hideModal;
		RiotControl.on(Constant.openModal, openModal);

		// posts以外に遷移したらunmountする
		const unMountSelf = () => {
			if(Store.current.currentPage === 'posts') return;
			self.unmount(true);
		}
		RiotControl.on(Store.ActionTypes.changedCurrent, unMountSelf );
		self.on('unmount', () => {
			RiotControl.off(Store.ActionTypes.changedCurrent, unMountSelf);
			RiotControl.off(Constant.openModal, openModal);
		});
	</script>
</niltea-modal>