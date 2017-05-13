import RiotControl from 'riotcontrol';

import Store from '../Store/Store';
<niltea-post>
	<article class="post post-single">
		<h2 class="post_title">{title}</h2>
		<!-- Photo -->
		<section class="photo" if={photos} ref='photo'>

			<a class="photo_item photo_item-single" if={!isPhotoSet} each={photos} href='{original_size.url}'>
				<img src="{alt_sizes[0].url}" alt="" ref='photoItem'>
			</a>
			<div if={isPhotoSet} each={row in photoset} class="photo_rowContainer layout_itemCount-{row.length}" ref='rowContainer'>
				<a class="photo_item photo_item-set" each={row} href='{original_size.url}'>
					<img src="{alt_sizes[0].url}" alt="" ref='photoItem'>
				</a>
			</div>
		</section>
		<section class='post_text'><raw content='{caption}' /></section>
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
		self.heart = 'heartempty';

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
			this.caption = this.caption.replace(/<h2>(?:[a-zA-Z/d々〇〻ぁ-んァ-ヶー\u3400-\u9FFF\uF900-\uFAFF]|[\uD840-\uD87F][\uDC00-\uDFFF])+<\/h2>/, '')

			// photosが複数であればphososetであると判断
			self.isPhotoSet = (self.photos.length > 1);
			if (self.isPhotoSet) self.photoset = setPhotoLayout();
			self.update();
			afterUpdate();
		});
	</script>
	<style type="text/scss">
		.post_title {
			margin-bottom: 2em;
			margin-bottom: 6vw;
			text-align: center;
			font-weight: 500;
			font-size: 2.8em;
		}

		/*photo*/
		.photo {
			text-align: center;
		}
		.photo_item {
			display: block;
			width: 100%;
			/*kill inner space*/
			line-height: 1;
			font-size: 0;
		}
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
			border-radius: 2px;
			background-color: #3dffcf;
			margin: 6vw auto 0;
			width: 60%;
			padding: 2em;
			min-width: 25em;
			font-size: 1.6em;
			line-height: 1.75em;
			letter-spacing: 0.1em;
		}
		.post_meta {
			margin: 3vw auto 0;
			font-size: 1.3em;
			width: 60%;
			min-width: 25em;
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