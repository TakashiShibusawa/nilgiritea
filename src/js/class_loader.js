export default new class Loader {
	constructor (callback) {
		document.addEventListener('DOMContentLoaded', () => {
			console.log('Loader constructor called');
			const images = this.loadElements();
			console.log(images)
			this.imgLoadWatcher({
				images: images,
				onComplete: () => {
					if (!callback) return;
					callback();
				},
				onEach: (expectedCount, receivedCount) => {
					const p = Math.round(receivedCount / expectedCount * 100);
					// progress.textContent = p;
				}
			});
		});
	}
	activateLoader () {
		console.log('Loader activateLoader called');
	}
	loadElements () {
		console.log('Loader loadElements called');
		const images = [];
		const bgi = "background-image";
		const targets_img = [].slice.call(document.getElementsByTagName('img'));
		console.log(targets_img);
		targets_img.forEach((el) => {
			let _src = el.getAttribute('src');
			// srcが空なら中断
			if (!_src) return;
			images.push(_src);
		});
		const targets_bgi = [].slice.call(document.getElementsByClassName('loader_bgi'));
		targets_bgi.forEach((el) => {
			// elementが空なら中断
			if (!el) return;
			// 背景画像を取得し、取得できなければ中断
			let _src = el.style[bgi] || getComputedStyle(el, "")[bgi];
			if (!_src || _src == 'none') return;

			// 画像を取り出す
			_src = _src.replace(/^url\(|\"|\)$/g, '');
			images.push(_src);
		});
		return images;
	}
	imgLoadWatcher (setting) {
		// if images is empty, go to loaded Function
		if(setting.images === null || setting.images.length <= 0) {
			if (setting.onComplete) {
				setTimeout(() => {
					setting.onComplete();
				}, 500);
			}
			return;
		}
		//画像の数だけloadListenerが呼ばれたらcallbackが呼ばれる;
		const loadListener = ((expectedCount, onEach, onComplete) => {
			let receivedCount = 0;
			return (e) => {
				// remove temporary image
				const tgt = e.target;
				if (tgt) tgt.parentNode.removeChild(tgt);

				receivedCount++;
				if (onEach) onEach(expectedCount, receivedCount);
				if(receivedCount === expectedCount) {
					if (onComplete) {
						setTimeout(() => { onComplete(); }, 500);
					}
				}
			};
		})(setting.images.length, setting.onEach, setting.onComplete);

		[].forEach.call(setting.images, url => {
			let img = new Image;
			document.body.appendChild(img);
			img.width = img.height = 1;
			img.onload = loadListener.bind(img);
			img.src = url;
			img = null;
		});
	};
}