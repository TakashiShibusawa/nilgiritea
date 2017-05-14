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
				<a class="photo_item photo_item-single" if={!isPhotoSet} each={photos} href='{original_size.url}' onclick={this.openModal}>
					<img src="{alt_sizes[0].url}" alt="" ref='photoItem'>
				</a>
			</div>
			<!-- set -->
			<div if={isPhotoSet} each={row in photoset} class="photo_rowContainer layout_itemCount-{row.length}" ref='rowContainer'>
				<a class="photo_item photo_item-set" each={row} href='{original_size.url}' onclick={this.openModal}>
					<img src="{alt_sizes[0].url}" alt="" ref='photoItem'>
				</a>
			</div>
		</section>
		<section class='post_text' if={caption} onclick={this.openModal}><raw content='{caption}' /></section>
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
		self.isPhotoSet = false;
		self.title = '';
		self.heart = 'heartempty';
		// open Modal
		self.openModal = Action.openModal;

		const layoutPhotoset = () => {
			const layout = self.photoset_layout.split('');
			
			self.refs.rowContainer.forEach(row => {
				let mostLowHeight = null;
				const photos = [].slice.call(row.getElementsByTagName('img'));
				photos.forEach(photo => {
					const height = photo.height;
					if (mostLowHeight === null || mostLowHeight > height) mostLowHeight = height;
				})
				row.style.height = mostLowHeight + 'px';
			});

		};

		// レイアウトに応じて行ごと画像をセットする
		const setPhotoLayout = () => {
			if (!self.isPhotoSet) return;
			const photoset = [];
			const layout = self.photoset_layout.split('');
			let photoIndex = 0;
			layout.forEach((itemPerRow, row) => {
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

			// photosetの画像全て読み込み完了後にレイアウトをセットする
			const photoCount = self.refs.photoItem.length;
			let loadedCount = 0;
			self.refs.photoItem.forEach(photo => {
				photo.addEventListener('load', () => {
					loadedCount += 1;
					if (loadedCount >= photoCount) layoutPhotoset();
				})
			})
		}

		self.on('updated', Action.setLoader );
		self.on('before-mount', Action.showLoader );
		self.on('mount', () => {
			window.addEventListener('resize', layoutPhotoset);
		});

		self.on('unmount', () => {
			RiotControl.off(Store.ActionTypes.changed);
			window.removeEventListener('resize', layoutPhotoset);
		});
		// Subscribes Store.onChanged
		RiotControl.on(Store.ActionTypes.changed, () => {
			const content = Store.content[0];
			contentKeys.forEach(key => { self[key] = content[key] });
			self.caption = self.caption.replace(/<h2>.+<\/h2>/, '')

			// photosが複数であればphososetであると判断
			self.isPhotoSet = (self.photos.length > 1);
			if (self.isPhotoSet) self.photoset = setPhotoLayout();

			document.title = `${self.title} | ${Store.blogInfo.title}`;
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
		.photo_item {
			display: block;
			width: 100%;
			/*kill inner space*/
			line-height: 1;
			font-size: 0;
		}
		/*photoset container*/
		.photo_rowContainer {
			overflow: hidden;
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
		img {
			width: 100%;
			vertical-align: top;
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