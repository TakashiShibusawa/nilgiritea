import RiotControl from 'riotcontrol';

import Action from '../Action/Action';
import Store from '../Store/Store';
<niltea-post>
	<article class="post post-single">
		<h2 class="post_title"><raw content='{title}' /></h2>
		<!-- Photo -->
		<section class="photo" if={photos} ref='photo'>
			<!-- single -->
			<div if={!isPhotoSet} class="photo_rowContainer layout_itemCount-1" ref='rowContainer'>
				<a class="photo_item photo_item-single" if={!isPhotoSet} each={photos} href='{original_size.url}' onclick={openModal}>
					<figure class="photo_item_image" style="background-image: url({alt_sizes[0].url})" ref='photoItem'></figure>
				</a>
			</div>
			<!-- set -->
			<div if={isPhotoSet} each={row in photoset} class="photo_rowContainer layout_itemCount-{row.length}" ref='rowContainer'>
				<a class="photo_item photo_item-set" each={row} href='{original_size.url}' onclick={openModal}>
					<figure class="photo_item_image" style="background-image: url({alt_sizes[0].url})" ref='photoItem'></figure>
				</a>
			</div>
		</section>
		<section class='post_text' if={caption}><raw content='{caption}' /></section>
		<div class="post_meta">
			<a href="http://tumblr.com/reblog/{id}/{reblog_key}/" class="reblog lsf" target='_blank'>retweet</a>
			<a href="http://tumblr.com/reblog/{id}/{reblog_key}/" class="like lsf" target='_blank'>{heart}</a>
		</div>
	</article>

	<script>
		const self = this;
		const contentKeys = [
			'id',
			'caption',
			'title',
			'date',
			'type',
			'url',
			'photos',
			'photoset_layout',
			'reblog_key',
		];

		self.title = '';
		self.heart = 'heartempty';
		// open Modal
		self.openModal = Action.openModal;

		// photoset関係
		self.isPhotoSet = false;
		self.photoset = null;
		self.layout = [];
		let isLayoutBinded = false;

		// photosetの配列にエレメントをキャッシュする
		const bindPhotoset = () => {
			// containerを取得し、行ごとにforEach
			self.refs.rowContainer.forEach((row, rowIndex) => {
				// 行内にある画像要素を取得し、forEach
				const photos = [].slice.call(row.getElementsByTagName('figure'));
				photos.forEach((photo, photoIndex) => {
					// 取得した要素に対応する配列内のObjectを引き当てる
					const photo_in_arr = self.photoset[rowIndex][photoIndex];
					// Objectに取得した要素を挿入する
					photo_in_arr.element = photo;
				});
			});
			// finally
			isLayoutBinded = true;
		};

		const setPhotosetSize = () => {
			if (!self.isPhotoSet) return;
			console.log('setPhotosetSize is called.');
			// 画面幅を取得
			const rowWidth = self.refs.rowContainer[0].getBoundingClientRect().width;

			// データに要素がバインドされた形跡がなければバインドしてくる
			if (!isLayoutBinded) bindPhotoset();

				// let mostLowHeight = null;
				// row.style.height = mostLowHeight + 'px';

				// 3.rowごとに画像の取りうる幅を計算
				// 4.アスペクト比を計算して高さをセットする
			// row is Element

		};

		// レイアウトに応じて行ごと画像をセットする
		const getPhotoLayout = () => {
			if (!self.isPhotoSet) return;

			// レイアウトの解釈を行う
			self.layout = self.photoset_layout.split('');
			const photoset = [];
			let photoIndex = 0;

			// 配列に画像を挿入する
			self.layout.forEach((itemPerRow, row) => {
				const photosInRow = [];
				for (let i = parseInt(itemPerRow, 10); i > 0; i -=1) {
					const photo = self.photos[photoIndex];
					photosInRow.push(photo);
					photoIndex += 1;
				}
				photoset.push(photosInRow);
			});
			return photoset;
		}

		const afterUpdate = () => {
			if (!self.isPhotoSet) return;

			setPhotosetSize();
		}

		self.on('updated', Action.setLoader );
		self.on('before-mount', Action.showLoader );
		self.on('mount', () => {
			window.addEventListener('resize', setPhotosetSize);
		});

		self.on('unmount', () => {
			RiotControl.off(Store.ActionTypes.changed);
			window.removeEventListener('resize', setPhotosetSize);
		});
		// Subscribes Store.onChanged
		RiotControl.on(Store.ActionTypes.changed, () => {
			const content = Store.content[0];
			contentKeys.forEach(key => { self[key] = content[key] });
			self.caption = self.caption.replace(/<h2>.+<\/h2>/, '')

			// photosが複数であればphososetであると判断
			self.isPhotoSet = (self.photos.length > 1);
			self.photoset = (self.isPhotoSet)  ? getPhotoLayout() : null;

			self.update();
			afterUpdate();
		});
	</script>
	<style type="text/scss">
		/*photo*/
		.photo {
			max-width: 800px;
			margin: 0 auto;
			border-radius: 2px;
			overflow: hidden;
			text-align: center;
		}
		/*photoset container*/
		.photo_rowContainer {
			height: 400px;
			overflow: hidden;
			line-height: 1;
			font-size: 0;
		}
		.photo_item {
			display: block;
			width: 100%;
			height: 100%;
			/*kill inner space*/
			line-height: 1;
			font-size: 0;
		}
		.photo_item-set {
			display: inline-block;
			.layout_itemCount-2 & {
				width: 50%;
			}
			.layout_itemCount-3 & {
				width: 33%;
			}
		}
		.photo_item_image {
			width: 100%;
			height: 100%;
			background: center center no-repeat;
			background-size: cover;
		}

		/*text*/
		.post_text {
			max-width: 800px;
			min-width: 25em;
			margin: 4vw auto 0;
			padding: 2em;
			box-sizing: border-box;
			border-radius: 2px;
			background-color: #3dffcf;
			font-size: 1.4em;
			line-height: 1.75em;
			letter-spacing: 0.1em;
		}
		.post_meta {
			max-width: 800px;
			min-width: 25em;
			margin: 2vw auto 0;
			font-size: 1.3em;
			a {
				text-decoration: none;
				font-size: 2em;
				margin-right: 0.5em;
			}
			.reblog { color: #222; }
			.like { color: #c22; }
		}
		@media screen and (max-width: 37.5em) {
			.post_title {
				font-size: 2.2em;
			}
			.post_text {
				font-size: 1.4em;
			}
		}
	</style>
</niltea-post>