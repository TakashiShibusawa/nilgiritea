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
			// containerを取得し、photoSetでなければコンテナを配列に突っ込んでおく
			const rowContainer = (self.isPhotoSet) ? self.refs.rowContainer : [self.refs.rowContainer];
			// 行ごとにforEach
			rowContainer.forEach((row, rowIndex) => {
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

		const setPhotoSize = () => {
			if (!self.photos) return;

			// photoSetでなければコンテナを配列に突っ込んでおく
			const rowContainer = (self.isPhotoSet) ? self.refs.rowContainer : [self.refs.rowContainer];
			// 画面幅を取得
			const rowWidth = rowContainer[0].getBoundingClientRect().width;

			// データに要素がバインドされた形跡がなければバインドしてくる
			if (!isLayoutBinded) bindPhotoset();

			// photosetの行ごとにforEach
			self.photoset.forEach((row, rowIndex) => {
				// 画像1枚当たりの幅を計算
				const fitWidth = ~~(rowWidth / row.length);
				let lowest = null;
				// 行内の画像ごとにforEach：倍率を計算して高さをセットする
				row.forEach(photo => {
					const width  = photo.original_size.width;
					const height = photo.original_size.height;
					// 画像表示倍率の計算
					const imgMag = fitWidth / width;
					// 画像高さを計算
					const fitHeight = ~~(height * imgMag);

					// 画像高さの更新：低い方にあわせる
					if (lowest === null || lowest > fitHeight) lowest = fitHeight;
				});
				rowContainer[rowIndex].style.height = lowest + 'px';
			});
		};

		// レイアウトに応じて行ごと画像をセットする
		const getPhotoLayout = () => {
			// レイアウトの解釈を行う
			if (!self.photoset_layout) self.photoset_layout = '1';
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
			setPhotoSize();
		}

		self.on('updated', Action.setLoader );
		self.on('before-mount', Action.showLoader );
		self.on('mount', () => {
			window.addEventListener('resize', setPhotoSize);
		});

		self.on('unmount', () => {
			RiotControl.off(Store.ActionTypes.changed);
			window.removeEventListener('resize', setPhotoSize);
		});
		// Subscribes Store.onChanged
		RiotControl.on(Store.ActionTypes.changed, () => {
			const content = Store.content[0];
			contentKeys.forEach(key => { self[key] = content[key] });
			self.caption = self.caption.replace(/<h2>.+<\/h2>/, '')

			// photosが複数であればphososetであると判断
			self.isPhotoSet = (self.photos.length > 1);
			self.photoset = (self.photos) ? getPhotoLayout() : null;

			self.update();
			afterUpdate();
		});
	</script>
</niltea-post>